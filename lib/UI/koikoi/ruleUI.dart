// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/logic/koikoiPoint.dart';
import 'package:hana_score/state/koikoiState.dart';

class RuleUI {
  static Map<String, int> fourLightError(WidgetRef ref, BuildContext context,
      String rule, Map<String, int> ruleList) {
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
    final isPlayer = ref.watch(winnerProvider);
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Transform.rotate(
          angle: isPlayer ? 0 : 3.14159,
          child: AlertDialog(
            title: const Text('赤短・青短'),
            actions: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('短冊札は何枚ありますか(赤短・青短除く)'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          Point.point(ref, context, 11, '赤短・青短\n(10点)');
                        },
                        child: const Text('1枚'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Point.point(ref, context, 12, '赤短・青短\n(10点)');
                        },
                        child: const Text('2枚'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Point.point(ref, context, 13, '赤短・青短\n(10点)');
                        },
                        child: const Text('3枚'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Point.point(ref, context, 14, '赤短・青短\n(10点)');
                        },
                        child: const Text('4枚'),
                      ),
                    ],
                  ),
                ],
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
    final isPlayer = ref.watch(winnerProvider);

    if (rule == '猪鹿蝶(5点)') {
      title = '猪鹿蝶';
      content = 'タネ札は何枚ありますか(猪鹿蝶除く)';
    } else if (rule == '赤短(5点)') {
      title = '赤短';
      content = '短冊札は何枚ありますか(赤短除く)';
    } else if (rule == '青短(5点)') {
      title = '青短';
      content = '短冊札は何枚ありますか(青短除く)';
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
              title == '猪鹿蝶'
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 5, rule);
                              },
                              child: const Text('0枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 6, rule);
                              },
                              child: const Text('1枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 7, rule);
                              },
                              child: const Text('2枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 8, rule);
                              },
                              child: const Text('3枚'),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 9, rule);
                              },
                              child: const Text('4枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 10, rule);
                              },
                              child: const Text('5枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 11, rule);
                              },
                              child: const Text('6枚'),
                            )
                          ],
                        ),
                      ],
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          children: [
                            Text('※赤短・青短がいずれも3枚以上'),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text('ある場合は'),
                                TextButton(
                                    onPressed: () {
                                      RuleUI.atherTenEx(
                                          ref, context, '赤短・青短\n(10点)');
                                      Navigator.pop(context);
                                    },
                                    child: const Text('こちら'))
                              ],
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 5, rule);
                              },
                              child: const Text('短冊なし'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 6, rule);
                              },
                              child: const Text('1枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 7, rule);
                              },
                              child: const Text('2枚'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 8, rule);
                              },
                              child: const Text('3枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 9, rule);
                              },
                              child: const Text('4枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 10, rule);
                              },
                              child: const Text('5枚'),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 11, rule);
                              },
                              child: const Text('6枚'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                Point.point(ref, context, 12, rule);
                              },
                              child: const Text('7枚'),
                            ),
                          ],
                        )
                      ],
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
    final isPlayer = ref.watch(winnerProvider);

    if (rule == 'タネ(1点)') {
      title = 'タネ(1点)';
      content = 'タネ札は何枚ありますか';
    } else if (rule == 'タン(1点)') {
      title = 'タン(1点)';
      content = '短冊札は何枚ありますか';
    } else if (rule == 'カス(1点)') {
      title = 'カス(1点)';
      content = 'カス札は何枚ありますか';
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
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  title == 'タネ(1点)'
                      ? Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Point.point(ref, context, 1, 'タネ(1点)');
                                  },
                                  child: const Text('5枚'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Point.point(ref, context, 2, 'タネ(1点)');
                                  },
                                  child: const Text('6枚'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Point.point(ref, context, 3, 'タネ(1点)');
                                  },
                                  child: const Text('7枚'),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    Point.point(ref, context, 4, 'タネ(1点)');
                                  },
                                  child: const Text('8枚'),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Point.point(ref, context, 5, 'タネ(1点)');
                                  },
                                  child: const Text('9枚'),
                                ),
                              ],
                            ),
                          ],
                        )
                      : title == 'タン(1点)'
                          ? Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 1, 'タン(1点)');
                                        },
                                        child: const Text('5枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 2, 'タン(1点)');
                                        },
                                        child: const Text('6枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 3, 'タン(1点)');
                                        },
                                        child: const Text('7枚'),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 4, 'タン(1点)');
                                        },
                                        child: const Text('8枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 5, 'タン(1点)');
                                        },
                                        child: const Text('9枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 6, 'タン(1点)');
                                        },
                                        child: const Text('10枚'),
                                      ),
                                    ],
                                  )
                                ])
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 1, 'カス(1点)');
                                        },
                                        child: const Text('10枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 2, 'カス(1点)');
                                        },
                                        child: const Text('11枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 3, 'カス(1点)');
                                        },
                                        child: const Text('12枚'),
                                      ),
                                    ]),
                                Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 4, 'カス(1点)');
                                        },
                                        child: const Text('13枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 5, 'カス(1点)');
                                        },
                                        child: const Text('14枚'),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {
                                          Point.point(
                                              ref, context, 6, 'カス(1点)');
                                        },
                                        child: const Text('15枚'),
                                      ),
                                    ]),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 7, 'カス(1点)');
                                      },
                                      child: const Text('16枚'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 8, 'カス(1点)');
                                      },
                                      child: const Text('17枚'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 9, 'カス(1点)');
                                      },
                                      child: const Text('18枚'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 10, 'カス(1点)');
                                      },
                                      child: const Text('19枚'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 11, 'カス(1点)');
                                      },
                                      child: const Text('20枚'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 12, 'カス(1点)');
                                      },
                                      child: const Text('21枚'),
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 13, 'カス(1点)');
                                      },
                                      child: const Text('22枚'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 14, 'カス(1点)');
                                      },
                                      child: const Text('23枚'),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        Point.point(ref, context, 15, 'カス(1点)');
                                      },
                                      child: const Text('24枚'),
                                    ),
                                  ],
                                )
                              ],
                            ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
