import 'package:arfoon_note/repositories/label.dart';
import 'package:arfoon_note/widgets/create_label_dialog.dart';
import 'package:flutter/material.dart';

class SidebarLabels extends StatefulWidget {
  final List<Label> labels;
  final Future<void> Function() loadLabels;
  const SidebarLabels(
      {super.key, required this.labels, required this.loadLabels});

  @override
  State<SidebarLabels> createState() => _SidebarLabelsState();
}

class _SidebarLabelsState extends State<SidebarLabels> {
  @override
  void initState() {
    super.initState();
  }

  void showCreateLabel(int index) {
    Label label = widget.labels[index];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateLabelDialog(
            label: label,
            isNew: false,
            loadLabels: widget.loadLabels,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            "Labels",
            style: TextStyle(color: Color.fromARGB(96, 0, 0, 0)),
          ),
          if (widget.labels.isEmpty)
            const Text("No labels available")
          else
            for (int i = 0; i < widget.labels.length; i++)
              MaterialButton(
                onPressed: () {
                  showCreateLabel(i);
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        // Image.asset('assets/images/notes.png'),
                        const Icon(Icons.text_snippet),
                        Text(widget.labels[i].name),
                      ],
                    ),
                    const Icon(Icons.edit),
                  ],
                ),
              )
        ],
      ),
    );
  }
}
