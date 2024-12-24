import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class Note {
  Id? id = Isar.autoIncrement;
  String? title;
  String? details;
  int? colorId;
  List<int> labelIds;
  bool pinned;

  Note(
      {this.id,
      this.title,
      this.details,
      this.colorId,
      required this.labelIds,
      this.pinned = false});

  Note copyWith({
    Id? id,
    String? title,
    String? details,
    int? colorId,
    List<int>? labelIds,
  }) {
    return Note(
      id: id ?? this.id,
      title: title ?? this.title,
      details: details ?? this.details,
      colorId: colorId ?? this.colorId,
      labelIds: labelIds ?? this.labelIds,
    );
  }
}
