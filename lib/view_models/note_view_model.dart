import 'package:flutter/foundation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/repositories/note_repository.dart';

class NoteViewModel with ChangeNotifier {
  final NoteRepository _noteRepository;
  List<NoteModel> _notes = [];
  bool _isLoading = false;
  String? _error;
  final bool isTest;

  NoteViewModel(this._noteRepository, {this.isTest = false}) {
    if (!isTest) {
      _initializeAuth();
    }
  }

  List<NoteModel> get notes => _notes;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> _initializeAuth() async {
    try {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user != null) {
          loadNotes();
        } else {
          _notes = [];
          notifyListeners();
        }
      });
    } catch (e) {
      if (!isTest) {
        _error = 'Authentication error: ${e.toString()}';
        notifyListeners();
      }
    }
  }

  Future<void> loadNotes() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      _notes = await _noteRepository.getAllNotes();
      _notes.sort((a, b) => b.dateCreated.compareTo(a.dateCreated));
    } catch (e) {
      _error = 'Failed to load notes: ${e.toString()}';
      rethrow;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addNote(NoteModel note) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _noteRepository.addNote(note);
      await loadNotes();
    } catch (e) {
      _error = 'Failed to add note: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> updateNote(NoteModel note) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _noteRepository.updateNote(note);
      await loadNotes();
    } catch (e) {
      _error = 'Failed to update note: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }

  Future<void> deleteNote(int id) async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      await _noteRepository.deleteNote(id);
      await loadNotes();
    } catch (e) {
      _error = 'Failed to delete note: ${e.toString()}';
      notifyListeners();
      rethrow;
    }
  }
}