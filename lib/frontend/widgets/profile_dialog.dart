import 'package:arfoon_note/frontend/widgets/loadin_widget.dart';
import 'package:flutter/material.dart';

class ProfileDialog extends StatefulWidget {
  final Future<void> Function(String name) onSubmit;
  String name;
  ProfileDialog(
      {super.key, this.name = "Create Account", required this.onSubmit});

  @override
  State<ProfileDialog> createState() => _ProfileDialogState();
}

class _ProfileDialogState extends State<ProfileDialog> {
  bool isLoading = false;
  late TextEditingController _nameController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.name);
  }

  // we are using the dispose function to remove when we move out from the screen
  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10)),
          height: 420,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                Image.asset("assets/images/logo.png"),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Welcome to Arfoon Note",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.all(10),
                  child: TextField(
                    decoration: const InputDecoration(
                        labelText: "Your Full Name",
                        border: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black, width: 0.5))),
                    controller: _nameController,
                    onChanged: (value) {
                      widget.name = value;
                      _nameController.text = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FilledButton(
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
                        await widget.onSubmit(_nameController.text);
                        setState(() {
                          isLoading = false;
                        });
                      },
                      child: isLoading
                          ? const LoadinWidget(width: 30)
                          : const Text("Continue")),
                ),
                const Text(
                  "By using the Arfoon Note App you agreed to Terms of Service and Provicy Policy",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 10, color: Color.fromARGB(255, 189, 188, 188)),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
