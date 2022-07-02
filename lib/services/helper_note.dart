import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/services/notes_service.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:assignment2_2022/widgets/dialogues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void refreshNotesInUI(BuildContext context) async {
  String result = await context.read<NotesServie>().getNotes(
      context.read<UserService>().currentUser!.email,
      firstLoad); //TODO push repo after implementing this.
}

void saveNotesInUI(BuildContext context) async {}

void createNotesInUI(
  BuildContext context, {
  required TextEditingController titleController,
  required emailController,
  required messageController,
}) async {
  if (titleController.text.isEmpty) {
    showSnackbar(context, 'Please Enter a note first then save!');
  } else {
    Note note = Note(
      title: titleController.text.trim(),
      email: emailController,
      message: emailController,
    );
    if (context.read<NotesServie>().notes.contains(note)) {
      showSnackbar(context, 'Duplicate value. Please try again.');
    } else {
      titleController.text = '';
      context.read<NotesServie>().createNote(note);
      Navigator.pop(context);
    }
  }
}
