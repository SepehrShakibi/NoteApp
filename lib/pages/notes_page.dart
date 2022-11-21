import 'package:flutter/material.dart';
import 'package:note_app/constant/colors_constant.dart';
import 'package:note_app/constant/routes.dart';
import 'package:note_app/crud/notes_service.dart';
import 'package:note_app/dialog/delete_dialog.dart';
import 'package:note_app/widgets/cicluarprogressIndicatorWithText.dart';
import 'package:note_app/widgets/note_card.dart';

enum NotePagesSubject { allNotes, favoriteNotes }

class NotesPage extends StatefulWidget {
  const NotesPage({Key? key}) : super(key: key);

  @override
  State<NotesPage> createState() => _NotesPageState();
}

class _NotesPageState extends State<NotesPage> {
  late final NoteService _noteService;

  @override
  void initState() {
    _noteService = NoteService();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: kColor2,
      appBar: AppBar(
        backgroundColor: kColor1,
        centerTitle: true,
        title: RichText(
          text: const TextSpan(children: [
            TextSpan(
              text: "Note ",
              style: TextStyle(
                  fontSize: 30,
                  fontFamily: 'JosefinSans',
                  color: kColor4,
                  fontWeight: FontWeight.bold),
            ),
            TextSpan(
                text: "App",
                style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'AbrilFatface',
                    color: Colors.white))
          ]),
        ),
        elevation: 2,
      ),
      floatingActionButton: SizedBox(
        height: 65,
        width: 65,
        child: FloatingActionButton(
          backgroundColor: kColor3,
          elevation: 15,
          onPressed: () async {
            Navigator.of(context).pushNamed(madeEditNoteRoute);
          },
          child: const Padding(
            padding: EdgeInsets.all(10.0),
            child: Icon(
              Icons.add,
              size: 30,
            ),
          ),
        ),
      ),
      body: FutureBuilder(
        future: _noteService.ensureDbIsOpen(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              return StreamBuilder(
                stream: _noteService.allNotes,
                builder: (context, snapshot) {
                  switch (snapshot.connectionState) {
                    case ConnectionState.waiting:
                    case ConnectionState.active:
                      if (snapshot.hasData) {
                        final allNotes = snapshot.data as List<DatabaseNote>;
                        return allNotes.isEmpty
                            ? GestureDetector(
                                onTap: () => Navigator.of(context)
                                    .pushNamed(madeEditNoteRoute),
                                child: Center(
                                  child: Container(
                                      width: size.width * 0.5,
                                      height: size.width * 0.5,
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 4, color: kColor1),
                                        borderRadius: BorderRadius.circular(15),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: const [
                                          Icon(
                                            Icons.note,
                                            size: 45,
                                            color: kColor1,
                                          ),
                                          Text(
                                            'You haven\'t any note!\nTap and write!',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: kColor1,
                                                fontFamily: 'SourceSansPro'),
                                            textAlign: TextAlign.center,
                                          )
                                        ],
                                      )),
                                ),
                              )
                            : GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  childAspectRatio: 1 / 1.5,
                                ),
                                itemCount: allNotes.length,
                                itemBuilder: (BuildContext context, int index) {
                                  final notes = allNotes.reversed.toList();
                                  final note = notes[index];
                                  return index == allNotes.length
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 20, horizontal: 13),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.pushNamed(
                                                  context, madeEditNoteRoute,
                                                  arguments: null);
                                            },
                                            child: Container(
                                              decoration: BoxDecoration(
                                                border: Border.all(
                                                  width: 4,
                                                  color: kColor1,
                                                ),
                                                borderRadius:
                                                    BorderRadius.circular(15),
                                              ),
                                              child: const Icon(
                                                Icons.add,
                                                color: kColor1,
                                                size: 80,
                                              ),
                                            ),
                                          ),
                                        )
                                      : NoteCard(
                                          title: note.title,
                                          description: note.text,
                                          isFavorite: true,
                                          index: index,
                                          dateTime: note.dateTime,
                                          note: note,
                                          onTap: (note) {
                                            Navigator.of(context).pushNamed(
                                                madeEditNoteRoute,
                                                arguments: note);
                                          },
                                          onLongpressTap: (note) async {
                                            final shouldDelete =
                                                await showDeleteDialog(context);
                                            if (shouldDelete) {
                                              await _noteService.deleteNote(
                                                id: note.id,
                                              );
                                            }
                                          },
                                        );
                                });
                      } else {
                        return const CircluarProgressIndictaorWithText();
                      }
                    default:
                      return const CircluarProgressIndictaorWithText();
                  }
                },
              );

            default:
              return const CircluarProgressIndictaorWithText();
          }
        },
      ),
    );
  }
}
