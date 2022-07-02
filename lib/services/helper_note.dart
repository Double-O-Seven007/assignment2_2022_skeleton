import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/services/notes_service.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:assignment2_2022/widgets/dialogues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void refreshNotesInUI(BuildContext context) async {
  String result = await context.read<NotesService>().getNotes(
        context.read<UserService>().currentUser!.email,
        firstLoad,
      ); //TODO push repo after implementing this.
  if (result != 'OK') {
    showSnackbar(context, result);
  } else {
    showSnackbar(context, 'Data successfuly retrieved from the database.');
  }
}

void saveNotesInUI(BuildContext context) async {
  String result = await context
      .read<NotesService>()
      .saveNotesEntry(context.read<UserService>().currentUser!.email, true);
  if (result != 'OK') {
    showSnackbar(context, result);
  } else {
    showSnackbar(context, 'Data successfully saved online!');
  }
}

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
    if (context.read<NotesService>().notes.contains(note)) {
      showSnackbar(context, 'Duplicate value. Please try again.');
    } else {
      titleController.text = '';
      context.read<NotesService>().createNote(note);
      Navigator.pop(context);
    }
  }
}
