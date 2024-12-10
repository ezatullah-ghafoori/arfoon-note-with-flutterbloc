import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  const SettingsDialog({super.key});

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        height: 360,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(
                Icons.settings,
                size: 80,
              ),
              const Text(
                "Arfoon Note Settings",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Change Language",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(146, 122, 122, 122)),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  iconSize: 28,
                  icon: const Icon(
                    Icons.unfold_more_sharp,
                  ),
                  alignment: Alignment.centerRight,
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: "English",
                      child: Text('English'),
                    )
                  ],
                  onChanged: (value) {},
                  value: "English",
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Change Theme",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(146, 122, 122, 122)),
              ),
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 0.5),
                    borderRadius: BorderRadius.circular(10)),
                child: DropdownButton(
                  iconSize: 28,
                  icon: const Icon(
                    Icons.unfold_more_sharp,
                  ),
                  alignment: Alignment.centerRight,
                  elevation: 3,
                  borderRadius: BorderRadius.circular(10),
                  underline: const SizedBox(),
                  items: const [
                    DropdownMenuItem(
                      value: "System Themes",
                      child: Text('System Themes'),
                    )
                  ],
                  onChanged: (value) {},
                  value: "System Themes",
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
