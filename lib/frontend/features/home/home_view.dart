import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/responsive/Responsive_layout.dart';
import 'package:arfoon_note/frontend/responsive/home_desktop_scafold.dart';
import 'package:arfoon_note/frontend/responsive/home_mobile_scafold.dart';
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
    return ResponsiveLayout(
        mobileScafold: HomeMobileScafold(
          getNotes: getNotes,
          addNote: addNote,
          getLabels: getLabels,
          onProfileTap: onProfileTap,
          onSettingTap: onSettingTap,
        ),
        desktopScafold: HomeDesktopScafold());
  }
}
