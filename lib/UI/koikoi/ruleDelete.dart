// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/state/koikoiState.dart';

class RuleDelete extends ConsumerStatefulWidget {
  final bool isPlayer;
  const RuleDelete({super.key, required this.isPlayer});

  @override
  ConsumerState<RuleDelete> createState() => _RuleDeleteState();
}

class _RuleDeleteState extends ConsumerState<RuleDelete> {
  @override
  Widget build(BuildContext context) {
    final ruleMap = ref.watch(ruleProvider);
    final ruleKeys = ruleMap.keys.toList();

    // 役がなければ自動的に前の画面に戻る
    if (ruleMap.isEmpty) {
      // popで戻る際に、buildの戻り値として何かWidgetを返す必要があるため、空のContainerを返す
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        Navigator.pop(context);
        await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('お知らせ'),
            content: const Text('削除可能な役がありません。'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('OK'),
              ),
            ],
          ),
        );
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: Transform.rotate(
          angle: widget.isPlayer ? 0 : 3.14159, // プレイヤーの場合は0度、オポーネントの場合は180度
          child: Column(
            children: [
              const SizedBox(height: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.arrow_back,
                        color: Colors.black, size: 24),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              const Text('削除する役を選択してください'),
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
                      itemCount: ruleKeys.length,
                      itemBuilder: (context, index) {
                        final rule = ruleKeys[index];
                        return Card(
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              // 役を削除し、スコアも減算
                              final value = ruleMap[rule] ?? 0;
                              final newRuleMap = Map<String, int>.from(ruleMap);
                              newRuleMap.remove(rule);
                              ref.read(ruleProvider.notifier).state =
                                  newRuleMap;
                              ref.read(addScoreProvider.notifier).state -=
                                  value;
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.casino,
                                    size: cardWidth * 0.5,
                                    color:
                                        Theme.of(context).colorScheme.primary,
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
}
