// ignore_for_file: file_names
import 'package:flutter/material.dart';

class ErrorUI {
  static void errorDialog(BuildContext context, String rule) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('エラー'),
          content: Text('$ruleは既に選択されています'),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
