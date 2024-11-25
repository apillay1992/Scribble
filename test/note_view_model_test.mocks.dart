// Mocks generated by Mockito 5.4.4 from annotations
// in notes_app/test/note_view_model_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i3;

import 'package:mockito/mockito.dart' as _i1;
import 'package:notes_app/models/note_model.dart' as _i4;
import 'package:notes_app/repositories/note_repository_impl.dart' as _i2;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

/// A class which mocks [NoteRepositoryImpl].
///
/// See the documentation for Mockito's code generation for more information.
class MockNoteRepositoryTest extends _i1.Mock
    implements _i2.NoteRepositoryImpl {
  MockNoteRepositoryTest() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i3.Future<List<_i4.NoteModel>> getAllNotes() => (super.noSuchMethod(
        Invocation.method(
          #getAllNotes,
          [],
        ),
        returnValue: _i3.Future<List<_i4.NoteModel>>.value(<_i4.NoteModel>[]),
      ) as _i3.Future<List<_i4.NoteModel>>);

  @override
  _i3.Future<_i4.NoteModel?> getNoteById(int? id) => (super.noSuchMethod(
        Invocation.method(
          #getNoteById,
          [id],
        ),
        returnValue: _i3.Future<_i4.NoteModel?>.value(),
      ) as _i3.Future<_i4.NoteModel?>);

  @override
  _i3.Future<void> addNote(_i4.NoteModel? note) => (super.noSuchMethod(
        Invocation.method(
          #addNote,
          [note],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> updateNote(_i4.NoteModel? note) => (super.noSuchMethod(
        Invocation.method(
          #updateNote,
          [note],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);

  @override
  _i3.Future<void> deleteNote(int? id) => (super.noSuchMethod(
        Invocation.method(
          #deleteNote,
          [id],
        ),
        returnValue: _i3.Future<void>.value(),
        returnValueForMissingStub: _i3.Future<void>.value(),
      ) as _i3.Future<void>);
}
