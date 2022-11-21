import 'package:flutter/material.dart';
import 'package:note_app/constant/colors_constant.dart';
import 'package:note_app/constant/style.dart';

class SeeNoteCard extends StatelessWidget {
  const SeeNoteCard({
    Key? key,
    required this.index,
    required this.onTap,
    required this.title,
    required this.description,
    required this.isFavorite,
  }) : super(key: key);
  final int index;
  final VoidCallback onTap;

  final String title;
  final String description;
  final bool isFavorite;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
          child: Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  textBaseline: TextBaseline.alphabetic,
                  children: [
                    Row(children: [
                      Column(
                        children: [
                          Text(
                            title,
                            style: kTitleTextStyle,
                          ),
                        ],
                      ),
                      const Spacer(),
                      isFavorite == true
                          ? Icon(
                              Icons.star,
                              size: 25,
                              color: Colors.orange.shade700,
                            )
                          : Icon(
                              Icons.star_border,
                              size: 25,
                              color: Colors.orange.shade700,
                            )
                    ]),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      description,
                      maxLines: null,
                      style: TextStyle(
                          fontFamily: 'SourceSansPro',
                          fontSize: 22,
                          color: kColor1.withOpacity(0.8)),
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
                    child: const Text(
                      "08/14/2022",
                      style: TextStyle(
                          fontFamily: 'BebasNeue',
                          color: kColor4,
                          fontSize: 18),
                    ),
                  ))
            ],
          )),
    );
  }
}
