import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/features/note/note_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NoteCardWidget extends StatefulWidget {
  final Note note;
  final Future<List<Label>> Function() getLabels;
  const NoteCardWidget({
    super.key,
    required this.note,
    required this.getLabels,
  });

  @override
  State<NoteCardWidget> createState() => _NoteCardWidgetState();
}

class _NoteCardWidgetState extends State<NoteCardWidget> {
  List<Label> noteLabels = [];

  Future<void> loadNoteLabels() async {
    List<Label> labels = await widget.getLabels();
    setState(() {
      noteLabels = labels
          .where((label) => widget.note.labelIds.contains(label.id))
          .toList();
    });
  }

  @override
  void initState() {
    loadNoteLabels();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (BuildContext context) => NoteView(
                      onSettingTap: () async {},
                      loadLabels: () async {
                        return [];
                      },
                      onLabelDelete: (int? labelId) async {},
                      onNoteSave: (Note note) async {},
                      note: widget.note,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
            elevation: 4,
            color: Color(widget.note.colorId ?? Colors.white.value),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(DateFormat("MMM dd").format(DateTime.now())),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(Icons.push_pin_sharp))
                    ],
                  ),
                  Text(
                    widget.note.title ?? "",
                    style: const TextStyle(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                  if (widget.note.details != null) Text(widget.note.details!),
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 8,
                    children: [
                      if (widget.note.labelIds.isNotEmpty &&
                          noteLabels.isNotEmpty)
                        for (int i = 0; i < widget.note.labelIds.length; i++)
                          Container(
                            padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                            margin: const EdgeInsets.only(top: 10),
                            decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(noteLabels[i].name),
                          )
                    ],
                  )
                ],
              ),
            )),
      ),
    );
  }
}
