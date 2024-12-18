import 'package:arfoon_note/server/models/label.dart';
import 'package:arfoon_note/server/isar_service.dart';
import 'package:arfoon_note/frontend/widgets/LabelDeletion.dart';
import 'package:flutter/material.dart';

class CreateLabelDialog extends StatefulWidget {
  final Label label;
  final bool isNew;
  final Future<void> Function() loadLabels;
  const CreateLabelDialog(
      {super.key,
      required this.label,
      required this.isNew,
      required this.loadLabels});

  @override
  State<CreateLabelDialog> createState() => _CreateLabelDialogState();
}

class _CreateLabelDialogState extends State<CreateLabelDialog> {
  late TextEditingController _labelController;
  final isar = IsarService().isar;
  Future<void> creatLabel() async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.labels.put(widget.label);
    });
    widget.loadLabels();
    Navigator.pop(context);
  }

  Future<void> deleteLabel() async {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Labeldeletion(
            index: widget.label.id,
            updateLabels: widget.loadLabels,
          );
        });
  }

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.label.name);
  }

  // we are using the dispose function to remove when we move out from the screen
  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
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
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  widget.isNew ? 'New Label' : "Update Label",
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  decoration: const InputDecoration(
                      hintText: "A Creative Label Name",
                      labelText: "Label Name",
                      border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black, width: 0.5))),
                  controller: _labelController,
                  onChanged: (value) {
                    widget.label.name = value;
                    _labelController.text = value;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor: widget.isNew
                              ? const Color.fromARGB(155, 37, 37, 37)
                              : const Color.fromARGB(255, 37, 37, 37)),
                      onPressed: widget.isNew ? null : deleteLabel,
                      child: const Text("Delete"),
                    ),
                    FilledButton(
                      style: FilledButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          foregroundColor:
                              const Color.fromARGB(255, 255, 255, 255)),
                      onPressed: creatLabel,
                      child: Text(widget.isNew ? "Create" : "Update"),
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
