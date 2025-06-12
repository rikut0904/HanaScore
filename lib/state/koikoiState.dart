// ignore_for_file: file_names
import 'package:flutter_riverpod/flutter_riverpod.dart';

// プレイヤーのスコア
final playerScoreProvider = StateProvider<int>((ref) => 50);
// 相手のスコア
final opponentScoreProvider = StateProvider<int>((ref) => 50);
// 追加スコア
final addScoreProvider = StateProvider<int>((ref) => 0);

// 各ターン勝者フラグ（true: プレイヤー、false: 相手）
final winnerProvider = StateProvider<bool>((ref) => true);

// こいこいをしたかのフラグ(プレイヤー)
final koikoiPlayerProvider = StateProvider<bool>((ref) => false);
// こいこいをしたかのフラグ(プレイヤー)
final koikoiOpponentProvider = StateProvider<bool>((ref) => false);

// 役のリスト
final ruleProvider = StateProvider<Map<String, int>>((ref) => {});

// 現在の月
final monthProvider = StateProvider<int>((ref) => 1);

// ユーザー名
final userAProvider = StateProvider<String>((ref) => "初期値A");
final userBProvider = StateProvider<String>((ref) => "初期値B");

class StateReset {
  static void resetState(WidgetRef ref) {
    ref.read(addScoreProvider.notifier).state = 0;
    ref.read(winnerProvider.notifier).state = true;
    ref.read(koikoiPlayerProvider.notifier).state = false;
    ref.read(koikoiOpponentProvider.notifier).state = false;
    ref.read(ruleProvider.notifier).state = {};
  }

  static void allResetState(WidgetRef ref) {
    ref.read(monthProvider.notifier).state = 1;
    ref.read(addScoreProvider.notifier).state = 0;
    ref.read(winnerProvider.notifier).state = true;
    ref.read(koikoiPlayerProvider.notifier).state = false;
    ref.read(koikoiOpponentProvider.notifier).state = false;
    ref.read(ruleProvider.notifier).state = {};
    ref.read(playerScoreProvider.notifier).state = 50;
    ref.read(opponentScoreProvider.notifier).state = 50;
    ref.read(userAProvider.notifier).state = "初期値A";
    ref.read(userBProvider.notifier).state = "初期値B";
  }
}
