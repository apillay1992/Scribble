import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/repositories/note_repository.dart';

class FirestoreNoteRepository implements NoteRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Counter document to maintain auto-incrementing IDs
  DocumentReference get _counterDoc {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User must be logged in');
    return _firestore.collection('users').doc(userId).collection('counters').doc('notes_counter');
  }

  // Notes collection
  CollectionReference<Map<String, dynamic>> get _notesCollection {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User must be logged in');
    return _firestore.collection('users').doc(userId).collection('notes');
  }

  // Get next ID for new note
  Future<int> _getNextId() async {
    final counterDoc = await _counterDoc.get();
    if (!counterDoc.exists) {
      await _counterDoc.set({'current': 0});
      return 1;
    }

    final currentId = (counterDoc.data() as Map<String, dynamic>)['current'] as int;
    await _counterDoc.update({'current': currentId + 1});
    return currentId + 1;
  }

  @override
  Future<List<NoteModel>> getAllNotes() async {
    try {
      final snapshot = await _notesCollection.orderBy('id', descending: true).get();
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return NoteModel(
          id: data['id'] as int,
          title: data['title'] as String,
          content: data['content'] as String,
          dateCreated: DateTime.parse(data['dateCreated'] as String),
        );
      }).toList();
    } catch (e) {
      print('Error getting notes: $e');
      return [];
    }
  }

  @override
  Future<NoteModel?> getNoteById(int id) async {
    try {
      final snapshot = await _notesCollection.where('id', isEqualTo: id).limit(1).get();
      if (snapshot.docs.isEmpty) return null;

      final data = snapshot.docs.first.data();
      return NoteModel(
        id: data['id'] as int,
        title: data['title'] as String,
        content: data['content'] as String,
        dateCreated: DateTime.parse(data['dateCreated'] as String),
      );
    } catch (e) {
      print('Error getting note by id: $e');
      return null;
    }
  }

  @override
  Future<void> addNote(NoteModel note) async {
    try {
      // Get next ID
      final id = await _getNextId();

      // Store note with integer ID
      await _notesCollection.doc(id.toString()).set({
        'id': id,
        'title': note.title,
        'content': note.content,
        'dateCreated': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      print('Error adding note: $e');
      throw StateError('Failed to add note: $e');
    }
  }

  @override
  Future<void> updateNote(NoteModel note) async {
    try {
      final snapshot = await _notesCollection
          .where('id', isEqualTo: note.id)
          .limit(1)
          .get();

      if (snapshot.docs.isEmpty) {
        throw StateError('Note not found: Cannot update note with id ${note.id}');
      }

      await snapshot.docs.first.reference.update({
        'title': note.title,
        'content': note.content,
      });
    } catch (e) {
      print('Error updating note: $e');
      throw StateError('Failed to update note: $e');
    }
  }

  @override
  Future<void> deleteNote(int id) async {
    try {
      final snapshot = await _notesCollection
          .where('id', isEqualTo: id)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        await snapshot.docs.first.reference.delete();
      }
    } catch (e) {
      print('Error deleting note: $e');
    }
  }
}