import 'package:assignment2_2022/routes/route_manager.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class InitApp {
  static const String apiKeyAndroid =
      '3C970FBE-9114-498F-8C39-7A6670176E0D'; //This is our Key, if you update please inform all members
  static const String apiKeyIOS =
      '99CDB3FD-4EF4-4962-AD2F-F62CE75A8FD1'; //This is our Key, if you update please inform all members
  static const String appID =
      '24F998AD-AEE3-B297-FFA0-C690D9FB4400'; //This is our Key, if you update please inform all members

  static void initializeApp(BuildContext context) async {
    await Backendless.initApp(
        androidApiKey: apiKeyAndroid,
        iosApiKey: apiKeyIOS,
        applicationId: appID);
    String result = await context.read<UserService>().checkIfUserLoggedIn();
    if (result == 'Ok') {
      Navigator.popAndPushNamed(context, RouteManager.noteListPage);
    } else {
      Navigator.popAndPushNamed(context, RouteManager.loginPage);
    }
  }
}
