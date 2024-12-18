import 'package:arfoon_note/server/models/label.dart';
import 'package:arfoon_note/server/models/note.dart';
import 'package:arfoon_note/server/models/user.dart';
import 'package:arfoon_note/frontend/features/note/note.dart';
import 'package:arfoon_note/server/isar_service.dart';
import 'package:arfoon_note/frontend/widgets/drawer.dart';
import 'package:arfoon_note/frontend/widgets/labels.dart';
import 'package:arfoon_note/frontend/widgets/note_card.dart';
import 'package:arfoon_note/frontend/widgets/search.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final int size = 6;

  List<NoteItem> _notes = []; // This will hold all notes from Isar
  late List<Label> labels = [];
  late List<User> user = [];
  List<NoteItem> _pinnedNotes = [];

  bool _isLoading =
      true; // To show loading spinner while notes are being loaded

  @override
  void initState() {
    super.initState();
    _loadNotes();
    loadLabels();
    loadUser(); // Load notes as soon as the widget is rendered
  }

  void searchOnChange(value) async {
    await _loadNotes();
    List<NoteItem> searchedContent = _notes
        .where((note) =>
            note.title.toLowerCase().contains(value.toString().toLowerCase()))
        .toList();
    setState(() {
      _notes = searchedContent;
    });
  }

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    _loadNotes();
  }

  /// Loads all notes from the Isar database
  Future<void> _loadNotes() async {
    try {
      final isar = await IsarService().isar; // Get the Isar instance
      final notes = await isar.noteItems.where().findAll();
      final pinnedNotes = notes.where((note) => note.pinned).toList();
      setState(() {
        _notes = notes.where((note) => !note.pinned).toList();
        _pinnedNotes = pinnedNotes; // Update the list of notes
        _isLoading = false; // Remove loading spinner
      });
    } catch (e) {
      debugPrint('Failed to load notes: $e');
    }
  }

  Future<void> loadUser() async {
    try {
      final isar = await IsarService().isar; // Get the Isar instance
      final users = await isar.users.where().findAll();
      setState(() {
        user = users;
      });
    } catch (e) {
      debugPrint('Failed to load notes: $e');
    }
  }

  Future<void> loadLabels() async {
    try {
      final isar = await IsarService().isar; // Get the Isar instance
      final loadedLabels = await isar.labels.where().findAll();
      setState(() {
        labels = loadedLabels;
      });
    } catch (e) {
      debugPrint('Failed to load notes: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        centerTitle: true,
      ),
      drawer: Drawer(
          child: NoteDrawer(
        loadLabels: loadLabels,
        loadUser: loadUser,
        labels: labels,
        user: user,
      )),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        onPressed: () async {
          await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => Note(
                        note: NoteItem(),
                        loadNotes: _loadNotes,
                        loadLabels: loadLabels,
                      )));
          _loadNotes();
        },
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Search(
                onSearch: searchOnChange,
              ),
              Labels(
                labels: labels,
              ),
              const SizedBox(
                height: 20,
              ),
              if (_notes.isEmpty && _pinnedNotes.isEmpty)
                const Text("No Notes"),
              if (_pinnedNotes.isNotEmpty)
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Pinned",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(146, 158, 158, 158)),
                  ),
                ),
              if (_pinnedNotes.isNotEmpty)
                for (int i = 0; i < _pinnedNotes.length; i++)
                  NoteCard(
                    noteItem: _pinnedNotes[i],
                    loadNotesCallaback: _loadNotes,
                    loadLabels: loadLabels,
                  ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "Others",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(146, 158, 158, 158)),
                ),
              ),
              if (_notes.isNotEmpty)
                for (int i = 0; i < _notes.length; i++)
                  NoteCard(
                    noteItem: _notes[i],
                    loadNotesCallaback: _loadNotes,
                    loadLabels: loadLabels,
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
