import '../../data/models/note_model.dart';

abstract class INoteRepository {
  Future<List<NoteModel>> getNotes();
  Future<void> saveNote(NoteModel note);
  Future<void> deleteNote(DateTime date);
}
