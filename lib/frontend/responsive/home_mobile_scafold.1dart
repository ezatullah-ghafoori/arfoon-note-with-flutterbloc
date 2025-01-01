import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/features/note/note_view.dart';
import 'package:arfoon_note/frontend/widgets/drawer_widget.dart';
import 'package:arfoon_note/frontend/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';

class HomeMobileScafold extends StatefulWidget {
  final Future<List<Note>> Function(Filter filter) getNotes;
  final Future<List<Label>> Function() getLabels;
  final Future<void> Function(Note note) addNote;
  final Future<void> Function() onSettingTap;
  final Future<void> Function() onProfileTap;

  const HomeMobileScafold(
      {super.key,
      required this.getNotes,
      required this.getLabels,
      required this.addNote,
      required this.onProfileTap,
      required this.onSettingTap});

  @override
  State<HomeMobileScafold> createState() => _HomeMobileScafoldState();
}

class _HomeMobileScafoldState extends State<HomeMobileScafold> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) => NoteView(
                        onSettingTap: () async {},
                        loadLabels: () async {
                          return [];
                        },
                        onLabelDelete: (int? labelId) async {},
                        onNoteSave: (Note note) async {},
                      )));
        },
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
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
      body: HomeWidget(
        getNotes: widget.getNotes,
        addNote: widget.addNote,
        getLabels: widget.getLabels,
        onSettingTap: widget.onSettingTap,
      ),
      drawer: const Drawer(
        child: DrawerWidget(),
      ),
    );
  }
}
