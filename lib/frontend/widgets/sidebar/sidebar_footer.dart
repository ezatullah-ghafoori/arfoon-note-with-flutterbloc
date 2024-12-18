import 'package:arfoon_note/server/models/label.dart';
import 'package:arfoon_note/server/models/user.dart';
import 'package:arfoon_note/frontend/widgets/create_label_dialog.dart';
import 'package:arfoon_note/frontend/widgets/create_user_dialog.dart';
import 'package:arfoon_note/frontend/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';

class SidebarFooter extends StatefulWidget {
  final List<Label> labels;
  final List<User> users;
  final Future<void> Function() loadLabels;
  final Future<void> Function() loadUsers;
  const SidebarFooter(
      {super.key,
      required this.labels,
      required this.loadLabels,
      required this.loadUsers,
      required this.users});

  @override
  State<SidebarFooter> createState() => _SidebarFooterState();
}

class _SidebarFooterState extends State<SidebarFooter> {
  void showCreateLabel() {
    final Label label = Label();
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateLabelDialog(
            label: label,
            isNew: true,
            loadLabels: widget.loadLabels,
          );
        });
  }

  void showCreateUser() {
    final User user = widget.users.isEmpty ? User() : widget.users[0];
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateUserDialog(
            user: user,
            loadeUser: widget.loadUsers,
          );
        });
  }

  void showSettings() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SettingsDialog();
        });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            showCreateLabel();
          },
          child: const Row(
            children: [
              Icon(Icons.note_add),
              SizedBox(
                width: 10,
              ),
              Text("Create Label")
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            showSettings();
          },
          child: const Row(
            children: [
              Icon(Icons.settings),
              SizedBox(
                width: 10,
              ),
              Text("Settings")
            ],
          ),
        ),
        MaterialButton(
          onPressed: () {
            showCreateUser();
          },
          child: Row(
            children: [
              Container(
                  width: 50,
                  height: 50,
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 5),
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        widget.users.isNotEmpty
                            ? widget.users[0].name
                                    .split(" ")[0][0]
                                    .toUpperCase() +
                                widget.users[0].name
                                    .split(" ")[1][0]
                                    .toUpperCase()
                            : "LO",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )),
              const SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.users.isNotEmpty ? widget.users[0].name : "Login",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const Text(
                    "Good Morning",
                    style: TextStyle(color: Color.fromARGB(163, 99, 95, 95)),
                  ),
                ],
              )
            ],
          ),
        ),
      ],
    );
  }
}
