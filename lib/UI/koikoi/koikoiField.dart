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
        color: widget.isPlayer
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
            child: Row(
              children: [
                widget.isPlayer
                    ? Text(
                        ref.read(userAProvider),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      )
                    : Text(
                        ref.read(userBProvider),
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        ),
                      ),
                const SizedBox(width: 100),
                Text(
                  '${widget.score}点',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: widget.isPlayer ? Colors.blue : Colors.red,
                  ),
                ),
              ],
            ),
          ),
          Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    if (widget.isPlayer) {
                      ref.read(winnerProvider.notifier).state = true;
                    } else {
                      ref.read(winnerProvider.notifier).state = false;
                    }
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RuleSelectPage(month: ref.watch(monthProvider)),
                      ),
                    );
                  },
                  child: const Text(
                    'この月の勝者はこちらをタップ',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(height: 5),
                (widget.isPlayer && ref.watch(koikoiPlayerProvider)) ||
                        (!widget.isPlayer && ref.watch(koikoiOpponentProvider))
                    ? Text(
                        "こいこい",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: widget.isPlayer ? Colors.blue : Colors.red,
                        ),
                      )
                    : ElevatedButton(
                        onPressed: () {
                          widget.isPlayer
                              ? ref.read(koikoiPlayerProvider.notifier).state =
                                  true
                              : ref
                                  .read(koikoiOpponentProvider.notifier)
                                  .state = true;
                        },
                        child: const Text(
                          "こいこいをする",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                const SizedBox(height: 5),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Transform.rotate(
                          angle: widget.isPlayer ? 0 : 3.14159,
                          child: AlertDialog(
                            title: const Text('警告'),
                            content: const Text('手札に同じ月が4枚ありましたか？？'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('いいえ'),
                              ),
                              TextButton(
                                onPressed: () {
                                  widget.isPlayer
                                      ? (
                                          ref
                                              .read(
                                                  playerScoreProvider.notifier)
                                              .state += 6,
                                          ref
                                              .read(opponentScoreProvider
                                                  .notifier)
                                              .state -= 6
                                        )
                                      : (
                                          ref
                                              .read(opponentScoreProvider
                                                  .notifier)
                                              .state += 6,
                                          ref
                                              .read(
                                                  playerScoreProvider.notifier)
                                              .state -= 6
                                        );
                                  ref.read(monthProvider.notifier).state =
                                      ref.watch(monthProvider) + 1;
                                  StateReset.resetState(ref);
                                  Navigator.pop(context);
                                },
                                child: const Text('はい'),
                              )
                            ],
                          ),
                        );
                      },
                    );
                  },
                  child: Text(
                    '手札に同じ月が4枚ある!',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
