import 'package:flutter/material.dart';

import '../routes/route_manager.dart';
import '../services/locator_service.dart';
import '../services/navigation_and_dialog_service.dart';
import '../services/helper_user.dart';

class NoteListPage extends StatefulWidget {
  const NoteListPage({Key? key}) : super(key: key);

  @override
  State<NoteListPage> createState() => _NoteListPageState();
}

class _NoteListPageState extends State<NoteListPage>
    with WidgetsBindingObserver {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () {
                locator
                    .get<NavigationAndDialogService>()
                    .navigateTo(RouteManager.noteCreatePage);
              },
              icon: const Icon(Icons.add),
            ),
            IconButton(
              onPressed: () {
                logoutUserInUI(context);
              },
              icon: const Icon(Icons.exit_to_app),
            ),
          ],
          automaticallyImplyLeading: false,
          title: const Text('List of Notes'),
        ),
        body: ListView.builder(
          itemCount: 2,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () {},
              title: const Text('Title'),
            );
          },
        ));
  }
}
