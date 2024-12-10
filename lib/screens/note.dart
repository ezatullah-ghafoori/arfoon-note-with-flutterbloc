import 'package:arfoon_note/repositories/label.dart';
import 'package:arfoon_note/repositories/note.dart';
import 'package:arfoon_note/services/isar_service.dart';
import 'package:arfoon_note/widgets/label_selector_dialog.dart';
import 'package:arfoon_note/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:isar/isar.dart';

class Note extends StatefulWidget {
  NoteItem note;
  final Future<void> Function() loadNotes;
  final Future<void> Function() loadLabels;
  Note(
      {super.key,
      required this.note,
      required this.loadNotes,
      required this.loadLabels});

  @override
  State<Note> createState() => _NoteState();
}

class _NoteState extends State<Note> {
  late TextEditingController _titleController;
  late TextEditingController _contentController;
  bool isEdited = false;
  List<Color> colors = [Colors.amber, Colors.blue, Colors.white, Colors.pink];
  bool isCreatingLabel = false;
  double colorPalatePostiotion = -350;
  final isar = IsarService().isar;
  late IsarLinks<Label> selectedLabels = widget.note.labels;

  Future<void> openLabelSelectrDialog() async {
    final isar = await IsarService().isar;
    final labels = await isar.labels.where().findAll();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return LabelSelectorDialog(
            labels: labels,
            addLabelToNote: handleLabelSubmit,
            loadLabels: widget.loadLabels,
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.note.title);
    _contentController = TextEditingController(text: widget.note.content);
  }

  void handleCreatedLabel() {
    setState(() {
      isCreatingLabel = true;
    });
  }

  void handleCancelLabel() {
    setState(() {
      isCreatingLabel = false;
    });
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

  void handleLabelSubmit(Label label) async {
    final isar = await IsarService().isar;
    isar.writeTxn(() async {
      widget.note.labels.add(label);
      await widget.note.labels.save();
    });
    setState(() {
      isEdited = true;
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void handleTitlechange(String value) async {
    _titleController.text = value;
    widget.note.title = value;
    setState(() {
      isEdited = true;
    });
  }

  void showSettings() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SettingsDialog();
        });
  }

  void saveChanges() async {
    final isar = await this.isar;
    widget.note.lastUpdate = DateTime.now();
    await isar.writeTxn(() async {
      await isar.noteItems.put(widget.note);
    });
  }

  void handleContentchange(String value) async {
    _contentController.text = value;
    widget.note.content = value;
    setState(() {
      isEdited = true;
    });
  }

  void showSettingsMenue() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: Color(widget.note.color),
            child: SizedBox(
              height: 400,
              width: 300,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      "Settings",
                      style: TextStyle(fontSize: 28),
                    ),
                    Container(
                      height: 2,
                      color: Colors.black,
                    )
                  ],
                ),
              ),
            ),
          );
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
                    saveChanges();
                    Navigator.pop(context, true);
                    await widget.loadNotes();
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
  @override
  Widget build(BuildContext context) {
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
      child: Scaffold(
        backgroundColor: Color(widget.note.color),
        appBar: AppBar(
          title: Row(
            children: [
              const Expanded(child: SizedBox()),
              IconButton(
                  onPressed: showSettings,
                  icon: const Icon(Icons.more_vert_rounded))
            ],
          ),
          backgroundColor: Color(widget.note.color),
        ),
        body: Column(
          children: [
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                              "Updated at ${DateFormat('MMM dd').format(widget.note.lastUpdate)}"),
                          TextField(
                            decoration: const InputDecoration(
                              hintText: "Untitled",
                              border: InputBorder.none,
                            ),
                            maxLines: null,
                            style: const TextStyle(fontSize: 32.0),
                            controller: _titleController,
                            onChanged: handleTitlechange,
                          ),
                          TextField(
                            decoration: const InputDecoration(
                                hintText: "Description",
                                border: InputBorder.none),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            controller: _contentController,
                            onChanged: handleContentchange,
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
                          decoration: BoxDecoration(
                              color: Color(widget.note.color),
                              boxShadow: const [
                                BoxShadow(
                                    blurRadius: 5,
                                    color: Color.fromARGB(103, 0, 0, 0),
                                    offset: Offset(0, -2))
                              ]),
                          height: 70,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                if (widget.note.labels.isNotEmpty)
                                  ConstrainedBox(
                                    constraints:
                                        const BoxConstraints(maxWidth: 160),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        children: [
                                          if (widget.note.labels.isNotEmpty)
                                            for (int i = 0;
                                                i < widget.note.labels.length;
                                                i++)
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(2),
                                                margin: const EdgeInsets.all(2),
                                                decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.black,
                                                        width: 1),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10.0)),
                                                child: Text(widget.note.labels
                                                    .toList()[i]
                                                    .name),
                                              ),
                                        ],
                                      ),
                                    ),
                                  ),
                                if (!isCreatingLabel)
                                  IconButton(
                                    onPressed: openLabelSelectrDialog,
                                    icon: const Icon(Icons.add),
                                  ),
                                Transform.translate(
                                  offset: const Offset(0, 0),
                                  child: SizedBox(
                                    width: 100,
                                    child: TextButton(
                                        onPressed: hideColorPicker,
                                        child: ClipRect(
                                          child: Row(
                                            children: [
                                              for (int i = 0;
                                                  i < colors.length;
                                                  i++)
                                                Transform.translate(
                                                    offset:
                                                        Offset(-30.0 * i, 0),
                                                    child: CircleAvatar(
                                                      backgroundColor:
                                                          colors[i],
                                                      child: const Text(""),
                                                    )),
                                            ],
                                          ),
                                        )),
                                  ),
                                )
                              ],
                            ),
                          ))),
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
                                    onPressed: hideColorPicker,
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
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    child: TextButton(
                                        onPressed: () {
                                          hideColorPicker();
                                          setState(() {
                                            widget.note.color = colors[i].value;
                                          });
                                        },
                                        child: const Text("")),
                                  )
                              ],
                            ),
                          ],
                        ),
                      )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
