import 'package:flutter/material.dart';
import 'package:note_app/constant/colors_constant.dart';

class CircluarProgressIndictaorWithText extends StatelessWidget {
  const CircluarProgressIndictaorWithText({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: const [
        CircularProgressIndicator(
          color: kColor1,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'Please wait a moment...',
          style: TextStyle(
            color: kColor1,
            fontSize: 22,
            fontFamily: 'BebasNeue',
          ),
        )
      ],
    ));
  }
}
