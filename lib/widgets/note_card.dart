import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:note_app/constant/colors_constant.dart';
import 'package:note_app/constant/style.dart';
import 'package:note_app/crud/notes_service.dart';

typedef NoteCallback = void Function(DatabaseNote note);

class NoteCard extends StatelessWidget {
  const NoteCard({
    Key? key,
    required this.index,
    required this.onTap,
    required this.title,
    required this.description,
    required this.isFavorite,
    required this.dateTime,
    required this.note,
    required this.onLongpressTap,
  }) : super(key: key);

  final int index;
  final NoteCallback onTap;
  final NoteCallback onLongpressTap;
  final String title;
  final String description;
  final bool isFavorite;
  final String dateTime;
  final DatabaseNote note;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap(note);
      },
      onLongPress: () {
        onLongpressTap(note);
      },
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
          child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.9,
            width: MediaQuery.of(context).size.height * 0.8,
            child: Stack(
              children: [
                Container(
                  padding: const EdgeInsets.only(top: 20, left: 13, right: 13),
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
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: Column(
                                children: [
                                  Text(
                                    title,
                                    style: kTitleTextStyle,
                                    maxLines: 1,
                                  ),
                                ],
                              ),
                            ),
                          ]),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        description,
                        maxLines: 4,
                        style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 22,
                            color: kColor1.withOpacity(0.8)),
                        softWrap: true,
                        overflow: TextOverflow.fade,
                      ),
                      const Spacer(),
                    ],
                  ),
                ),
                Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: const EdgeInsets.only(right: 5),
                      height: 40,
                      width: 100,
                      decoration: const BoxDecoration(
                          color: kColor3,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(35),
                              bottomRight: Radius.circular(12))),
                      child: Text(
                        dateTime,
                        style: const TextStyle(
                            fontFamily: 'BebasNeue',
                            color: kColor4,
                            fontSize: 18),
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
