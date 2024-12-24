import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/bloc/app_bloc.dart';
import 'package:arfoon_note/frontend/widgets/note_card_widget.dart';
import 'package:arfoon_note/frontend/widgets/widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';

class HomeWidget extends StatefulWidget {
  final Future<List<Note>> Function(Filter filter) getNotes;
  final Future<List<Label>> Function() getLabels;
  final Future<void> Function(Note note) addNote;
  final Future<void> Function() onSettingTap;
  // final Future<void> Function() onProfileTap;

  const HomeWidget(
      {super.key,
      required this.getNotes,
      required this.getLabels,
      required this.addNote,
      // required this.onProfileTap,
      required this.onSettingTap});

  @override
  State<HomeWidget> createState() => _HomeWidgetState();
}

class _HomeWidgetState extends State<HomeWidget> {
  void loadNotesBySelectedLabel(String labelName) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);
    appBloc.add(AppLoadNotes(selectedLabel: labelName));
  }

  List<Note> notes = [];
  List<Label> labels = [];
  Label currentLabel = Label(
    name: "all",
  );

  @override
  Widget build(BuildContext context) {
    AppBloc appBloc = BlocProvider.of<AppBloc>(context);

    // Future Call for getting notes
    widget.getNotes(const Filter()).then((res) {
      setState(() {
        notes = res;
      });
    });

    //Future call for getting labels
    widget.getLabels().then((res) {
      setState(() {
        labels = res;
      });
    });

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
                          color: currentLabel.name == 'all'
                              ? Colors.black
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1)),
                      height: 30,
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: currentLabel.name == 'all'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < labels.length; i++)
                    TextButton(
                      onPressed: () {
                        loadNotesBySelectedLabel(labels[i].name);
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                        // margin: const EdgeInsets.fromLTRB(6, 4, 6, 4),
                        decoration: BoxDecoration(
                            color: currentLabel.name == labels[i].name
                                ? Colors.black
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black, width: 1)),
                        height: 30,
                        child: Text(
                          labels[i].name,
                          style: TextStyle(
                            color: currentLabel.name == labels[i].name
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
          if (notes.isEmpty)
            const Text("No Notes")
          else
            for (int i = 0; i < notes.length; i++)
              Dismissible(
                  key: Key(i.toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) async {},
                  child: NoteCardWidget(note: notes[i]))
        ],
      ),
    );
  }
}
