import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/bloc/app_bloc.dart';
import 'package:arfoon_note/frontend/widgets/note_card_widget.dart';
import 'package:arfoon_note/frontend/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class HomeWidget extends StatefulWidget {
  const HomeWidget({super.key});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  void loadNotesBySelectedLabel(String labelName) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.add(AppLoadNotes(selectedLabel: labelName));
  }

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    return BlocBuilder<AppBloc, AppState>(
      builder: (context, state) {
        return SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Search(onSearch: (value) {
                appBloc.add(AppLoadNotes(searchQuery: value));
              }),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      TextButton(
                        onPressed: () {
                          loadNotesBySelectedLabel("all");
                        },
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                          // margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                          decoration: BoxDecoration(
                              color: state.currentLabel.name == 'all'
                                  ? Colors.black
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                              border:
                                  Border.all(color: Colors.black, width: 1)),
                          height: 30,
                          child: Text(
                            "All",
                            style: TextStyle(
                              color: state.currentLabel.name == 'all'
                                  ? Colors.white
                                  : Colors.black,
                            ),
                          ),
                        ),
                      ),
                      for (int i = 0; i < state.labels.length; i++)
                        TextButton(
                          onPressed: () {
                            loadNotesBySelectedLabel(state.labels[i].name);
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                            // margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                            decoration: BoxDecoration(
                                color: state.currentLabel.name ==
                                        state.labels[i].name
                                    ? Colors.black
                                    : Colors.transparent,
                                borderRadius: BorderRadius.circular(10),
                                border:
                                    Border.all(color: Colors.black, width: 1)),
                            height: 30,
                            child: Text(
                              state.labels[i].name,
                              style: TextStyle(
                                color: state.currentLabel.name ==
                                        state.labels[i].name
                                    ? Colors.white
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              if (state.notes.isEmpty) const Text("No Notes"),
              for (int i = 0; i < state.notes.length; i++)
                Dismissible(
                    key: Key(i.toString()),
                    direction: DismissDirection.horizontal,
                    onDismissed: (direction) async {
                      final dir =
                          (await getApplicationDocumentsDirectory()).path;
                      final isar = await openIsar(dir);
                      isar.writeTxn(() async {
                        isar.notes.delete(state.notes[i].id!);
                      });
                    },
                    child: NoteCardWidget(note: state.notes[i]))
            ],
          ),
        );
      },
    );
  }
}
