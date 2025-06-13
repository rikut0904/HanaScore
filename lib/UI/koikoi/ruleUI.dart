// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/state/koikoiState.dart';

class RuleUI {
  static Map<String, int> fourLightError(WidgetRef ref, BuildContext context, String rule, Map<String, int> ruleList) {
    final isPlayer = ref.watch(winnerProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: isPlayer ? 0 : 3.14159,
          child: AlertDialog(
            title: rule == '四光(8点)' ? const Text('四光') : const Text('雨四光'),
            content: rule == '四光(8点)'
                ? Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('雨四光と共存ができません'),
                      const Text('五光を選択しますか？')
                    ],
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('四光と共存ができません'),
                      const Text('五光を選択しますか？')
                    ],
                  ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('いいえ'),
              ),
              ElevatedButton(
                onPressed: () {
                  if (rule == '四光(8点)') {
                    ruleList.remove('四光(8点)');
                    ref.read(addScoreProvider.notifier).state -= 8;
                    ref.read(ruleProvider.notifier).state = ruleList;
                  } else if (rule == '雨四光(7点)') {
                    ruleList.remove('雨四光(7点)');
                    ref.read(addScoreProvider.notifier).state -= 7;
                    ref.read(ruleProvider.notifier).state = ruleList;
                  }
                  ruleList['五光(10点)'] = 10;
                  ref.read(ruleProvider.notifier).state = ruleList;
                  Navigator.pop(context);
                },
                child: const Text('はい'),
              ),
            ],
          ),
        );
      },
    );
    return ruleList;
  }

  static void threeLight(WidgetRef ref, BuildContext context) {
    Map<String, int> ruleList = ref.watch(ruleProvider);
    final isPlayer = ref.watch(winnerProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: isPlayer ? 0 : 3.14159,
          child: AlertDialog(
            title: const Text('三光'),
            content: const Text('柳が入っていませんか？'),
            actions: [
              ElevatedButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Transform.rotate(
                        angle: isPlayer ? 0 : 3.14159,
                        child: AlertDialog(
                          title: const Text('警告'),
                          content: const Text('三光を柳で成立させることができません。'),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text('いいえ'),
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(addScoreProvider.notifier).state += 5;
                  ruleList['三光(5点)'] = 5;
                  ref.read(ruleProvider.notifier).state = ruleList;
                  Navigator.pop(context);
                },
                child: const Text('はい'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void atherTenEx(WidgetRef ref, BuildContext context, String rule) {
    int paperNum = 0;
    Map<String, int> ruleList = ref.watch(ruleProvider);
    final isPlayer = ref.watch(winnerProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: isPlayer ? 0 : 3.14159,
          child: AlertDialog(
            title: const Text('赤短・青短'),
            content: const Text('短冊は何枚ありますか(赤短・青短除く)'),
            actions: [
              TextField(
                onChanged: (value) {
                  paperNum = int.parse(value);
                },
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(addScoreProvider.notifier).state += (10 + paperNum);
                  ruleList['赤短・青短\n(10点)'] = 10 + paperNum;
                  ref.read(ruleProvider.notifier).state = ruleList;
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void atherFiveEx(WidgetRef ref, BuildContext context, String rule) {
    String title = '';
    String content = '';
    Map<String, int> ruleList = ref.watch(ruleProvider);
    int paperNum = 0;
    final isPlayer = ref.watch(winnerProvider);

    if (rule == '猪鹿蝶(5点)') {
      title = '猪鹿蝶';
      content = 'タネ札は何枚ありますか(猪鹿蝶除く)';
    } else if (rule == '赤短(5点)') {
      title = '赤短';
      content = 'タネ札は何枚ありますか(赤短除く)';
    } else if (rule == '青短(5点)') {
      title = '青短';
      content = 'タネ札は何枚ありますか(青短除く)';
    } else {
      title = '';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: isPlayer ? 0 : 3.14159,
          child: AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextField(
                onChanged: (value) {
                  paperNum = int.parse(value);
                },
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  ref.read(addScoreProvider.notifier).state += (5 + paperNum);
                  ruleList[rule] = 5 + paperNum;
                  ref.read(ruleProvider.notifier).state = ruleList;
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }

  static void atherOneEx(WidgetRef ref, BuildContext context, String rule) {
    String title = '';
    String content = '';
    Map<String, int> ruleList = ref.watch(ruleProvider);
    int paperNum = 0;
    int ruleNum = 0;
    final isPlayer = ref.watch(winnerProvider);

    if (rule == 'タネ(1点)') {
      title = 'タネ(1点)';
      content = 'タネ札は何枚ありますか';
      ruleNum = 5;
    } else if (rule == 'タン(1点)') {
      title = 'タン(1点)';
      content = 'タネ札は何枚ありますか';
      ruleNum = 5;
    } else if (rule == 'カス(1点)') {
      title = 'カス(1点)';
      content = 'タネ札は何枚ありますか';
      ruleNum = 10;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: isPlayer ? 0 : 3.14159,
          child: AlertDialog(
            title: Text(title),
            content: Text(content),
            actions: [
              TextField(
                onChanged: (value) {
                  paperNum = int.parse(value);
                },
                keyboardType: TextInputType.number,
              ),
              ElevatedButton(
                onPressed: () {
                  if (paperNum >= ruleNum) {
                    paperNum -= (ruleNum - 1);
                  } else if (paperNum < ruleNum) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Transform.rotate(
                          angle: isPlayer ? 0 : 3.14159,
                          child: AlertDialog(
                            title: const Text('エラー'),
                            content: Text('$ruleNum枚では$ruleは成立しません'),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                    return;
                  }
                  ref.read(addScoreProvider.notifier).state += paperNum;
                  ruleList[rule] = paperNum;
                  ref.read(ruleProvider.notifier).state = ruleList;
                  Navigator.pop(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    );
  }
}
