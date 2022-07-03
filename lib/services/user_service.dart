import 'package:assignment2_2022/models/note.dart';
import 'package:assignment2_2022/models/noteEntry.dart';
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
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Sending Reset instructions, please wait...';
    notifyListeners();

    await Backendless.userService.restorePassword(username).onError(
        (error, stackTrace) =>
            {result = getHumanReadableError(error.toString())});
    _showUserProgress = false;
    notifyListeners();
    return result;
  }

  Future<String> loginUser(String username, String password) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Creating a new use... Please wait...';
    notifyListeners();
    BackendlessUser? user = await Backendless.userService
        .login(username, password, true)
        .onError((error, stackTrace) {
      result = getHumanReadableError(error.toString());
    });
    if (user != null) {
      _currentUser = user;
    }
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

  Future<String> logoutUser() async {
    String result = 'OK';
    _showUserProgress = true;
    _userProgressText = 'Logging you out... Please wait...';
    notifyListeners();

    await Backendless.userService.logout().onError((error, stackTrace) {
      result = error.toString();
    });
    _showUserProgress = false;
    notifyListeners();

    return result;
  }

  Future<String> checkIfUserLoggedIn() async {
    String result = 'OK';
    bool? validLogin = await Backendless.userService
        .isValidLogin()
        .onError((error, stackTrace) {
      result = error.toString();
    });

    if (validLogin != null && validLogin) {
      String? currentUserObjectID = await Backendless.userService
          .loggedInUser()
          .onError((error, stackTrace) {
        result = error.toString();
      });
      if (currentUserObjectID != null) {
        Map<dynamic, dynamic>? mapOfCurrentUser = await Backendless.data
            .of("Users")
            .findById(currentUserObjectID)
            .onError((error, stackTrace) {
          result = error.toString();
        });
        if (mapOfCurrentUser != null) {
          _currentUser = BackendlessUser.fromJson(mapOfCurrentUser);
          notifyListeners();
        } else {
          result = 'Not OK';
        }
      } else {
        result = 'NOT OK';
      }
    } else {
      result = 'NOT OK';
    }

    return result;
  }

  void checkIfUserExists(String username) async {
    DataQueryBuilder queryBuilder = DataQueryBuilder()
      ..whereClause = "email = '$username'";

    await Backendless.data
        .withClass<BackendlessUser>()
        .find(queryBuilder)
        .then((value) {
      if (value == null || value.isEmpty) {
        _userExists = false;
        notifyListeners();
      } else {
        _userExists = true;
        notifyListeners();
      }
    }).onError((error, stackTrace) {
      print(error.toString());
    });
  }

  Future<String> createUser(BackendlessUser user) async {
    String result = 'OK';

    _showUserProgress = true;
    _userProgressText = 'Setting up your profile please wait...';
    notifyListeners();

    try {
      await Backendless.userService.register(user);
      NoteEntry emptyNote = NoteEntry(notes: {}, username: user.email);
      await Backendless.data.of('NoteEntry').save(emptyNote.toJson())
          // ignore: body_might_complete_normally_nullable
          .onError((error, stackTrace) {
        result = error.toString();
      });
    } catch (e) {
      result = getHumanReadableError(e.toString());
    }
    _showUserProgress = false;
    notifyListeners();
    return result;
  }
}

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
