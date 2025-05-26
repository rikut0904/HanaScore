import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/state/hanaawaseState.dart';

class Eawase {
  final String name;
  final String image;
  final String description;

  Eawase({required this.name, required this.image, required this.description});
}

class Hanaawase {
  static void initializeGame(WidgetRef ref) {
    final months = ref.read(selectedMonthsProvider);
    final players = ref.read(selectedPlayersProvider);

    // プレイヤー数のスコア配列を初期化
    ref.read(playerScoresProvider.notifier).state = List.filled(players, 0);

    // 現在の月を1に設定
    ref.read(currentMonthProvider.notifier).state = 1;
  }

  static void nextMonth(WidgetRef ref) {
    final currentMonth = ref.read(currentMonthProvider);
    final totalMonths = ref.read(selectedMonthsProvider);

    if (currentMonth < totalMonths) {
      ref.read(currentMonthProvider.notifier).state = currentMonth + 1;
    }
  }

  static bool isGameFinished(WidgetRef ref) {
    final currentMonth = ref.read(currentMonthProvider);
    final totalMonths = ref.read(selectedMonthsProvider);
    return currentMonth > totalMonths;
  }
}
