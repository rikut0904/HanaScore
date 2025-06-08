// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/state/koikoiState.dart';

class ErrorUI {
  static void errorDialog(BuildContext context, String rule, WidgetRef ref) {
    final isPlayer = ref.read(winnerProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: isPlayer ? 0 : 3.14159,
          child: AlertDialog(
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
          ),
        );
      },
    );
  }
}
