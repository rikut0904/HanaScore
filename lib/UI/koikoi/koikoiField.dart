// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/UI/koikoi/ruleSelectPage.dart';
import 'package:hana_score/state/koikoiState.dart';

class KoiKoiField extends ConsumerStatefulWidget {
  final bool isPlayer;
  final int score;
  const KoiKoiField({super.key, required this.isPlayer, required this.score});

  @override
  ConsumerState<KoiKoiField> createState() => _KoiKoiFieldState();
}

class _KoiKoiFieldState extends ConsumerState<KoiKoiField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        color:
            widget.isPlayer
                ? Colors.blue.withAlpha(26)
                : Colors.red.withAlpha(26),
        border: Border.all(
          color: widget.isPlayer ? Colors.blue : Colors.red,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        children: [
          // 点数表示
          Positioned(
            top: 10,
            right: 20,
            child: Text(
              '${widget.score}点',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: widget.isPlayer ? Colors.blue : Colors.red,
              ),
            ),
          ),
          Center(
            child: ElevatedButton(
              onPressed: () {
                if (widget.isPlayer) {
                  ref.read(winnerProvider.notifier).state = true;
                } else {
                  ref.read(winnerProvider.notifier).state = false;
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RuleSelectPage()),
                );
              },
              child: const Text(
                'この月の勝者はこちらをタップ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
