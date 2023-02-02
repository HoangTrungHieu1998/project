import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MainDialog{
  MainDialog._();
  static final MainDialog instance = MainDialog._();

  Future showAlertDialog({
    required BuildContext context,
    required String title,
    required String content,
    required String defaultActionText,
  }) async {
    if (!Platform.isIOS) {
      return showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Center(
              child: Text(title)
          ),
          content: Text(content),
          actions: <Widget>[
            Center(
              child: ElevatedButton(
                child: Text(defaultActionText),
                onPressed: () => Navigator.of(context).pop(true),
              ),
            ),
          ],
        ),
      );
    }

    // todo : showDialog for ios
    return showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Container(
            alignment: Alignment.center,
            child: Text(title)
        ),
        content: Text(content),
        actions: <Widget>[
          Center(
            child: CupertinoDialogAction(
              child: Text(defaultActionText),
              onPressed: () => Navigator.of(context).pop(true),
            ),
          ),
        ],
      ),
    );
  }
}