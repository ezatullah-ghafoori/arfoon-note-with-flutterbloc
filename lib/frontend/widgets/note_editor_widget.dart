import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/bloc/app_bloc.dart';
import 'package:arfoon_note/frontend/widgets/label_selector_dialog.dart';
// import 'package:arfoon_note/frontend/widgets/note_editor_bottom_bar.dart';
import 'package:arfoon_note/server/note_server.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class NoteEditorWidget extends StatefulWidget {
  final Note note;
  final void Function(int color) setBgColor;
  const NoteEditorWidget(
      {super.key, required this.note, required this.setBgColor});

  @override
  State<NoteEditorWidget> createState() => _NoteEditorWidgetState();
}

class _NoteEditorWidgetState extends State<NoteEditorWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();

  double colorPalatePostiotion = -350;
  List<Color> colors = [Colors.amber, Colors.blue, Colors.white, Colors.pink];
  bool isEdited = false;
  late String dir;
  late Isar isar;
  late NoteServer noteServer;
  bool isInitialized = false;

  Future<void> handleOntitleChange(AppBloc appBloc) async {
    widget.note.title = _titleController.text;
    setState(() {
      isEdited = true;
    });
  }

  Future<void> handleOndetialsChange(AppBloc appBloc) async {
    widget.note.details = _detailsController.text;
    setState(() {
      isEdited = true;
    });
  }

  Future<void> saveNote() async {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    // await noteServer.notes.insert(widget.note);
    await isar.writeTxn(() async {
      return await isar.notes.put(widget.note);
    });
    appBloc.add(AppLoadNotes());
  }

  Future<void> loadAsyncInstance() async {
    final String docDir = (await getApplicationDocumentsDirectory()).path;
    final Isar isarInstance = await openIsar(docDir);
    final NoteServer noteServerInstance = NoteServer.instance(isarInstance);

    setState(() {
      dir = docDir;
      isar = isarInstance;
      noteServer = noteServerInstance;
      isInitialized = true;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _detailsController.dispose();
    if (isar.isOpen) {
      isar.close();
    }
    super.dispose();
  }

  void addLabelToNote(Label label) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    // Create a growable copy of labelIds
    List<int> updatedLabelIds = List<int>.from(widget.note.labelIds);

    // Check if the label is already in the list
    if (updatedLabelIds.contains(label.id)) {
      updatedLabelIds.remove(label.id); // Remove the label
    } else {
      updatedLabelIds.add(label.id!.toInt()); // Add the label
    }

    // Update the note's labels
    widget.note.labelIds = updatedLabelIds;

    // Update the note on the server
    noteServer.notes.updateLabel(widget.note);

    // Reload notes to reflect changes
    appBloc.add(AppLoadNotes());
  }

  void showSelectLabel() {
    final labels = BlocProvider.of<AppBloc>(context).state.labels;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LabelSelectorDialog(
            addLabelToNote: addLabelToNote,
            labels: labels,
          );
        });
  }

  @override
  void initState() {
    loadAsyncInstance();
    _titleController.text = widget.note.title ?? "";
    _detailsController.text = widget.note.details ?? "";
    super.initState();
  }

  void hideColorPicker() {
    setState(() {
      if (colorPalatePostiotion == -350) {
        colorPalatePostiotion = 0;
      } else {
        colorPalatePostiotion = -350;
      }
    });
  }

  Future<bool?> existPopup() {
    return showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("You have unsaved changes!"),
            content: const Text("What do you want to do?"),
            actions: [
              TextButton(
                  onPressed: () async {
                    try {
                      await saveNote();
                    } catch (e) {
                      Navigator.pop(context, false);
                    }
                    Navigator.pop(context, true);
                  },
                  child: const Text("Save and Leave")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, true);
                  },
                  child: const Text("Don't save")),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context, false);
                  },
                  child: const Text("Stay")),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    final AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    final noteLabels = appBloc.state.labels
        .where((label) => widget.note.labelIds.contains(label.id))
        .toList();
    return PopScope(
      canPop: !isEdited,
      onPopInvokedWithResult: (bool didPop, Object? result) async {
        if (didPop) {
          return;
        }
        final dynamic shouldPop = await existPopup() ?? false;
        if (context.mounted && shouldPop) {
          Navigator.pop(context);
        }
      },
      child: Container(
        color: Color(widget.note.colorId ?? Colors.white.value),
        child: Stack(children: [
          SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 50),
            child: !isInitialized
                ? const Text("Loading")
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                            "Updated at ${DateFormat('MMM dd').format(DateTime.now())}"),
                        TextField(
                          style: const TextStyle(fontSize: 33),
                          decoration: const InputDecoration(
                            hintText: "Untitled",
                            border: InputBorder.none,
                          ),
                          controller: _titleController,
                          onChanged: (value) {
                            handleOntitleChange(appBloc);
                          },
                        ),
                        TextField(
                          decoration: const InputDecoration(
                              hintText: "No detials provided....",
                              border: InputBorder.none),
                          controller: _detailsController,
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            handleOndetialsChange(appBloc);
                          },
                        ),
                      ],
                    ),
                  ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Color(widget.note.colorId ?? Colors.white.value),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                            for (int i = 0; i < noteLabels.length; i++)
                              TextButton(
                                  onPressed: () {
                                    addLabelToNote(noteLabels[i]);
                                  },
                                  child: Text(noteLabels[i].name)),
                            TextButton(
                                onPressed: showSelectLabel,
                                child: const Text("Create Label")),
                          ],
                        ),
                      ),
                    ),
                    IconButton(
                        onPressed: hideColorPicker,
                        icon: const Icon(Icons.color_lens))
                  ],
                ),
              )),
          AnimatedPositioned(
              bottom: colorPalatePostiotion,
              right: 0,
              left: 0,
              height: 200,
              duration: const Duration(milliseconds: 300),
              child: Container(
                color: const Color.fromARGB(99, 158, 158, 158),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Expanded(child: SizedBox()),
                        IconButton(
                            onPressed: () {
                              hideColorPicker();
                            },
                            icon: const Icon(Icons.close))
                      ],
                    ),
                    Row(
                      children: [
                        for (int i = 0; i < colors.length; i++)
                          Container(
                            margin: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                                color: colors[i],
                                borderRadius: BorderRadius.circular(50)),
                            child: TextButton(
                                onPressed: () {
                                  hideColorPicker();
                                  setState(() {
                                    widget.note.colorId = colors[i].value;
                                    isEdited = true;
                                  });
                                  widget.setBgColor(colors[i].value);
                                },
                                child: const Text("")),
                          )
                      ],
                    ),
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}
