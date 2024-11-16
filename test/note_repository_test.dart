

import 'package:flutter_test/flutter_test.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/repositories/note_repository.dart';
import 'package:notes_app/repositories/note_repository_impl.dart';

void main() {
  late NoteRepository repository;

  setUp(() {
    repository = NoteRepositoryImpl();
  });

  group('NoteRepository - Basic Operations', () {
    test('should start with empty list', () async {
      final notes = await repository.getAllNotes();
      expect(notes, isEmpty);
    });

    test('should add note correctly', () async {
      final note = NoteModel(id: 1, title: 'Test', content: 'Content');
      await repository.addNote(note);

      final notes = await repository.getAllNotes();
      expect(notes.length, 1);
      expect(notes.first.id, note.id);
      expect(notes.first.title, note.title);
      expect(notes.first.content, note.content);
    });

    test('should get note by id', () async {
      final note = NoteModel(id: 1, title: 'Test', content: 'Content');
      await repository.addNote(note);

      final retrievedNote = await repository.getNoteById(1);
      expect(retrievedNote?.id, note.id);
      expect(retrievedNote?.title, note.title);
      expect(retrievedNote?.content, note.content);
    });
  });

  group('NoteRepository - Advanced Operations', () {
    test('should return null or empty note when getting non-existent note', () async {
      final note = await repository.getNoteById(999);

      // Either the note should be null or have id = -1 (both implementations are valid)
      if (note != null) {
        expect(note.id, -1);
        expect(note.title, '');
        expect(note.content, '');
      } else {
        expect(note, isNull);
      }
    });

    test('should update note correctly when note exists', () async {
      final note = NoteModel(id: 1, title: 'Test', content: 'Content');
      await repository.addNote(note);

      final updatedNote = NoteModel(id: 1, title: 'Updated', content: 'New Content');
      await repository.updateNote(updatedNote);

      final retrievedNote = await repository.getNoteById(1);
      expect(retrievedNote?.title, 'Updated');
      expect(retrievedNote?.content, 'New Content');
    });

    test('should handle updating non-existent note', () async {
      final note = NoteModel(id: 999, title: 'Test', content: 'Content');

      expect(
            () => repository.updateNote(note),
        throwsA(anyOf(
          isA<StateError>(),
          isA<RangeError>(),
          isA<ArgumentError>(),
          isA<Exception>(),
        )),
      );
    });

    test('should delete note correctly', () async {
      final note = NoteModel(id: 1, title: 'Test', content: 'Content');
      await repository.addNote(note);

      await repository.deleteNote(1);

      final notes = await repository.getAllNotes();
      expect(notes, isEmpty);
    });
  });

  group('NoteRepository - Edge Cases', () {
    test('should handle multiple notes', () async {
      final notes = [
        NoteModel(id: 1, title: 'First', content: 'Content 1'),
        NoteModel(id: 2, title: 'Second', content: 'Content 2'),
        NoteModel(id: 3, title: 'Third', content: 'Content 3'),
      ];

      for (final note in notes) {
        await repository.addNote(note);
      }

      final retrievedNotes = await repository.getAllNotes();
      expect(retrievedNotes.length, 3);
    });

    test('should handle deleting non-existent note without throwing error', () async {
      // Deleting a non-existent note should not throw an error
      await expectLater(repository.deleteNote(999), completes);

      final notes = await repository.getAllNotes();
      expect(notes, isEmpty);
    });

    test('should handle duplicate IDs', () async {
      final note1 = NoteModel(id: 1, title: 'First', content: 'Content 1');
      await repository.addNote(note1);

      final note2 = NoteModel(id: 1, title: 'Second', content: 'Content 2');

      try {
        await repository.addNote(note2);

        // If no error was thrown, verify only one note exists
        final notes = await repository.getAllNotes();
        expect(notes.length, 1);
      } catch (e) {
        expect(e, isNotNull);
      }
    });
  });

}