// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/state/koikoiState.dart';
import 'package:hana_score/UI/koikoi/koikoiField.dart';

class KoiKoiPage extends ConsumerStatefulWidget {
  const KoiKoiPage({super.key});

  @override
  ConsumerState<KoiKoiPage> createState() => _KoiKoiPageState();
}

class _KoiKoiPageState extends ConsumerState<KoiKoiPage> {
  @override
  Widget build(BuildContext context) {
    int playerScore = ref.watch(playerScoreProvider);
    int opponentScore = ref.watch(opponentScoreProvider);
    int month = ref.watch(monthProvider);

    final size = MediaQuery.of(context).size;
    final padding = MediaQuery.of(context).padding;
    final topPadding = padding.top + 20;
    final fieldHeight = size.height * 0.35;

    if (month == 13) {
      return AlertDialog(
        title: const Text('終了'),
        content: const Text('12月でゲームは終了です。'),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('OK'),
          ),
        ],
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: topPadding),
            // 相手のフィールド
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Transform.rotate(
                angle: 3.14159, // 180度回転
                child: SizedBox(
                  height: fieldHeight,
                  child: KoiKoiField(isPlayer: false, score: opponentScore),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(width: 2.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (ref.watch(addScoreProvider) == 0) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('警告'),
                              content: const Text('スコアが0です。\n次の月に進んで大丈夫ですか？'),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'いいえ',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        month++;
                                        ref.read(monthProvider.notifier).state =
                                            month;
                                        ref
                                            .read(addScoreProvider.notifier)
                                            .state = 0;
                                        ref.read(ruleProvider.notifier).state =
                                            {};
                                        Navigator.of(context).pop();
                                      },
                                      child: Text(
                                        'はい',
                                        style: TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text(''),
                              content: const Text('次の月に進んで大丈夫ですか？'),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    TextButton(
                                      onPressed: () {
                                        month++;
                                        ref.read(monthProvider.notifier).state =
                                            month;
                                        ref
                                            .read(addScoreProvider.notifier)
                                            .state = 0;
                                        ref.read(ruleProvider.notifier).state =
                                            {};
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('いいえ'),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      child: const Text('はい'),
                                    ),
                                  ],
                                ),
                              ],
                            );
                          },
                        );
                      }
                    },
                    child: const Text(
                      '次のターン',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2.0),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      ref.read(monthProvider.notifier).state = 1;
                      ref.read(addScoreProvider.notifier).state = 0;
                      ref.read(ruleProvider.notifier).state = {};
                      ref.read(playerScoreProvider.notifier).state = 50;
                      ref.read(opponentScoreProvider.notifier).state = 50;
                      Navigator.of(context).pop();
                    },
                    child: const Text(
                      '終了する',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 2.0),
                Text(
                  '現在の月：$month',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 2.0),
              ],
            ),
            const SizedBox(height: 10),
            // プレイヤーのフィールド
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: SizedBox(
                height: fieldHeight,
                child: KoiKoiField(isPlayer: true, score: playerScore),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
