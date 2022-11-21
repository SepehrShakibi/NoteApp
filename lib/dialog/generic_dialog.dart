import 'package:flutter/material.dart';
import 'package:note_app/constant/colors_constant.dart';

typedef DialogOption<T> = Map<String, T?> Function();

Future<T?> showGenericDialog<T>(
    {required BuildContext context,
    required String title,
    required String content,
    required DialogOption optionBuilder}) {
  final options = optionBuilder();
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          title,
          style: const TextStyle(
            color: kColor1,
            fontFamily: 'Roboto',
          ),
        ),
        actions: options.keys.map((optionTitle) {
          final value = options[optionTitle];
          return TextButton(
            onPressed: () {
              if (value != null) {
                Navigator.of(context).pop(value);
              }
            },
            child: Text(
              optionTitle,
              style: const TextStyle(
                color: kColor3,
                fontSize: 15.5,
              ),
            ),
          );
        }).toList(),
        content: Text(
          content,
          style: TextStyle(
              fontFamily: 'SourceSansPro',
              color: kColor1.withOpacity(0.8),
              fontSize: 18),
        ),
      );
    },
  );
}
