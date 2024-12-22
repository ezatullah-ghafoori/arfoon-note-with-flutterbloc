import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/bloc/app_bloc.dart';
import 'package:arfoon_note/frontend/widgets/note_editor_widget.dart';
import 'package:arfoon_note/frontend/widgets/settings_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class NoteView extends StatefulWidget {
  final bool isNew;
  final bool isDesktop;
  const NoteView({super.key, this.isNew = false, this.isDesktop = false});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  int bgColor = Colors.white.value;
  void setBgColor(int color) {
    setState(() {
      bgColor = color;
    });
  }

  void showSettings() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return const SettingsDialog();
        });
  }

  Future<void> saveNote() async {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    final String dir = (await getApplicationDocumentsDirectory()).path;
    final isar = await openIsar(dir);
    // await noteServer.notes.insert(widget.note);
    await isar.writeTxn(() async {
      return await isar.notes.put(appBloc.state.currentNote!);
    });
    appBloc.add(AppLoadNotes());
  }

  void setNewNote() {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    if (widget.isDesktop && widget.isNew && appBloc.state.currentNote != null) {
      appBloc.add(AppSetCurrentNote(note: Note(labelIds: [])));
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    setNewNote();
    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: widget.isNew
                ? Color(bgColor)
                : state.currentNote != null
                    ? Color(state.currentNote!.colorId ?? 0xFFFFFFFF)
                    : Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if (!widget.isDesktop)
                  IconButton(
                      onPressed: showSettings,
                      icon: const Icon(Icons.more_vert_rounded))
                else
                  TextButton(
                      onPressed: saveNote,
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white),
                      child: const Text("Save"))
              ],
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: NoteEditorWidget(
                  note: state.currentNote != null
                      ? state.currentNote!
                      : Note(labelIds: []),
                  setBgColor: setBgColor,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
