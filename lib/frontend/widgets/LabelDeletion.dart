import 'package:arfoon_note/client/client.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Labeldeletion extends StatefulWidget {
  final int index;
  const Labeldeletion({super.key, required this.index});

  @override
  State<Labeldeletion> createState() => _LabeldeletionState();
}

class _LabeldeletionState extends State<Labeldeletion> {
  Future<void> deleteLabel() async {
    final dir = (await getApplicationDocumentsDirectory()).path;
    final isar = await openIsar(dir);
    await isar.writeTxn(() async {
      await isar.labels.delete(widget.index);
    });

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
