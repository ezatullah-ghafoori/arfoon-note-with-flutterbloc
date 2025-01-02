import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/features/note/note_view.dart';
import 'package:arfoon_note/frontend/widgets/drawer_widget.dart';
import 'package:arfoon_note/frontend/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
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
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  Note selectedNote = Note(labelIds: []);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: screenWidth < 600
          ? AppBar(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                      width: 30, child: Image.asset('assets/images/logo.png')),
                  const SizedBox(width: 4),
                  const Text("Arfoon Note"),
                ],
              ),
            )
          : AppBar(
              toolbarHeight: 30,
              automaticallyImplyLeading: false,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                      width: 20, child: Image.asset('assets/images/logo.png')),
                  const SizedBox(width: 4),
                  const Text(style: TextStyle(fontSize: 14), "Arfoon Note"),
                ],
              )),
      drawer: screenWidth < 600
          ? Drawer(
              child: DrawerWidget(
                loadLabels: widget.getLabels,
                onLabelUpdate: widget.onLabelUpdate,
                onLabelClick: (Label label) async {
                  widget.getNotes(Filter(labelId: label.id));
                  Navigator.pop(context);
                },
                loadUserName: widget.loadUserName,
                onSettingsClicked: widget.onSettingTap,
                onProfileCLicked: widget.onProfileTap,
                onNewLabel: widget.onNewLabel,
              ),
            )
          : null, // Ensure no drawer for desktop
      body: screenWidth < 600
          ? HomeWidget(
              getNotes: widget.getNotes,
              getLabels: widget.getLabels,
              addNote: widget.addNote,
              onSettingTap: widget.onSettingTap,
              onCardTap: (Note note) async {},
            )
          : Row(
              children: [
                Container(
                  constraints: const BoxConstraints(maxWidth: 250),
                  child: Drawer(
                    child: DrawerWidget(
                      loadLabels: widget.getLabels,
                      onLabelUpdate: widget.onLabelUpdate,
                      onLabelClick: (Label label) async {
                        widget.getNotes(Filter(labelId: label.id));
                        Navigator.pop(context);
                      },
                      loadUserName: widget.loadUserName,
                      onSettingsClicked: widget.onSettingTap,
                      onProfileCLicked: widget.onProfileTap,
                      onNewLabel: widget.onNewLabel,
                    ),
                  ),
                ),
                Container(
                  constraints: const BoxConstraints(maxWidth: 350),
                  child: Flex(direction: Axis.horizontal, children: [
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 10, bottom: 10),
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 8.0, right: 8.0),
                              child: Row(
                                children: [
                                  const Text(
                                    "My Notes",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18),
                                  ),
                                  const Expanded(
                                    child: SizedBox(),
                                  ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                          backgroundColor: Colors.black,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(4))),
                                      onPressed: () {
                                        setState(() {
                                          selectedNote = Note(labelIds: []);
                                        });
                                      },
                                      child: const Row(
                                        children: [
                                          Icon(
                                            Icons.add,
                                            size: 15,
                                          ),
                                          Text(
                                              style: TextStyle(fontSize: 10),
                                              "New Note")
                                        ],
                                      ))
                                ],
                              ),
                            ),
                            Expanded(
                              child: HomeWidget(
                                getNotes: widget.getNotes,
                                getLabels: widget.getLabels,
                                addNote: widget.addNote,
                                onSettingTap: widget.onSettingTap,
                                onCardTap: (Note note) async {
                                  setState(() {
                                    selectedNote = note;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
                ),
                Expanded(
                  child: NoteView(
                      note: selectedNote,
                      loadLabels: widget.getLabels,
                      onLabelDelete: (int? label) async {},
                      onNoteSave: (Note note) async {},
                      onSettingTap: widget.onSettingTap),
                )
              ],
            ),
    );
  }
}
