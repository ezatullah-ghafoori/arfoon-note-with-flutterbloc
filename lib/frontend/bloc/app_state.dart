part of 'app_bloc.dart';

class AppState extends Equatable {
  final List<Note> notes;
  final List<Label> labels;
  final Note? currentNote;
  final Label currentLabel;

  const AppState(
      {this.notes = const [],
      this.labels = const [],
      this.currentNote,
      required this.currentLabel});

  AppState copyWith(
      {List<Note>? notes,
      List<Label>? labels,
      Note? currentNote,
      Label? currentLabel}) {
    return AppState(
        notes: notes ?? this.notes,
        labels: labels ?? this.labels,
        currentLabel: currentLabel ?? this.currentLabel,
        currentNote: currentNote ?? this.currentNote);
  }

  @override
  List<Object?> get props => [notes, labels, currentLabel, currentNote];
}
