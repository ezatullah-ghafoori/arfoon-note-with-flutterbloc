import 'package:arfoon_note/repositories/label.dart';
import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'note.g.dart';

@collection
class NoteItem {
  Id id = Isar.autoIncrement;
  late String title = 'Untitled';
  @Backlink(to: 'noteItems')
  final IsarLinks<Label> labels = IsarLinks<Label>();
  late String content = '';
  late int color = Colors.white.value;
  late DateTime lastUpdate = DateTime.now();
  bool pinned = false;
}
