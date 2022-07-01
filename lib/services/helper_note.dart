import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/widgets/dialogues.dart';
import 'package:flutter/material.dart';

void refreshNotesInUI(BuildContext context) async {}

void saveNotesInUI(BuildContext context) async {}

void createNotesInUI(BuildContext context,
    {required TextEditingController titleController,
    required emailController,
    required messageController}) async {
  if (titleController.text.isEmpty) {
    showSnackbar(context, 'Please Enter a note then save!');
  } else {
    Note note = Note(
        title: titleController.text.trim(),
        email: emailController,
        message: emailController);
  }
}
