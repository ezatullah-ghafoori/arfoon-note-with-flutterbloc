import 'package:arfoon_note/frontend/widgets/loadin_widget.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CreateLabelDialog extends StatefulWidget {
  String? name;
  final Future<void> Function(String name)? onSubmit;
  final Future<void> Function(String? name)? onDelete;
  CreateLabelDialog({super.key, this.name, this.onDelete, this.onSubmit});

  @override
  State<CreateLabelDialog> createState() => _CreateLabelDialogState();
}

class _CreateLabelDialogState extends State<CreateLabelDialog> {
  bool isLoading = false;
  late TextEditingController _labelController;
  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.name);
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
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
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
                    widget.onDelete == null ? 'New Label' : "Update Label",
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
                      widget.name = value;
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
                            foregroundColor: widget.onDelete == null
                                ? const Color.fromARGB(155, 100, 98, 98)
                                : const Color.fromARGB(255, 37, 37, 37)),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await widget.onDelete!(widget.name);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: isLoading
                            ? const LoadinWidget(width: 30)
                            : const Text("Delete"),
                      ),
                      FilledButton(
                        style: FilledButton.styleFrom(
                            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            foregroundColor:
                                const Color.fromARGB(255, 255, 255, 255)),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await widget.onSubmit!(_labelController.text);
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: isLoading
                            ? const LoadinWidget(width: 30)
                            : Text(
                                widget.onDelete == null ? "Create" : "Update"),
                      )
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
