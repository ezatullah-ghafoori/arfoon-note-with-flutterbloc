part of 'app_bloc.dart';

class AppEvents {}

class AppLoadNotes extends AppEvents {
  final String selectedLabel;
  final String? searchQuery;

  AppLoadNotes({this.selectedLabel = "all", this.searchQuery});
}

class AppLoadLabels extends AppEvents {}

class AppSetCurrentNoteToNone extends AppEvents {}

class AppSetCurrentNote extends AppEvents {
  final Note? note;
  AppSetCurrentNote({required this.note});
}

class AppSetCurrentLabel extends AppEvents {
  final Label? label;
  AppSetCurrentLabel({required this.label});
}
