import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/widgets/create_label_dialog.dart';
import 'package:flutter/material.dart';

class SidebarLabels extends StatefulWidget {
  const SidebarLabels({super.key});

  @override
  State<SidebarLabels> createState() => _SidebarLabelsState();
}

class _SidebarLabelsState extends State<SidebarLabels> {
  @override
  void initState() {
    super.initState();
  }

  void showCreateLabel(int index, List<Label> labels) async {
    Label label = labels[index];
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateLabelDialog(
            name: "New Label",
            onDelete: (name) async {},
            onSubmit: (name) async {},
          );
        });
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
            // if (state.labels.isEmpty)
            const Text("No labels available"),
            // else
            // for (int i = 0; i < state.labels.length; i++)
            MaterialButton(
              onPressed: () {
                // showCreateLabel(i, state.labels);
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      // Image.asset('assets/images/notes.png'),
                      Icon(Icons.text_snippet),
                      // Text(state.labels[i].name),
                    ],
                  ),
                  Icon(Icons.edit),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
