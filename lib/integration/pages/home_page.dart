import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/frontend.dart';
import 'package:flutter/widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return HomeView(
      getNotes: (Filter filter) async {
        return [];
      },
      getLabels: () async {
        return [];
      },
      addNote: (Note note) async {},
      onProfileTap: () async {},
      onSettingTap: () async {},
      onLabelUpdate: (Label label) async {},
      loadUserName: () async {
        return "";
      },
      onNewLabel: () async {},
    );
  }
}
