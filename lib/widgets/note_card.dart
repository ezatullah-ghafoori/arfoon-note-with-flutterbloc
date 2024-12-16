import 'package:arfoon_note/repositories/note.dart';
import 'package:arfoon_note/screens/note.dart';
import 'package:arfoon_note/services/isar_service.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

typedef LoadNotesCallaback = Future<void> Function(); // Define a callback type

// TODO: Make Card Raduise 20 px

class NoteCard extends StatefulWidget {
  final NoteItem noteItem;
  final LoadNotesCallaback loadNotesCallaback;
  final Future<void> Function() loadLabels;

  const NoteCard(
      {super.key,
      required this.noteItem,
      required this.loadNotesCallaback,
      required this.loadLabels});

  @override
  State<NoteCard> createState() => _NoteCardState();
}

class _NoteCardState extends State<NoteCard> {
  final isar = IsarService().isar;

  void saveChanges() async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.noteItems.put(widget.noteItem);
    });
    await widget.loadNotesCallaback();
  }

  void onDelete() async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.noteItems.delete(widget.noteItem.id);
    });
    widget.loadNotesCallaback();
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.noteItem.id.toString()),
      onDismissed: (direction) => onDelete(),
      child: InkWell(
        onTap: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Note(
                        note: widget.noteItem,
                        loadNotes: widget.loadNotesCallaback,
                        loadLabels: widget.loadLabels,
                      )));
          widget.loadNotesCallaback();
        },
        child: Card(
          color: Color(widget.noteItem.color),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 4,
          child: Container(
            // width: 300,
            // height: 200,
            margin: const EdgeInsets.only(top: 5, bottom: 5),
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Transform.translate(
                      offset: Offset(0, -10),
                      child: Text(DateFormat('MMM dd')
                          .format(widget.noteItem.lastUpdate)),
                    ),
                    IconButton(
                        onPressed: () {
                          setState(() {
                            widget.noteItem.pinned = !widget.noteItem.pinned;
                          });
                          saveChanges();
                        },
                        color: widget.noteItem.pinned
                            ? Colors.white
                            : const Color.fromARGB(255, 2, 1, 24),
                        style: IconButton.styleFrom(
                            backgroundColor: widget.noteItem.pinned
                                ? const Color.fromARGB(255, 2, 1, 24)
                                : Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        icon: Transform.rotate(
                            angle: 120,
                            child: const Icon(Icons.push_pin_rounded))),
                  ],
                ),
                Text(
                  widget.noteItem.title.length > 20
                      ? "${widget.noteItem.title.substring(0, 20)}..."
                      : widget.noteItem.title,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.bold),
                ),
                Text(widget.noteItem.content),
                Wrap(
                  direction: Axis.horizontal,
                  spacing: 8,
                  children: [
                    for (int i = 0; i < widget.noteItem.labels.length; i++)
                      Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0)),
                          child: Text(widget.noteItem.labels.toList()[i].name))
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
