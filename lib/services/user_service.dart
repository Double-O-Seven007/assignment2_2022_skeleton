import 'package:assignment2_2022/models/note.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';

class UserService with ChangeNotifier {
  ///** Important The fields added currently will assist with the UI as progress is made.

  BackendlessUser? _currentUser;
  BackendlessUser? get currentUser => _currentUser;

  void setCurrentUserNulL() {
    _currentUser = null;
  }

  bool _userExists = false;
  bool get userExists => _userExists;

  set userExists(bool value) {
    _userExists = value;
    notifyListeners();
  }

  bool _showUserProgress = false;
  bool get showUserProgress => _showUserProgress;

  String _userProgressText = '';
  String get showUserText => _userProgressText;

  Future<String> resetPassword(String username) async {
    String result = 'Yes, Reset Password!';
    return result;
  }

  Future<String> loginUser(String username, String password) async {
    String result = 'OK';
    return result;
  }

  Future<String> logoutUser() async {
    String result = 'OK';
    return result;
  }

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';
    return result;
  }

  void checkIfUserExists(String username) async {}

  Future<String> createUser(BackendlessUser user) async {
    String results = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Setting up your profile please wait...';
    notifyListeners();

    try {
      await Backendless.userService.register(user);
      // NoteEntry emptyEntry = NoteEntry(Note(title: title, email: email, message: message); {},username: user.email)
    } catch (e) {
      results = getHumanReadableError(e.toString());
    }
    return results;
  }
}

/// *TODO use differet wording in messages.
String getHumanReadableError(String message) {
  if (message.contains('email address must be confirmed first')) {
    return 'Please check your inbox and confirm your email address and try to login again';
  }
  if (message.contains('User already exist')) {
    return 'This user already exists in our databases. Please create new user.';
  }
  if (message.contains('Invalid login or password')) {
    return 'pelase check your username and password. The combinations do not match';
  }
  if (message
      .contains('User account is locked out due to too many failed logins')) {
    return 'Your account as been locked out dure to too many failed login attempts. Wait 30 min and try again';
  }
  if (message.contains('Unable to find a user with the specified identity')) {
    return 'your email address does not exist in our databases. Please check for spelling mistakes.';
  }
  if (message.contains(
      'Unable to resloves host "api.backendless.com": No address associated with hostname')) {
    return 'it seems as if you do not have an internet connection. Please connect again';
  }
  return message;
}
