// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/state/koikoiState.dart';

class FinalRewardPage extends ConsumerStatefulWidget {
  const FinalRewardPage({super.key});

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
            Row(
              children: [
                const Icon(Icons.emoji_events, size: 100, color: Colors.yellow),
                const SizedBox(height: 20),
                const Text('Congratulations!',
                    style:
                        TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                Text(
                  '勝者は${ref.read(userAProvider)}です！',
                  style: const TextStyle(
                      fontSize: 30, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
