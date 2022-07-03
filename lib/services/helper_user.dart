import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/notes_service.dart';
import 'package:assignment2_2022/widgets/dialogues.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void createNewUserInUI(BuildContext context,
    {required String email,
    required String password,
    required String name}) async {}
void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackbar(context, 'Please Enter both fields');
  } else {
    context.read<NotesService>().getNotes(email);
    Navigator.of(context).popAndPushNamed(RouteManager
        .noteListPage); //TODO I am not sure if I selected the correct route here, double check for me please.
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {}

void logoutUserInUI(BuildContext context) async {}
