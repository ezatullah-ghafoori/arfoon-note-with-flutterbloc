import 'package:arfoon_note/client/client.dart';
import 'package:flutter/material.dart';

class SidebarLabels extends StatefulWidget {
  final Future<void> Function(Label label) onLabelUpdate;
  final Future<void> Function(Label label) onLabelClick;
  final List<Label> labels;
  const SidebarLabels(
      {super.key,
      required this.labels,
      required this.onLabelClick,
      required this.onLabelUpdate});

  @override
  State<SidebarLabels> createState() => _SidebarLabelsState();
}

class _SidebarLabelsState extends State<SidebarLabels> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              "Labels",
              style: TextStyle(color: Color.fromARGB(96, 0, 0, 0)),
            ),
            if (widget.labels.isEmpty) const Text("No labels available"),
            // else
            for (int i = 0; i < widget.labels.length; i++)
              MaterialButton(
                onPressed: () {
                  widget.onLabelClick(widget.labels[i]);
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
                    IconButton(
                        onPressed: () {
                          widget.onLabelUpdate(widget.labels[i]);
                        },
                        icon: const Icon(Icons.edit))
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }
}
