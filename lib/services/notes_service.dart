import 'package:assignment2_2022/models/noteEntry.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

import '../models/note.dart';

class NotesService with ChangeNotifier {
  NoteEntry? _noteEntry;

  List<Note> _notes = [];
  List<Note> get notes => _notes;

  void emptyNotes() {
    _notes = [];
    notifyListeners();
  }

  bool _busyRetrieving = false;
  bool _busySaving = false;

  bool get busyRetrieving => _busyRetrieving;
  bool get busySaving => _busySaving;

  Future<String> getNotes(String username, bool firstLoad) async {
    String result = 'Ok';
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "username = '$username'";

    _busyRetrieving = true;
    notifyListeners();

    List<Map<dynamic, dynamic>?>? map = await Backendless.data
        .of('NoteEntry')
        .find(queryBuilder)
        .onError((error, stackTrace) {
      result = error.toString();
      return null; //This keeps adding itself back after every save, perhaps 'return' is wrongly placed ?
    });
    if (result != 'OK') {
      _busyRetrieving = false;
      notifyListeners();
      return result;
    }

    if (map != null) {
      if (map.isNotEmpty) {
        _noteEntry = NoteEntry.fromJson(map.first);
        _notes = convertMapToNoteList(_noteEntry!.notes);
        notifyListeners();
      } else {
        emptyNotes();
      }
    } else {
      return result = 'NOT OK';
    }

    _busyRetrieving = false;
    notifyListeners();
    //TODO implement code for firstLoad here.
    return result;
  }

  Future<String> saveNotesEntry(String username, bool inUI) async {
    String result = 'Ok';
    if (_noteEntry == null) {
      _noteEntry =
          NoteEntry(notes: convertNotesListToMap(_notes), username: username);
    } else {
      _noteEntry!.notes = convertNotesListToMap(_notes);
    }

    if (inUI) {
      _busySaving = true;
      notifyListeners();
    }

    await Backendless.data
        .of('NoteEntry')
        .save(_noteEntry!.toJson())
        .onError((error, stackTrace) {
      result = error.toString();
      return null; //This line also adds itself after every save.
    });
    if (inUI) {
      _busySaving = false;
      notifyListeners();
    }
    return result;
  }

  void deleteNote(Note note) {
    _notes.remove(note);
    notifyListeners();
  }

  void createNote(Note note) {
    _notes.insert(0, note);
    notifyListeners();
  }
}
