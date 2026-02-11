import 'package:hive/hive.dart';
import '../../domain/repositories/note_repository.dart';
import '../models/note_model.dart';

class HiveNoteRepository implements INoteRepository {
  static const String boxName = 'notes';

  Future<Box<NoteModel>> _getBox() async {
    return await Hive.openBox<NoteModel>(boxName);
  }

  @override
  Future<List<NoteModel>> getNotes() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> saveNote(NoteModel note) async {
    final box = await _getBox();
    await box.put(note.date.toIso8601String(), note);
  }

  @override
  Future<void> deleteNote(DateTime date) async {
    final box = await _getBox();
    await box.delete(date.toIso8601String());
  }
}
