import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/repositories/note_repository.dart';

class NoteRepositoryImpl implements NoteRepository {
  final List<NoteModel> _notes = [];
  int _nextId = 1;

  @override
  Future<List<NoteModel>> getAllNotes() async {
    return Future.value(_notes);
  }

  @override
  Future<NoteModel?> getNoteById(int id) async {
    try {
      return Future.value(_notes.firstWhere((note) => note.id == id));
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> addNote(NoteModel note) async {
    _notes.add(
      NoteModel(
        id: _nextId++,
        title: note.title,
        content: note.content,
      ),
    );
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    final index = _notes.indexWhere((n) => n.id == note.id);
    if (index == -1) {
      throw Exception('Note not found: Cannot update note with id ${note.id}');
    }
    _notes[index] = note;
  }

  @override
  Future<void> deleteNote(int id) async {
    _notes.removeWhere((note) => note.id == id);
  }
}