import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/bloc/app_bloc.dart';
import 'package:arfoon_note/frontend/features/note/note_view.dart';
import 'package:arfoon_note/frontend/widgets/drawer_widget.dart';
import 'package:arfoon_note/frontend/widgets/home/home_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMobileScafold extends StatefulWidget {
  const HomeMobileScafold({super.key});

  @override
  State<HomeMobileScafold> createState() => _HomeMobileScafoldState();
}

class _HomeMobileScafoldState extends State<HomeMobileScafold> {
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
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
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
          body: const HomeWidget(),
          drawer: const Drawer(
            child: DrawerWidget(),
          ),
        );
      },
    );
  }
}
