import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/client/models/filter.dart';
import 'package:arfoon_note/frontend/widgets/content_loading_widget.dart';
import 'package:arfoon_note/frontend/widgets/loadin_widget.dart';
import 'package:arfoon_note/frontend/widgets/note_card_widget.dart';
import 'package:arfoon_note/frontend/widgets/widget.dart';
import 'package:flutter/material.dart';

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
  List<Note> notes = [];
  List<Label> labels = [];
  Label currentLabel = Label(
    name: "All",
  );
  bool isLoading = false;
  bool isError = false;

  @override
  void initState() {
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Search(onSearch: (value) async {
            setState(() {
              isLoading = true;
            });
            try {
              List<Note> notes =
                  await widget.getNotes(Filter(search: value.toLowerCase()));
              setState(() {
                notes = notes;
                isLoading = false;
              });
            } catch (e) {
              setState(() {
                isLoading = false;
                isError = true;
              });
            }
          }),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () async {
                      setState(() {
                        isLoading = true;
                      });
                      try {
                        List<Note> notes =
                            await widget.getNotes(const Filter());
                        setState(() {
                          notes = notes;
                          isLoading = false;
                          currentLabel = Label(name: "All");
                        });
                      } catch (e) {
                        setState(() {
                          isLoading = false;
                          isError = true;
                        });
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(10, 4, 10, 4),
                      decoration: BoxDecoration(
                          color: currentLabel.name == 'All'
                              ? Colors.black
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black, width: 1)),
                      height: 30,
                      child: Text(
                        "All",
                        style: TextStyle(
                          color: currentLabel.name == 'All'
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                    ),
                  ),
                  for (int i = 0; i < labels.length; i++)
                    TextButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          List<Note> notes = await widget
                              .getNotes(Filter(labelId: labels[i].id));
                          setState(() {
                            notes = notes;
                            isLoading = false;
                            currentLabel = labels[i];
                          });
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                            isError = true;
                          });
                        }
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
          if (isError)
            Column(
              children: [
                const Text("Ohh, we are sorry!"),
                const Text("Something went wrong..."),
                TextButton(
                    onPressed: () async {
                      setState(() {
                        isError = false;
                        isLoading = true;
                      });
                      try {
                        List<Note> notes =
                            await widget.getNotes(const Filter());
                        setState(() {
                          notes = notes;
                        });
                      } catch (e) {
                        setState(() {
                          isError = true;
                          isLoading = true;
                        });
                      }
                    },
                    child: const Text("Try Again"))
              ],
            )
          else if (notes.isEmpty || isLoading)
            const ContentLoadingWidget()
          else
            for (int i = 0; i < notes.length; i++)
              Dismissible(
                  key: Key(i.toString()),
                  direction: DismissDirection.horizontal,
                  onDismissed: (direction) async {},
                  child: NoteCardWidget(
                    note: notes[i],
                    getLabels: widget.getLabels,
                  ))
        ],
      ),
    );
  }
}
