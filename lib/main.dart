import 'package:flutter/material.dart';
import 'package:note_app/constant/routes.dart';
import 'package:note_app/pages/made_edit_page.dart';
import 'pages/notes_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: notesRoute,
    routes: {
      notesRoute: (context) => const NotesPage(),
      madeEditNoteRoute: (context) => const MadeEditNotePage(),
    },
  ));
}
