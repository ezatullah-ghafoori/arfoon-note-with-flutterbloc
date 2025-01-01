import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/widgets/drawer_widget.dart';
import 'package:arfoon_note/frontend/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget {
  final Future<List<Note>> Function(Filter filter) getNotes;
  final Future<List<Label>> Function() getLabels;
  final Future<void> Function(Note note) addNote;
  final Future<void> Function() onSettingTap;
  final Future<void> Function() onProfileTap;
  final Future<void> Function(Label label) onLabelUpdate;
  final Future<String> Function() loadUserName;
  final Future<void> Function() onNewLabel;

  const HomeView(
      {super.key,
      required this.getNotes,
      required this.getLabels,
      required this.addNote,
      required this.onProfileTap,
      required this.onSettingTap,
      required this.onLabelUpdate,
      required this.loadUserName,
      required this.onNewLabel});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
          title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 30, child: Image.asset('assets/images/logo.png')),
          const SizedBox(
            width: 4,
          ),
          const Text("Arfoon Note"),
        ],
      )),
      drawer: Drawer(
        child: DrawerWidget(
          loadLabels: getLabels,
          onLabelUpdate: onLabelUpdate,
          onLabelClick: (Label label) async {
            getNotes(Filter(labelId: label.id));
            Navigator.pop(context);
          },
          loadUserName: loadUserName,
          onSettingsClicked: onSettingTap,
          onProfileCLicked: onProfileTap,
          onNewLabel: onNewLabel,
        ),
      ),
      body: screenWidth < 600
          ? HomeWidget(
              getNotes: getNotes,
              getLabels: getLabels,
              addNote: addNote,
              onSettingTap: onSettingTap)
          : const Text("Desktop"),
    );
  }
}
