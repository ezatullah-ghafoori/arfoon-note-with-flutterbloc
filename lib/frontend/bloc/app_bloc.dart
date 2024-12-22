import 'package:arfoon_note/client/client.dart';
import 'package:arfoon_note/frontend/utils/utils.dart';
import 'package:arfoon_note/server/note_server.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:isar/isar.dart';

part 'app_events.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvents, AppState> {
  AppBloc() : super(AppState(currentLabel: Label(name: "All"))) {
    // Bloc Event to load notes
    on<AppLoadNotes>((event, emit) async {
      String dir = await getRootdir();
      Isar isar = await openIsar(dir);
      NoteServer noteServer = NoteServer.instance(isar);
      List<Note> notes = await noteServer.notes.list();
      if (event.selectedLabel == 'all') {
        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          notes = notes.where((note) {
            return note.title!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }
        emit(state.copyWith(notes: notes, currentLabel: Label(name: 'all')));
      } else {
        // Fetch the label by its name
        Label? selectedLabel = (await noteServer.labels.list())
            .where((label) => label.name == event.selectedLabel)
            .first;

        // Filter notes containing the selected label's ID in their labelId list
        List<Note> filteredNotes = notes.where((note) {
          return note.labelIds.contains(selectedLabel.id);
        }).toList();

        if (event.searchQuery != null && event.searchQuery!.isNotEmpty) {
          filteredNotes = filteredNotes.where((note) {
            return note.title!
                .toLowerCase()
                .contains(event.searchQuery!.toLowerCase());
          }).toList();
        }
        // Update state with filtered notes and selected label
        emit(state.copyWith(notes: filteredNotes, currentLabel: selectedLabel));
      }
      // TODO: Implement filter for other labels
    });

    on<AppSetCurrentNote>((event, emit) async {
      emit(state.copyWith(currentNote: event.note));
    });

    // Bloc Event to load labels
    on<AppLoadLabels>((event, emit) async {
      String dir = await getRootdir();
      Isar isar = await openIsar(dir);
      NoteServer noteServer = NoteServer.instance(isar);
      List<Label> labels = await noteServer.labels.list();
      emit(state.copyWith(labels: List.from(labels)));
    });

    // Bloc Set current Label event
    on<AppSetCurrentLabel>((event, emit) {
      emit(state.copyWith(currentLabel: event.label));
    });

    on<AppSetCurrentNoteToNone>((event, emit) {
      emit(state.copyWith(currentNote: null));
    });
  }
}
