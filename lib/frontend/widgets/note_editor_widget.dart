import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/widgets/content_loading_widget.dart';
import 'package:arfoon_note/frontend/widgets/label_selector_dialog.dart';
// import 'package:arfoon_note/frontend/widgets/note_editor_bottom_bar.dart';
import 'package:arfoon_note/server/note_server.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class NoteEditorWidget extends StatefulWidget {
  final Note note;
  final Future<List<Label>> Function() loadLabels;
  final List<int>? colorSet;
  final void Function(int color) setBgColor;
  final Future<void> Function(int? labelId) onLabelDelete;
  final Future<void> Function(Note note) onNoteSave;

  const NoteEditorWidget(
      {super.key,
      required this.note,
      required this.setBgColor,
      required this.loadLabels,
      required this.colorSet,
      required this.onLabelDelete,
      required this.onNoteSave});

  @override
  State<NoteEditorWidget> createState() => _NoteEditorWidgetState();
}

class _NoteEditorWidgetState extends State<NoteEditorWidget> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _detailsController = TextEditingController();
  bool isLoading = false;

  double colorPalatePostiotion = -350;
  List<int> colors = [
    Colors.amber.value,
    Colors.blue.value,
    Colors.white.value,
    Colors.pink.value
  ];
  bool isEdited = false;
  late String dir;
  late Isar isar;
  late NoteServer noteServer;
  List<Label> noteLabels = [];

  Future<void> handleOntitleChange() async {
    widget.note.title = _titleController.text;
    setState(() {
      isEdited = true;
    });
  }

  Future<void> handleOndetialsChange() async {
    widget.note.details = _detailsController.text;
    setState(() {
      isEdited = true;
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

  Future<void> addLabelToNote(Label label) async {
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
  }

  void showSelectLabel() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LabelSelectorDialog(
            onLabelSelect: addLabelToNote,
            loadLabels: widget.loadLabels,
            onNewLabel: () async {},
          );
        });
  }

  Color getTextColor(Color backgroundColor) {
    double luminance = backgroundColor.computeLuminance();

    return luminance > 0.5 ? Colors.black : Colors.white;
  }

  void changeNoteColor(int color) {
    widget.setBgColor(color);
  }

  @override
  void didUpdateWidget(covariant NoteEditorWidget oldWidget) {
    colors = widget.colorSet ?? colors;
    _titleController.text = widget.note.title ?? "";
    _detailsController.text = widget.note.details ?? "";
    widget.loadLabels().then((List<Label> labels) {
      setState(() {
        noteLabels = labels
            .where((label) => widget.note.labelIds.contains(label.id))
            .toList();
      });
    });
    super.didUpdateWidget(oldWidget);
  }

  @override
  void initState() {
    colors = widget.colorSet ?? colors;
    _titleController.text = widget.note.title ?? "";
    _detailsController.text = widget.note.details ?? "";
    widget.loadLabels().then((List<Label> labels) {
      setState(() {
        noteLabels = labels
            .where((label) => widget.note.labelIds.contains(label.id))
            .toList();
      });
    });
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
                      await widget.onNoteSave(widget.note);
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
    double screenWidth = MediaQuery.of(context).size.width;
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
            child: isLoading
                ? const ContentLoadingWidget()
                : Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (screenWidth < 1000)
                          Text(
                              style: TextStyle(
                                  color: getTextColor(Color(
                                      widget.note.colorId ??
                                          Colors.white.value))),
                              "Updated at ${DateFormat('MMM dd').format(DateTime.now())}"),
                        TextField(
                          style: TextStyle(
                              fontSize: 33,
                              color: getTextColor(Color(
                                  widget.note.colorId ?? Colors.white.value))),
                          decoration: InputDecoration(
                            hintText: "Untitled",
                            hintStyle: TextStyle(
                                color: getTextColor(Color(widget.note.colorId ??
                                    Colors.white.value))),
                            border: InputBorder.none,
                          ),
                          controller: _titleController,
                          onChanged: (value) {
                            handleOndetialsChange();
                          },
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintText: "No detials provided....",
                              hintStyle: TextStyle(
                                  color: getTextColor(Color(
                                      widget.note.colorId ??
                                          Colors.white.value))),
                              border: InputBorder.none),
                          controller: _detailsController,
                          style: TextStyle(
                              color: getTextColor(Color(
                                  widget.note.colorId ?? Colors.white.value))),
                          maxLines: null,
                          keyboardType: TextInputType.multiline,
                          onChanged: (value) {
                            handleOndetialsChange();
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
                                    widget.onLabelDelete(noteLabels[i].id);
                                  },
                                  child: Text(
                                      style: TextStyle(
                                          color: getTextColor(Color(
                                              widget.note.colorId ??
                                                  Colors.white.value))),
                                      noteLabels[i].name)),
                            TextButton(
                                onPressed: showSelectLabel,
                                child: Text(
                                    style: TextStyle(
                                        color: getTextColor(Color(
                                            widget.note.colorId ??
                                                Colors.white.value))),
                                    "Create Label")),
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
                                color: Color(colors[i]),
                                borderRadius: BorderRadius.circular(50)),
                            child: TextButton(
                                onPressed: () {
                                  hideColorPicker();
                                  changeNoteColor(colors[i]);
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
