// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/logic/koikoi.dart';
import 'package:hana_score/state/koikoiState.dart';

class RuleSelectPage extends ConsumerStatefulWidget {
  final int month;
  const RuleSelectPage({super.key, required this.month});

  @override
  ConsumerState<RuleSelectPage> createState() => _RuleSelectPageState();
}

class _RuleSelectPageState extends ConsumerState<RuleSelectPage> {
  final List<String> rules = [
    '五光(10点)',
    '四光(8点)',
    '三光(5点)',
    '花見で一杯\n(5点)',
    '月見で一杯\n(5点)',
    '猪鹿蝶(5点)',
    '赤短(5点)',
    '青短(5点)',
    '赤短・青短\n(10点)',
    'タネ(1点)',
    'タン(1点)',
    'カス(1点)',
  ];

  @override
  Widget build(BuildContext context) {
    final point = ref.watch(addScoreProvider);
    final isPlayer = ref.watch(winnerProvider);

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: SafeArea(
        child: Transform.rotate(
          angle: isPlayer ? 0 : 3.14159, // プレイヤーの場合は0度、オポーネントの場合は180度
          child: Column(
            children: [
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 24),
                  ),
                  const SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ElevatedButton(
                      onPressed: () {
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
                            ref.read(playerScoreProvider.notifier).state +=
                                addScore;
                            ref.read(opponentScoreProvider.notifier).state -=
                                addScore;
                          } else {
                            ref.read(opponentScoreProvider.notifier).state +=
                                addScore;
                            ref.read(playerScoreProvider.notifier).state -=
                                addScore;
                          }
                          ref.read(monthProvider.notifier).state =
                              widget.month + 1;
                          ref.read(addScoreProvider.notifier).state = 0;
                          ref.read(ruleProvider.notifier).state = {};
                          Navigator.pop(context);
                        }
                      },
                      child: const Text(
                        '役の入力を終わる',
                        style: TextStyle(fontSize: 16, color: Colors.black),
                      ),
                    ),
                  ),
                  const SizedBox(width: 5.0),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'ポイント: $point',
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    final cardWidth =
                        (constraints.maxWidth - 48) / 4; // カードの幅を大きく
                    final cardHeight = cardWidth * 1.5; // カードの高さを調整

                    return GridView.builder(
                      padding: const EdgeInsets.all(16.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: cardWidth / cardHeight,
                        crossAxisSpacing: 16.0,
                        mainAxisSpacing: 16.0,
                      ),
                      itemCount: rules.length,
                      itemBuilder: (context, index) {
                        return _buildRuleCard(
                          context,
                          rules[index],
                          cardWidth,
                          cardHeight,
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRuleCard(
    BuildContext context,
    String rule,
    double cardWidth,
    double cardHeight,
  ) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: () {
          KoiKoi.condition(ref, context, rule);
        },
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.casino,
                size: cardWidth * 0.5,
                color: Theme.of(context).colorScheme.primary,
              ),
              SizedBox(height: cardHeight * 0.1),
              Text(
                rule,
                style: TextStyle(
                  fontSize: cardWidth * 0.25,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
