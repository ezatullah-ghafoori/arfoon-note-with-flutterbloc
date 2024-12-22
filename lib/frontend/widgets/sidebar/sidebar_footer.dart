import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/bloc/app_bloc.dart';
import 'package:arfoon_note/frontend/widgets/create_label_dialog.dart';
import 'package:arfoon_note/frontend/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SidebarFooter extends StatefulWidget {
  const SidebarFooter({
    super.key,
  });

  @override
  State<SidebarFooter> createState() => _SidebarFooterState();
}

class _SidebarFooterState extends State<SidebarFooter> {
  void showCreateLabel() async {
    final appBloc = BlocProvider.of<AppBloc>(context);
    final Label label = Label(name: '');
    await showDialog(
        context: context,
        builder: (BuildContext context) {
          return CreateLabelDialog(
            label: label,
            isNew: true,
          );
        });

    appBloc.add(AppLoadLabels());
  }

  void showCreateUser() {
    // final User user = widget.users.isEmpty ? User() : widget.users[0];
    // showDialog(
    //     context: context,
    //     builder: (BuildContext context) {
    //       return CreateUserDialog(
    //         user: user,
    //         loadeUser: widget.loadUsers,
    //       );
    //     });
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
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "LO",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ],
                  )),
              const SizedBox(
                width: 10,
              ),
              const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Login",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
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
