import 'package:arfoon_note/server/models/label.dart';
import 'package:arfoon_note/server/isar_service.dart';
import 'package:flutter/material.dart';

class Labeldeletion extends StatefulWidget {
  final Future<void> Function() updateLabels;
  final int index;
  const Labeldeletion(
      {super.key, required this.index, required this.updateLabels});

  @override
  State<Labeldeletion> createState() => _LabeldeletionState();
}

class _LabeldeletionState extends State<Labeldeletion> {
  Future<void> deleteLabel() async {
    final isar = await IsarService().isar;
    await isar.writeTxn(() async {
      await isar.labels.delete(widget.index);
    });
    widget.updateLabels();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Are you sure you want to Delete?",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                    "Once Deleted a Label cannot be undone, are you sure and want to Delete?"),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor:
                              const Color.fromARGB(255, 37, 37, 37)),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Concel"),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255)),
                      onPressed: deleteLabel,
                      child: const Text("Delete"),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
