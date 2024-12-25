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

  const HomeView(
      {super.key,
      required this.getNotes,
      required this.getLabels,
      required this.addNote,
      required this.onProfileTap,
      required this.onSettingTap});

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
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
      body: screenWidth < 600
          ? HomeWidget(
              getNotes: getNotes,
              getLabels: getLabels,
              addNote: addNote,
              onSettingTap: onSettingTap)
          : const Text("Desktop"),
    );

    // return ResponsiveLayout(
    //     mobileScafold: HomeMobileScafold(
    //       getNotes: getNotes,
    //       addNote: addNote,
    //       getLabels: getLabels,
    //       onProfileTap: onProfileTap,
    //       onSettingTap: onSettingTap,
    //     ),
    //     desktopScafold: const HomeDesktopScafold());
  }
}
