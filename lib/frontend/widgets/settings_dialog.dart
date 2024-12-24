import 'package:flutter/material.dart';

class SettingsDialog extends StatefulWidget {
  final void Function(String? lang) onLangChanged;
  final List<String> availableLangs;
  final String currentLang;
  final void Function(String? themeName) onThemeChanged;
  final List<String> availableThemes;
  final String currentTheme;

  SettingsDialog({
    super.key,
    required this.onLangChanged,
    required this.onThemeChanged,
    this.availableLangs = const ["English"],
    this.availableThemes = const ["System Theme"],
    String? currentLang,
    String? currentTheme,
  })  : currentLang = currentLang ?? availableLangs[0],
        currentTheme = currentTheme ?? availableThemes[0];

  @override
  State<SettingsDialog> createState() => _SettingsDialogState();
}

class _SettingsDialogState extends State<SettingsDialog> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 320),
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
                    items: widget.availableLangs
                        .map<DropdownMenuItem<String>>((lang) {
                      return DropdownMenuItem(value: lang, child: Text(lang));
                    }).toList(),
                    onChanged: (value) => widget.onLangChanged(value),
                    value: widget.currentLang,
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
                    items: widget.availableThemes
                        .map<DropdownMenuItem<String>>((theme) {
                      return DropdownMenuItem(value: theme, child: Text(theme));
                    }).toList(),
                    onChanged: (value) => widget.onThemeChanged(value),
                    value: widget.currentTheme,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
