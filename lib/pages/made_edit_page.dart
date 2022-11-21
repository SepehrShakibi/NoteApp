import 'package:flutter/material.dart';
import 'package:note_app/constant/colors_constant.dart';
import 'package:note_app/constant/style.dart';
import 'package:note_app/crud/notes_service.dart';
import 'package:note_app/dialog/delete_dialog.dart';
import 'package:note_app/enums/menu_action.dart';
import 'package:note_app/exentions/get_argument.dart';
import 'package:note_app/widgets/cicluarprogressIndicatorWithText.dart';
import 'package:share_plus/share_plus.dart';

class MadeEditNotePage extends StatefulWidget {
  const MadeEditNotePage({super.key});

  @override
  State<MadeEditNotePage> createState() => _MadeEditNotePageState();
}

class _MadeEditNotePageState extends State<MadeEditNotePage> {
  DatabaseNote? _note;
  late final NoteService _noteService;
  late final TextEditingController _titleController;
  late final TextEditingController _textController;
  late final String _dateTime;
  @override
  void initState() {
    _noteService = NoteService();
    _titleController = TextEditingController();
    _textController = TextEditingController();
    super.initState();
  }

  void _textControllerListner() async {
    final note = _note;
    if (note == null) {
      return;
    }
    final title = _titleController.text;
    final text = _textController.text;
    final dateTime =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    await _noteService.updateNote(
      note: note,
      title: title,
      text: text,
      dateTime: dateTime,
    );
  }

  void _setupTextControllerListner() {
    _textController.removeListener(_textControllerListner);
    _textController.addListener(_textControllerListner);

    _titleController.removeListener(_textControllerListner);
    _titleController.addListener(_textControllerListner);
  }

  Future<DatabaseNote> createOrGetExistingNote(BuildContext context) async {
    final widgetNote = context.getArgument<DatabaseNote>();
    if (widgetNote != null) {
      _note = widgetNote;
      _textController.text = widgetNote.text;
      _titleController.text = widgetNote.title;
      _dateTime = widgetNote.dateTime;
      return widgetNote;
    }

    final existingNote = _note;
    if (existingNote != null) {
      return existingNote;
    }

    final newNote = await _noteService.createNote();
    _note = newNote;
    return newNote;
  }

  void _deleteNoteIfTitleAndTextIsEmpty() {
    final note = _note;
    if (_textController.text == "" &&
        _titleController.text == "" &&
        note != null) {
      _noteService.deleteNote(id: note.id);
    }
  }

  void _saveNoteIfTextOrTitleNotEmpty() async {
    final note = _note;
    final text = _textController.text;
    final title = _titleController.text;
    final dateTime =
        "${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}";
    if (note != null &&
        (_textController.text.isNotEmpty || _titleController.text.isNotEmpty)) {
      await _noteService.updateNote(
        note: note,
        title: title,
        text: text,
        dateTime: dateTime,
      );
    }
  }

  @override
  void dispose() {
    _deleteNoteIfTitleAndTextIsEmpty();
    _saveNoteIfTextOrTitleNotEmpty();
    _textController.dispose();
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: createOrGetExistingNote(context),
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            _setupTextControllerListner();
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
                          ))
                    ]),
                  ),
                  elevation: 2,
                  leading: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                      ),
                      iconSize: 30,
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                  actions: [
                    PopupMenuButton<MenuAction>(
                      iconSize: 30,
                      onSelected: (value) async {
                        switch (value) {
                          case MenuAction.shareNote:
                            Share.share(
                              _titleController.text == ""
                                  ? _textController.text
                                  : '${_titleController.text}\n${_textController.text}',
                            );
                            break;
                          case MenuAction.deleteNote:
                            final shouldDelete =
                                await showDeleteDialog(context);
                            if (shouldDelete) {
                              _textController.text = '';
                              _titleController.text = '';
                              Navigator.pop(context);
                            }
                            break;
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem<MenuAction>(
                            value: MenuAction.shareNote,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.share,
                                  size: 28,
                                  color: kColor1,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Share',
                                  style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 23,
                                      color: kColor1),
                                ),
                              ],
                            )),
                        PopupMenuItem<MenuAction>(
                            value: MenuAction.deleteNote,
                            child: Row(
                              children: const [
                                Icon(
                                  Icons.delete,
                                  size: 28,
                                  color: kColor1,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'Delete',
                                  style: TextStyle(
                                      fontFamily: 'SourceSansPro',
                                      fontSize: 23,
                                      color: kColor1),
                                ),
                              ],
                            ))
                      ],
                    ),
                  ],
                ),
                body: SingleChildScrollView(
                  child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 13),
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.83,
                        width: MediaQuery.of(context).size.width,
                        padding:
                            const EdgeInsets.only(top: 20, left: 13, right: 13),
                        alignment: Alignment.centerLeft,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: kColor4,
                            boxShadow: [
                              BoxShadow(
                                  color: kColor1.withOpacity(0.6),
                                  offset: const Offset(5, 5),
                                  blurRadius: 5),
                              BoxShadow(
                                  color: kColor2.withOpacity(0.6),
                                  offset: const Offset(-5, -5),
                                  blurRadius: 5)
                            ]),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.baseline,
                            textBaseline: TextBaseline.alphabetic,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 50,
                                    width: MediaQuery.of(context).size.width *
                                        0.65,
                                    child: TextFormField(
                                      cursorColor: kColor2,
                                      controller: _titleController,
                                      style: kTitleTextStyle,
                                      decoration: const InputDecoration(
                                          hintText: "Title",
                                          hintStyle: TextStyle(
                                              fontFamily: 'Roboto',
                                              color: Colors.grey,
                                              fontSize: 25),
                                          border: InputBorder.none),
                                    ),
                                  ),
                                  const Spacer(),
                                ],
                              ),
                              const SizedBox(
                                height: 35,
                              ),
                              TextFormField(
                                cursorColor: kColor2,
                                controller: _textController,
                                maxLines: 10,
                                style: TextStyle(
                                    fontFamily: 'SourceSansPro',
                                    fontSize: 22,
                                    color: kColor1.withOpacity(0.8)),
                                decoration: const InputDecoration(
                                  hintText: "Write now...",
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontSize: 25,
                                      fontFamily: 'SourceSansPro'),
                                  border: InputBorder.none,
                                ),
                                keyboardType: TextInputType.multiline,
                              )
                            ],
                          ),
                        ),
                      )),
                ));

          default:
            return const CircluarProgressIndictaorWithText();
        }
      },
    );
  }
}
