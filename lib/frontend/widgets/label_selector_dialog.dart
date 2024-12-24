import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/widgets/create_label_dialog.dart';
import 'package:flutter/material.dart';

class LabelSelectorDialog extends StatefulWidget {
  final List<Label> labels;
  final void Function(Label label) addLabelToNote;
  const LabelSelectorDialog({
    super.key,
    required this.labels,
    required this.addLabelToNote,
  });

  @override
  State<LabelSelectorDialog> createState() => _LabelSelectorDialogState();
}

class _LabelSelectorDialogState extends State<LabelSelectorDialog> {
  void showCreateLabel() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateLabelDialog(
            onSubmit: (name) async {},
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    print(widget.labels);
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 220,
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Select Label",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Wrap(
                    spacing: 8,
                    children: [
                      for (int i = 0; i < widget.labels.length; i++)
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.black, width: 0.5)),
                            onPressed: () {
                              widget.addLabelToNote(widget.labels[i]);
                              Navigator.pop(context);
                            },
                            child: Text(widget.labels[i].name)),
                      MaterialButton(
                          color: const Color.fromARGB(101, 231, 231, 231),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.black, width: 0.5)),
                          onPressed: () {
                            showCreateLabel();
                          },
                          child: const Text("+")),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
