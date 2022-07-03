import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'init.dart';
import 'routes/route_manager.dart';
import 'services/locator_service.dart';
import 'services/navigation_and_dialog_service.dart';
import 'services/user_service.dart';
import 'view_models/note_view_model.dart';
import 'view_models/user_management_view_model.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  InitApp.initializeApp;
  setupLocator();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => UserManagementViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => NoteViewModel(),
        ),
        ChangeNotifierProvider(
          create: (context) => UserService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner:
            false, //This will remove the red debug banner on emulator
        navigatorKey: navigatorKey,
        //this is how we know
        onGenerateRoute: RouteManager.onGenerateRoute,
        initialRoute: RouteManager.loadingPage,
      ),
    );
  }
}
