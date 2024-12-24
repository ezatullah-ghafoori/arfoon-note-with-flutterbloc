import 'package:arfoon_note/client/client.dart';

class FakeData {
  final List<Note> _notes = [
    Note(
        labelIds: [],
        title: "This is a random title 1",
        details: "This is a random note 1",
        pinned: true),
    Note(
      labelIds: [],
      title: "This is a random title 2",
      details: "This is a random note 2",
    ),
    Note(
      labelIds: [],
      title: "This is a random title 3",
      details: "This is a random note 3",
    ),
    Note(
      labelIds: [],
      title: "This is a random title 4",
      details: "This is a random note 4",
    )
  ];
  final List<Label> _labels = [
    Label(name: "Office", details: "Some random detials for the label"),
    Label(name: "Ahmad", details: "Some random detials for the label"),
    Label(name: "Random", details: "Some random detials for the label"),
    Label(name: "Not Sure", details: "Some random detials for the label"),
  ];
  String _username = "Ezatullah Ghafoori";

  List<Note> get notes {
    return _notes;
  }

  set note(Note note) {
    _notes.add(note);
  }

  List<Label> get labels {
    return _labels;
  }

  set label(Label label) {
    _labels.add(label);
  }

  String get username {
    return _username;
  }

  set username(String username) {
    _username = username;
  }
}
