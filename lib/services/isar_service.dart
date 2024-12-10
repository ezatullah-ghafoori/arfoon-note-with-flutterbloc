import 'package:arfoon_note/repositories/label.dart';
import 'package:arfoon_note/repositories/note.dart';
import 'package:arfoon_note/repositories/user.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class IsarService {
  static final IsarService _instance = IsarService._internal();
  late Future<Isar> _isar;

  factory IsarService() {
    return _instance;
  }

  IsarService._internal() {
    _isar = _initIsar();
  }

  Future<Isar> _initIsar() async {
    final dir = await getApplicationDocumentsDirectory();
    return await Isar.open([LabelSchema, NoteItemSchema, UserSchema],
        directory: dir.path);
  }

  Future<Isar> get isar async => _isar;
}
