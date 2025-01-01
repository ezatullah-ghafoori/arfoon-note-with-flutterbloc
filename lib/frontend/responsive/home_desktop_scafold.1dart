import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/features/note/note_view.dart';
import 'package:arfoon_note/frontend/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';

class HomeDesktopScafold extends StatefulWidget {
  const HomeDesktopScafold({super.key});

  @override
  State<HomeDesktopScafold> createState() => _HomeDesktopScafoldState();
}

class _HomeDesktopScafoldState extends State<HomeDesktopScafold> {
  @override
  void initState() {
    // Fire the AppLoadNotes Event Home page
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
      backgroundColor: Colors.white,
      body: Row(
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.white, boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2), // Shadow color
                spreadRadius: 2, // How much the shadow spreads
                blurRadius: 5, // Blur radius
                offset: const Offset(3, 0),
              )
            ]),
            child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 300.0),
                child: const DrawerWidget()),
          ),
          // const Expanded(child: HomeWidget()),
          Expanded(
              child: NoteView(
            isDesktop: true,
            onSettingTap: () async {},
            loadLabels: () async {
              return [];
            },
            onLabelDelete: (int? labelId) async {},
            onNoteSave: (Note note) async {},
          ))
        ],
      ),
    );
  }
}
