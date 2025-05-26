import 'package:flutter_riverpod/flutter_riverpod.dart';

final selectedMonthsProvider = StateProvider<int>((ref) => 1);
final selectedPlayersProvider = StateProvider<int>((ref) => 2);
final currentMonthProvider = StateProvider<int>((ref) => 1);
final playerScoresProvider = StateProvider<List<int>>((ref) => [0, 0, 0, 0]);
