import 'package:flutter/material.dart';

import '../models/note.dart';

class NotesServie with ChangeNotifier {
  Future<String> getNotes(String username, bool firstLoad) async {
    String result = 'Ok';
    return result;
  }

  Future<String> saveNotesEntry(String username, bool inUI) async {
    String result = 'Ok';
    return result;
  }

  void deleteNote(Note note) {}

  void createNote(Note note) {}
}
