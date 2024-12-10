import 'package:arfoon_note/repositories/user.dart';
import 'package:arfoon_note/services/isar_service.dart';
import 'package:flutter/material.dart';

class CreateUserDialog extends StatefulWidget {
  final User user;
  final Future<void> Function() loadeUser;
  const CreateUserDialog(
      {super.key, required this.user, required this.loadeUser});

  @override
  State<CreateUserDialog> createState() => _CreateUserDialogState();
}

class _CreateUserDialogState extends State<CreateUserDialog> {
  late TextEditingController _userController;
  final isar = IsarService().isar;
  Future<void> createUser() async {
    final isar = await this.isar;
    await isar.writeTxn(() async {
      await isar.users.put(widget.user);
    });
    widget.loadeUser();
    Navigator.pop(context);
  }

  @override
  void initState() {
    super.initState();
    _userController = TextEditingController(text: widget.user.name);
  }

  // we are using the dispose function to remove when we move out from the screen
  @override
  void dispose() {
    _userController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
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
                  controller: _userController,
                  onChanged: (value) {
                    widget.user.name = value;
                    _userController.text = value;
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
                    onPressed: createUser,
                    child: const Text("Continue")),
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
    );
  }
}
