// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/UI/koikoi/koikoiResult.dart';
import 'package:hana_score/state/koikoiState.dart';

class KoiKoiPoint {
  static void point(
      WidgetRef ref, BuildContext context, Map<String, int> ruleList) {
    int addScore = ref.watch(addScoreProvider);
    if (addScore == 0) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('警告'),
            content: const Text('ポイントが0です。\n役を選択してください'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } else {
      if (addScore >= 7) {
        addScore *= 2;
      }
      final winner = ref.watch(winnerProvider);
      if (winner) {
        if (ref.watch(koikoiOpponentProvider)) {
          addScore *= 2;
        }
        ref.read(playerScoreProvider.notifier).state += addScore;
        ref.read(opponentScoreProvider.notifier).state -= addScore;
      } else {
        if (ref.watch(koikoiPlayerProvider)) {
          addScore *= 2;
        }
        ref.read(opponentScoreProvider.notifier).state += addScore;
        ref.read(playerScoreProvider.notifier).state -= addScore;
      }
      ref.read(monthProvider.notifier).state = ref.watch(monthProvider) + 1;
      StateReset.resetState(ref);
      if (ref.watch(monthProvider) >= 13) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('終了'),
              content: const Text('12月でゲームは終了です。'),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => FinalRewardPage(
                            winnerPlayer: ref.read(playerScoreProvider) >
                                    ref.read(opponentScoreProvider)
                                ? ref.read(userAProvider)
                                : ref.read(playerScoreProvider) ==
                                        ref.read(opponentScoreProvider)
                                    ? '引分け'
                                    : ref.read(userBProvider)),
                      ),
                    );
                  },
                  child: const Text('結果発表！！！'),
                ),
              ],
            );
          },
        );
      } else {
        Navigator.pop(context);
      }
    }
  }
}

class Point {
  static void point(WidgetRef ref, BuildContext context, int paperNum, String title) {
    Map<String, int> ruleList = ref.watch(ruleProvider);
    ref.read(addScoreProvider.notifier).state += (paperNum);
    ruleList[title] = paperNum;
    ref.read(ruleProvider.notifier).state = ruleList; 
    Navigator.pop(context);
  }
}
