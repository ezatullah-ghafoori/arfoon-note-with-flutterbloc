import 'package:flutter/material.dart';

class SidebarFooter extends StatefulWidget {
  final Future<String> Function() loadUserName;
  final Future<void> Function() onProfileCLicked;
  final Future<void> Function() onSettingsClicked;
  final Future<void> Function() onNewLabel;
  const SidebarFooter({
    super.key,
    required this.loadUserName,
    required this.onProfileCLicked,
    required this.onNewLabel,
    required this.onSettingsClicked,
  });

  @override
  State<SidebarFooter> createState() => _SidebarFooterState();
}

class _SidebarFooterState extends State<SidebarFooter> {
  String username = "Login";

  Future<void> loadUsername() async {
    String name = await widget.loadUserName();
    setState(() {
      username = name.isEmpty ? "Login" : name;
    });
  }

  String greetingTime() {
    int currentHour = DateTime.now().hour;

    if (currentHour >= 5 && currentHour < 12) {
      return "Good Morning";
    } else if (currentHour >= 12 && currentHour < 17) {
      return "Good Afternoon";
    } else if (currentHour >= 17 && currentHour < 21) {
      return "Good Evening";
    } else {
      return "Good Night";
    }
  }

  @override
  void initState() {
    loadUsername();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MaterialButton(
          onPressed: () {
            widget.onNewLabel();
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
            widget.onSettingsClicked();
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
            widget.onProfileCLicked();
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
                        username.split(" ").length <= 1
                            ? username.isEmpty
                                ? "LO"
                                : username[0] + username[1]
                            : username.split(" ")[0][0] +
                                username.split(" ")[1][0],
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
                    username,
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  Text(
                    greetingTime(),
                    style:
                        const TextStyle(color: Color.fromARGB(163, 99, 95, 95)),
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
