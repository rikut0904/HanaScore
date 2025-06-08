// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/state/koikoiState.dart';

class FinalRewardPage extends ConsumerStatefulWidget {
  final String winnerPlayer;
  const FinalRewardPage({super.key, required this.winnerPlayer});

  @override
  ConsumerState<FinalRewardPage> createState() => _FinalRewardPageState();
}

class _FinalRewardPageState extends ConsumerState<FinalRewardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HanaScore'),
      ),
      body: Center(
        child: Column(
          children: [
            const Text(
              '結果発表',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            widget.winnerPlayer == '引分け'
                ? Row(
                    children: [
                      const Icon(Icons.emoji_events,
                          size: 100, color: Colors.yellow),
                      const SizedBox(height: 20),
                      const Text('引分けです',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                    ],
                  )
                : Column(
                    children: [
                      const Text('Congratulations!',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.emoji_events,
                              size: 100, color: Colors.yellow),
                          const SizedBox(height: 20),
                          Text(
                            '勝者は${widget.winnerPlayer}です！',
                            style: const TextStyle(
                                fontSize: 30, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ref.read(monthProvider.notifier).state = 1;
                ref.read(addScoreProvider.notifier).state = 0;
                ref.read(ruleProvider.notifier).state = {};
                ref.read(playerScoreProvider.notifier).state = 50;
                ref.read(opponentScoreProvider.notifier).state = 50;
                ref.read(winnerProvider.notifier).state = true;
                ref.read(userAProvider.notifier).state = "初期値A";
                ref.read(userBProvider.notifier).state = "初期値B";
                Navigator.of(context).pop();
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: const Text(
                '終了する',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
