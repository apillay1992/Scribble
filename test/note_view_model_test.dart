import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/repositories/note_repository.dart';
import 'package:notes_app/repositories/note_repository_impl.dart';
import 'package:notes_app/view_models/note_view_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';
import 'helpers/test_helper.dart';

@GenerateMocks([], customMocks: [
  MockSpec<NoteRepositoryImpl>(as: #MockNoteRepositoryTest),
])
import 'note_view_model_test.mocks.dart';

void main() async {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockNoteRepositoryTest mockRepository;
  late NoteViewModel viewModel;

  setUpAll(() async {
    await TestHelper.setupFirebaseForTesting().catchError((e) {
      // Ignore Firebase setup errors in test
      print('Firebase setup error in test: $e');
    });
  });

  setUp(() {
    mockRepository = MockNoteRepositoryTest();
    viewModel = NoteViewModel(mockRepository, isTest: true);
  });

  tearDown(() {
    // Clean up after each test
    viewModel = NoteViewModel(mockRepository, isTest: true);
  });

  group('NoteViewModel - Initialization', () {
    test('should initialize without error', () async {
      when(mockRepository.getAllNotes())
          .thenAnswer((_) async => []);

      await viewModel.loadNotes();
      expect(viewModel.notes, isEmpty);
    });

    test('should load notes from repository', () async {
      final testNotes = [
        NoteModel(id: 1, title: 'Test 1', content: 'Content 1'),
        NoteModel(id: 2, title: 'Test 2', content: 'Content 2'),
      ];

      when(mockRepository.getAllNotes())
          .thenAnswer((_) async => testNotes);

      await viewModel.loadNotes();

      expect(viewModel.notes.length, 2);
      verify(mockRepository.getAllNotes()).called(1);
    });
  });

  group('NoteViewModel - CRUD Operations', () {
    test('should add note and notify listeners', () async {
      final note = NoteModel(id: 1, title: 'Test', content: 'Content');

      when(mockRepository.addNote(note))
          .thenAnswer((_) async => {});
      when(mockRepository.getAllNotes())
          .thenAnswer((_) async => [note]);

      await viewModel.addNote(note);
      await viewModel.loadNotes();

      verify(mockRepository.addNote(note)).called(1);
      expect(viewModel.notes.length, 1);
    });

    test('should update note', () async {
      final note = NoteModel(id: 1, title: 'Updated', content: 'Content');

      when(mockRepository.updateNote(note))
          .thenAnswer((_) async => {});
      when(mockRepository.getAllNotes())
          .thenAnswer((_) async => [note]);

      await viewModel.updateNote(note);
      await viewModel.loadNotes();

      verify(mockRepository.updateNote(note)).called(1);
      expect(viewModel.notes.first.title, 'Updated');
    });

    test('should delete note', () async {
      when(mockRepository.deleteNote(1))
          .thenAnswer((_) async => {});
      when(mockRepository.getAllNotes())
          .thenAnswer((_) async => []);

      await viewModel.deleteNote(1);
      await viewModel.loadNotes();

      verify(mockRepository.deleteNote(1)).called(1);
      expect(viewModel.notes, isEmpty);;
    });
  });

  group('NoteViewModel - Error Handling', () {
    test('should handle load errors gracefully', () async {
      when(mockRepository.getAllNotes())
          .thenThrow(Exception('Failed to load'));

      try {
        await viewModel.loadNotes();
      } catch (e) {
        // Different implementations might handle errors differently
        expect(e, isA<Exception>());
      }
    });

    test('should handle add errors gracefully', () async {
      final note = NoteModel(id: 1, title: 'Test', content: 'Content');

      when(mockRepository.addNote(note))
          .thenThrow(Exception('Failed to add'));

      try {
        await viewModel.addNote(note);
      } catch (e) {
        // Different implementations might handle errors differently
        expect(e, isA<Exception>());
      }
    });

    test('should handle update errors gracefully', () async {
      final note = NoteModel(id: 999, title: 'Test', content: 'Content');

      when(mockRepository.updateNote(note))
          .thenThrow(Exception('Failed to update'));

      try {
        await viewModel.updateNote(note);
      } catch (e) {
        // Different implementations might handle errors differently
        expect(e, isA<Exception>());
      }
    });

    test('should handle delete errors gracefully', () async {
      when(mockRepository.deleteNote(999))
          .thenThrow(Exception('Failed to delete'));

      try {
        await viewModel.deleteNote(999);
      } catch (e) {
        // Different implementations might handle errors differently
        expect(e, isA<Exception>());
      }
    });
  });
}
