// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/logic/hanaawase.dart';
import 'package:hana_score/state/hanaawaseState.dart';

class HanaawasePage extends ConsumerStatefulWidget {
  const HanaawasePage({super.key});

  @override
  ConsumerState<HanaawasePage> createState() => _HanaawasePageState();
}

class _HanaawasePageState extends ConsumerState<HanaawasePage> {
  @override 
  void initState() {
    super.initState();
    // ゲームの初期化
    Hanaawase.initializeGame(ref);
  }

  @override
  Widget build(BuildContext context) {
    final selectedMonths = ref.watch(selectedMonthsProvider);
    final selectedPlayers = ref.watch(selectedPlayersProvider);
    final currentMonth = ref.watch(currentMonthProvider);
    final playerScores = ref.watch(playerScoresProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text(
          'HanaScore',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                DropdownButton<int>(
                  value: selectedMonths,
                  items: List.generate(12, (index) => index + 1)
                      .map((month) => DropdownMenuItem(
                            value: month,
                            child: Text('$monthヶ月'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(selectedMonthsProvider.notifier).state = value;
                      Hanaawase.initializeGame(ref);
                    }
                  },
                ),
                DropdownButton<int>(
                  value: selectedPlayers,
                  items: [2, 3, 4]
                      .map((players) => DropdownMenuItem(
                            value: players,
                            child: Text('$players人'),
                          ))
                      .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      ref.read(selectedPlayersProvider.notifier).state = value;
                      Hanaawase.initializeGame(ref);
                    }
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              '現在の月: $currentMonth',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: selectedPlayers,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('プレイヤー ${index + 1}'),
                  trailing: Text('スコア: ${playerScores[index]}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
