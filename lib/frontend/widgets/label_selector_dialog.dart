import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/widgets/loadin_widget.dart';
import 'package:flutter/material.dart';

class LabelSelectorDialog extends StatefulWidget {
  final Future<List<Label>> Function() loadLabels;
  final Future<void> Function(Label label) onLabelSelect;
  final Future<void> Function() onNewLabel;
  const LabelSelectorDialog(
      {super.key,
      required this.loadLabels,
      required this.onLabelSelect,
      required this.onNewLabel});

  @override
  State<LabelSelectorDialog> createState() => _LabelSelectorDialogState();
}

class _LabelSelectorDialogState extends State<LabelSelectorDialog> {
  bool isLoading = false;
  List<Label> labels = [];

  @override
  Widget build(BuildContext context) {
    widget.loadLabels().then((res) {
      setState(() {
        labels = res;
      });
    });
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
                      for (int i = 0; i < labels.length; i++)
                        MaterialButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: const BorderSide(
                                    color: Colors.black, width: 0.5)),
                            onPressed: () async {
                              setState(() {
                                isLoading = true;
                              });
                              await widget.onLabelSelect(labels[i]);
                              setState(() {
                                isLoading = false;
                              });
                            },
                            child: isLoading
                                ? const LoadinWidget(width: 30)
                                : Text(labels[i].name)),
                      MaterialButton(
                          color: const Color.fromARGB(101, 231, 231, 231),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: const BorderSide(
                                  color: Colors.black, width: 0.5)),
                          onPressed: () async {
                            setState(() {
                              isLoading = true;
                            });
                            await widget.onNewLabel();
                            setState(() {
                              isLoading = false;
                            });
                          },
                          child: isLoading
                              ? const LoadinWidget(width: 30)
                              : const Text("+")),
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
