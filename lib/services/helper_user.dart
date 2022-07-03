import 'dart:math';

import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:assignment2_2022/widgets/dialogues.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void createNewUserInUI(
  BuildContext context, {
  required String email,
  required String password,
}) async {
  FocusManager.instance.primaryFocus?.unfocus();

  if (email.isEmpty || password.isEmpty) {
    showSnackbar(
      context,
      'Please enter all fields',
    );
  } else {
    BackendlessUser user = BackendlessUser()
      ..email = email.trim()
      ..password = password.trim();
    String results = await context.read<UserService>().createUser(user);
    if (results != 'OK') {
      showSnackbar(context, results);
    } else {
      showSnackbar(context, 'Success! New user created');
      Navigator.pop(context);
    }
  }
}

void loginUserInUI(BuildContext context,
    {required String email, required String password}) async {
  FocusManager.instance.primaryFocus?.unfocus();
  if (email.isEmpty || password.isEmpty) {
    showSnackbar(
      context,
      'Please enter all fields',
    );
  } else {
    String results = await context
        .read<UserService>()
        .loginUser(email.trim(), password.trim());

    if (results != 'OK') {
      showSnackbar(context, results);
    } else {
      Navigator.of(context).popAndPushNamed(RouteManager.noteListPage);
    }
  }
}

void resetPasswordInUI(BuildContext context, {required String email}) async {
  if (email.isEmpty) {
    showSnackbar(context, 'Please enter your email address');
  } else {
    String result =
        await context.read<UserService>().resetPassword(email.trim());
    if (result == 'OK') {
      showSnackbar(context, 'Reset sent to your email.');
    } else {
      showSnackbar(context, result);
    }
  }
}

void logoutUserInUI(BuildContext context) async {
  String result = await context.read<UserService>().logoutUser();
  if (result == 'OK') {
    context.read<UserService>().setCurrentUserNulL();
    Navigator.popAndPushNamed(context, RouteManager.loginPage);
  } else {
    showSnackbar(context, result);
  }
}
