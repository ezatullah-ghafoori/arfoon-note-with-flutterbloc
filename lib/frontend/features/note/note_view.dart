import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/widgets/loadin_widget.dart';
import 'package:arfoon_note/frontend/widgets/note_editor_widget.dart';
import 'package:flutter/material.dart';

class NoteView extends StatefulWidget {
  final bool isDesktop;
  final Future<List<Label>> Function() loadLabels;
  final Future<void> Function(int? labelId) onLabelDelete;
  final Future<void> Function(Note note) onNoteSave;
  final Future<void> Function() onSettingTap;

  final Note? note;
  final List<int>? colorSet;
  const NoteView(
      {super.key,
      this.note,
      this.colorSet,
      this.isDesktop = false,
      required this.loadLabels,
      required this.onLabelDelete,
      required this.onNoteSave,
      required this.onSettingTap});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  int bgColor = Colors.white.value;
  Note note = Note(labelIds: []);
  bool isLoading = false;

  void setBgColor(int color) {
    setState(() {
      bgColor = color;
      note.colorId = color;
    });
  }

  @override
  void initState() {
    setState(() {
      note = widget.note ?? note;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: widget.note?.colorId != null
            ? Color(widget.note!.colorId!)
            : Color(bgColor),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            if (!widget.isDesktop)
              IconButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await widget.onSettingTap();
                    setState(() {
                      isLoading = false;
                    });
                  },
                  icon: const Icon(Icons.more_vert_rounded))
            else
              TextButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    await widget.onNoteSave(note);
                    setState(() {
                      isLoading = false;
                    });
                  },
                  style: TextButton.styleFrom(
                      backgroundColor: Colors.black,
                      foregroundColor: Colors.white),
                  child: isLoading
                      ? const LoadinWidget(width: 20)
                      : const Text("Save"))
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: NoteEditorWidget(
              colorSet: widget.colorSet,
              note: note,
              loadLabels: widget.loadLabels,
              setBgColor: setBgColor,
              onLabelDelete: (int? labelId) async {},
              onNoteSave: widget.onNoteSave,
            ),
          )
        ],
      ),
    );
  }
}
