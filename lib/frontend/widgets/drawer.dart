import 'package:arfoon_note/server/models/label.dart';
import 'package:arfoon_note/server/models/user.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_footer.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_header.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_labels.dart';
import 'package:flutter/material.dart';

class NoteDrawer extends StatelessWidget {
  final Future<void> Function() loadLabels;
  final Future<void> Function() loadUser;
  final List<User> user;
  final List<Label> labels;
  const NoteDrawer(
      {super.key,
      required this.loadLabels,
      required this.loadUser,
      required this.user,
      required this.labels});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DrawerHeader(
          child: SidebarHeader(),
        ),
        // SideBarLabels
        Expanded(
            child: SidebarLabels(
          labels: labels,
          loadLabels: loadLabels,
        )),
        SidebarFooter(
          labels: labels,
          loadLabels: loadLabels,
          loadUsers: loadUser,
          users: user,
        )
      ],
    );
  }
}
