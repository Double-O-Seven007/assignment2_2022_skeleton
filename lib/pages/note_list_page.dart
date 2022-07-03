import 'package:assignment2_2022/services/helper_note.dart';
import 'package:assignment2_2022/services/notes_service.dart';
import 'package:assignment2_2022/services/user_service.dart';
import 'package:backendless_sdk/backendless_sdk.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart' as provider;

import '../routes/route_manager.dart';
import '../services/locator_service.dart';
import '../services/navigation_and_dialog_service.dart';

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
            onPressed: () {},
            icon: const Icon(Icons.lock),
          ),
          //Here is our refresh button, I can't really see it, style it as you see fit.
          IconButton(
            onPressed: () {
              refreshNotesInUI(context);
            },
            icon: const Icon(Icons.refresh),
          ),
          //This is the Icon that saves our list of notes

          IconButton(
            onPressed: () {
              saveNotesInUI(context);
            },
            icon: const Icon(Icons.save),
          ),
          IconButton(
            onPressed: () {
              locator
                  .get<NavigationAndDialogService>()
                  .navigateTo(RouteManager.noteCreatePage);
            },
            icon: const Icon(Icons.add),
          ),
        ],
        automaticallyImplyLeading: false,
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: provider.Selector<UserService, BackendlessUser?>(
            selector: (context, value) => value.currentUser,
            builder: (context, value, child) {
              return value == null
                  ? const Text('Todo List')
                  : Text('${value.getProperty('name')}\'s Notes List');
            },
          ),
        ),
      ),
      body: provider.Consumer<NotesService>(
        builder: (context, value, child) {
          return ListView.builder(
            itemCount: value.notes.length,
            itemBuilder: (context, index) {
              return ListTile(
                onTap: () {},
                title: const Text('Title'),
              );
            },
          );
        },
      ),
    );
  }
}
