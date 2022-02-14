// ignore_for_file: unused_element, unnecessary_string_interpolations

import 'package:flutter/material.dart';

class GlobalMethod{
  static Future<void> showErrorDialog({required String error, required BuildContext context}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (context) {
      return AlertDialog(
        title: const Text('Error Occured while signing in',
        style: TextStyle(
          fontSize: 20.0,
        )),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              // Text('This is a demo alert dialog.'),
              Text('$error',),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
}