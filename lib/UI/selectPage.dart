// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/UI/koikoiPage.dart';
import 'package:hana_score/UI/helpPage.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:hana_score/state/koikoiState.dart';

class SelectPage extends ConsumerStatefulWidget {
  const SelectPage({super.key});

  @override
  ConsumerState<SelectPage> createState() => _SelectPageState();
}

class _SelectPageState extends ConsumerState<SelectPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Image.asset(
          'assets/HanaScoreLogo.png',
          height: 40,
          fit: BoxFit.contain,
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final mainCardWidth = (constraints.maxWidth - 48) / 2;
          final mainCardHeight = mainCardWidth * 1.3;
          final subCardWidth = mainCardWidth * 0.7;
          final subCardHeight = subCardWidth * 1.3;

          return RefreshIndicator(
            onRefresh: () async {
              if (kIsWeb) {
                await Future.delayed(const Duration(milliseconds: 500));
                if (mounted) {
                  setState(() {});
                }
              }
            },
            child: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                debugPrint('こいこいボタンがタップされました');
                                final TextEditingController playerAController =
                                    TextEditingController();
                                final TextEditingController playerBController =
                                    TextEditingController();

                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('こいこいを始める'),
                                        content: Scrollbar(
                                          child: SingleChildScrollView(
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Text(
                                                  'プレイヤーの名前を入力してください',
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                                TextField(
                                                  controller: playerAController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'プレイヤー1の名前',
                                                  ),
                                                ),
                                                const SizedBox(height: 16),
                                                TextField(
                                                  controller: playerBController,
                                                  decoration:
                                                      const InputDecoration(
                                                    labelText: 'プレイヤー2の名前',
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('キャンセル'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              if (playerAController
                                                      .text.isNotEmpty &&
                                                  playerBController
                                                      .text.isNotEmpty) {
                                                ref
                                                        .read(userAProvider
                                                            .notifier)
                                                        .state =
                                                    playerAController.text;
                                                ref
                                                        .read(userBProvider
                                                            .notifier)
                                                        .state =
                                                    playerBController.text;
                                                Navigator.of(context).pop();
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        const KoiKoiPage(),
                                                  ),
                                                );
                                              } else {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) =>
                                                      AlertDialog(
                                                    title: Text('エラー'),
                                                    content:
                                                        Text('プレイヤー名を入力してください'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () {
                                                          Navigator.of(context)
                                                              .pop();
                                                        },
                                                        child: const Text('OK'),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }
                                            },
                                            child: const Text('開始する'),
                                          ),
                                        ],
                                      );
                                    });
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Card(
                                elevation: 4,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withAlpha(230),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: mainCardWidth,
                                  height: mainCardHeight,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.casino,
                                        size: mainCardWidth * 0.4,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(height: mainCardHeight * 0.08),
                                      Text(
                                        'こいこい',
                                        style: TextStyle(
                                          fontSize: mainCardWidth * 0.16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                debugPrint('絵合わせボタンがタップされました');
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    title: Text('絵合わせ'),
                                    content: Text('絵合わせはまだ作成中です'),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Card(
                                elevation: 4,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withAlpha(230),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: mainCardWidth,
                                  height: mainCardHeight,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.image,
                                        size: mainCardWidth * 0.4,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(height: mainCardHeight * 0.08),
                                      Text(
                                        '絵合わせ',
                                        style: TextStyle(
                                          fontSize: mainCardWidth * 0.16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                debugPrint('ヘルプボタンがタップされました');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const HelpPage(),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Card(
                                elevation: 4,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withAlpha(230),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: subCardWidth,
                                  height: subCardHeight,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.help_outline,
                                        size: subCardWidth * 0.4,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(height: subCardHeight * 0.08),
                                      Text(
                                        'ヘルプ',
                                        style: TextStyle(
                                          fontSize: subCardWidth * 0.16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () {
                                debugPrint('設定ボタンがタップされました');
                                showDialog(
                                  context: context,
                                  builder: (context) => const AlertDialog(
                                    title: Text('設定'),
                                    content: Text('設定はまだ作成中です'),
                                  ),
                                );
                              },
                              borderRadius: BorderRadius.circular(12),
                              child: Card(
                                elevation: 4,
                                color: Theme.of(context)
                                    .colorScheme
                                    .surface
                                    .withAlpha(230),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Container(
                                  width: subCardWidth,
                                  height: subCardHeight,
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Icons.settings,
                                        size: subCardWidth * 0.4,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                      ),
                                      SizedBox(height: subCardHeight * 0.08),
                                      Text(
                                        '設定',
                                        style: TextStyle(
                                          fontSize: subCardWidth * 0.16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
