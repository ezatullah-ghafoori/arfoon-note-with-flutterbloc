import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/bloc/app_bloc.dart';
import 'package:arfoon_note/frontend/features/note/note_view.dart';
import 'package:arfoon_note/frontend/widgets/drawer_widget.dart';
import 'package:arfoon_note/frontend/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeDesktopScafold extends StatefulWidget {
  const HomeDesktopScafold({super.key});

  @override
  State<HomeDesktopScafold> createState() => _HomeDesktopScafoldState();
}

class _HomeDesktopScafoldState extends State<HomeDesktopScafold> {
  @override
  void initState() {
    final appBloc = BlocProvider.of<AppBloc>(context);
    // Fire the AppLoadNotes Event Home page
    appBloc.add(AppLoadNotes());
    appBloc.add(AppLoadLabels());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          AppBloc appBloc = BlocProvider.of<AppBloc>(context);
          appBloc.add(AppSetCurrentNote(note: Note(labelIds: [])));
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const NoteView(isNew: true)));
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
          const Expanded(child: HomeWidget()),
          const Expanded(child: NoteView(isDesktop: true))
        ],
      ),
    );
  }
}
