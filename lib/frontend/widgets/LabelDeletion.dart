import 'package:arfoon_note/frontend/widgets/loadin_widget.dart';
import 'package:flutter/material.dart';

class Labeldeletion extends StatefulWidget {
  final String title;
  final String subTitle;
  final Future<void> Function() onSure;
  final Future<void> Function() onCancel;
  const Labeldeletion(
      {super.key,
      required this.title,
      required this.subTitle,
      required this.onSure,
      required this.onCancel});

  @override
  State<Labeldeletion> createState() => _LabeldeletionState();
}

class _LabeldeletionState extends State<Labeldeletion> {
  bool isLoading = false;

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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    widget.title,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(widget.subTitle),
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
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          await widget.onCancel();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: const Text("Concel"),
                      ),
                      const Expanded(
                        child: SizedBox(),
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
                          await widget.onSure();
                          setState(() {
                            isLoading = false;
                          });
                        },
                        child: isLoading
                            ? const LoadinWidget(width: 30)
                            : const Text("Delete it."),
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
