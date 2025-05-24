// ignore_for_file: file_names
import 'package:flutter_riverpod/flutter_riverpod.dart';

final playerScoreProvider = StateProvider<int>((ref) => 50);
final opponentScoreProvider = StateProvider<int>((ref) => 50);
final addScoreProvider = StateProvider<int>((ref) => 0);
final winnerProvider = StateProvider<bool>((ref) => true);  //trueならプレイヤー、falseなら相手
final ruleProvider = StateProvider<Map<String, int>>((ref) => {});
final monthProvider = StateProvider<int>((ref) => 1);
