import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_footer.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_header.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_labels.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SidebarHeader(),
        Expanded(child: SidebarLabels()),
        SidebarFooter()
      ],
    );
  }
}
