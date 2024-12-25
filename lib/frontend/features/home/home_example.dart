import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/features/note/note_view.dart';
import 'package:arfoon_note/frontend/frontend.dart';
import 'package:arfoon_note/frontend/widgets/LabelDeletion.dart';
import 'package:arfoon_note/frontend/widgets/create_label_dialog.dart';
import 'package:arfoon_note/frontend/widgets/label_selector_dialog.dart';
import 'package:arfoon_note/frontend/widgets/profile_dialog.dart';
import 'package:arfoon_note/frontend/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';

class HomeExample extends StatelessWidget {
  const HomeExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return HomeView(
                          addNote: (Note note) async {},
                          getNotes: (Filter filter) async {
                            return FakeData().notes;
                          },
                          getLabels: () async {
                            return FakeData().labels;
                          },
                          onProfileTap: () async {},
                          onSettingTap: () async {},
                        );
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "HomeExample",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "Push to HomeExample and Example returns HomeView with calls of getNote(file), getLabels, addNote, onSettingTap, onProfileTap.")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ProfileDialog(
                          onSubmit: (String name) async {
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                          },
                          name: "Ahmad Khan",
                        );
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "ProfileView Example",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "This is a dialog and show as ProfileView().show(context) and has parameters of: name, onSubmit(String name)")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return SettingsDialog(
                          availableLangs: const [
                            "English",
                            "French",
                            "Chines",
                            "Portugues",
                          ],
                          availableThemes: const [
                            "System Theme",
                            "Light Theme",
                            "Dark Theme"
                          ],
                          currentTheme: "Light Theme",
                          onLangChanged: (
                            String? lang,
                          ) {
                            Navigator.pop(context);
                          },
                          onThemeChanged: (String? themeName) {
                            Navigator.pop(context);
                          },
                        );
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SettingsView Example",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "This is a dialog and show as SettingsView().show(context) and has parameters of currentLang, onLangChanged(String? lang), currentTheme, onThemeChanged(String? themeName), availableLangs: List<String>, availableThemes<String>")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return CreateLabelDialog(
                          onDelete: (name) async {
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                          },
                          onSubmit: (name) async {
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                          },
                        );
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "AddEditLabel View Example",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "This is a dialog and show as AddEditLabelView().show(context) and has parameters of: name, onSubmit(String? name), onDelete(String? name)")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Labeldeletion(
                          title: 'Are you sure you want to delete?',
                          subTitle:
                              'Once the label is deleted can\'t be undone, are you sure you want to delete?',
                          onSure: () async {
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                          },
                          onCancel: () async {
                            Navigator.pop(context);
                          },
                        );
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SureView Example",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "This is a dialog and show as SureView().show(context) and has parameters of title, subTitle,Future<void> onSure(), Future<void> onCancel()")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return NoteView(
                          loadLabels: () async {
                            return FakeData().labels;
                          },
                          onSettingTap: () async {},
                          onLabelDelete: (int? labelId) async {},
                          onNoteSave: (Note note) async {},
                        );
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "NoteEditorView Example",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "This is a dialog and show as SureView().show(context) and has parameters of title, subTitle,Future<void> onSure(), Future<void> onCancel()")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LabelSelectorDialog(
                          loadLabels: () async {
                            return FakeData().labels;
                          },
                          onLabelSelect: (Label label) async {
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                          },
                          onNewLabel: () async {
                            await Future.delayed(const Duration(seconds: 3));
                            Navigator.pop(context);
                          },
                        );
                      }));
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "SelectLabelView Example",
                            style: TextStyle(fontSize: 28),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          Text(
                              "This is a dialog and show as SelectLabelView().show(context) and has parameters of Future<void> onLabelSelect(Label label), Futur<List<>> loadLabels(), Future<void> onNewLabel()")
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
