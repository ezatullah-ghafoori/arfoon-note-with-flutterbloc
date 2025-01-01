import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_footer.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_header.dart';
import 'package:arfoon_note/frontend/widgets/sidebar/sidebar_labels.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatefulWidget {
  final Future<List<Label>> Function() loadLabels;
  final Future<void> Function(Label label) onLabelUpdate;
  final Future<void> Function(Label label) onLabelClick;
  final Future<String> Function() loadUserName;
  final Future<void> Function() onSettingsClicked;
  final Future<void> Function() onProfileCLicked;
  final Future<void> Function() onNewLabel;
  const DrawerWidget(
      {super.key,
      required this.loadLabels,
      required this.onLabelUpdate,
      required this.onLabelClick,
      required this.loadUserName,
      required this.onSettingsClicked,
      required this.onProfileCLicked,
      required this.onNewLabel});

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  List<Label> labels = [];

  Future<void> setLabelState() async {
    List<Label> listOflabels = await widget.loadLabels();
    setState(() {
      labels = listOflabels;
    });
  }

  @override
  void initState() {
    setLabelState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SidebarHeader(),
        Expanded(
            child: SidebarLabels(
          labels: labels,
          onLabelClick: widget.onLabelClick,
          onLabelUpdate: widget.onLabelUpdate,
        )),
        SidebarFooter(
          loadUserName: widget.loadUserName,
          onProfileCLicked: widget.onProfileCLicked,
          onNewLabel: widget.onNewLabel,
          onSettingsClicked: widget.onSettingsClicked,
        )
      ],
    );
  }
}
