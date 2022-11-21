import 'package:flutter/material.dart';
import 'package:note_app/constant/colors_constant.dart';
import 'package:note_app/constant/style.dart';

class NoteMadeEditCardState extends StatefulWidget {
  NoteMadeEditCardState(
      {Key? key,
      required this.isFavorite,
      required this.title,
      required this.description,
      required this.isFavoriteController,
      required this.titleController,
      required this.descriptionController})
      : super(key: key);
  bool isFavoriteController;
  final String title;
  final String description;
  final bool isFavorite;
  final TextEditingController titleController;
  final TextEditingController descriptionController;

  @override
  State<NoteMadeEditCardState> createState() => _NoteMadeEditCardStateState();
}

class _NoteMadeEditCardStateState extends State<NoteMadeEditCardState> {
  @override
  void initState() {
    super.initState();
    widget.titleController.text = widget.title;
    widget.descriptionController.text = widget.description;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 13),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.83,
            width: MediaQuery.of(context).size.width,
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
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
                        width: MediaQuery.of(context).size.width * 0.65,
                        child: TextFormField(
                          cursorColor: kColor2,
                          controller: widget.titleController,
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
                    controller: widget.descriptionController,
                    maxLines: 10,
                    style: TextStyle(
                        fontFamily: 'SourceSansPro',
                        fontSize: 22,
                        color: kColor1.withOpacity(0.8)),
                    decoration: const InputDecoration(
                      hintText: "description",
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
    );
  }
}
