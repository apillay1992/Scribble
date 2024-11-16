import 'package:notes_app/models/note_model.dart';

abstract class NoteRepository {
  Future<List<NoteModel>> getAllNotes();
  Future<NoteModel?> getNoteById(int id);
  Future<void> addNote(NoteModel note);
  Future<void> updateNote(NoteModel note);
  Future<void> deleteNote(int id);
}