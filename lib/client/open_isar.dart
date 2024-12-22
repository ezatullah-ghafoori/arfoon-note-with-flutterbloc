import 'package:isar/isar.dart';

import 'models/models.dart';

Isar? isar;

Future<Isar> openIsar(String dir) async {
  if (isar != null && isar!.isOpen) {
    return isar!;
  }
  isar = await Isar.open(
    [
      LabelSchema,
      NoteSchema,
    ],
    directory: dir,
  );

  return isar!;
}
