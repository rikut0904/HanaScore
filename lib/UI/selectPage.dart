// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hana_score/UI/koikoiPage.dart';
import 'package:hana_score/UI/helpPage.dart';

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
        title: const Text(
          'HanaScore',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final mainCardWidth = (constraints.maxWidth - 48) / 2;
          final mainCardHeight = mainCardWidth * 1.3;
          final subCardWidth = mainCardWidth * 0.7;
          final subCardHeight = subCardWidth * 1.3;

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const KoiKoiPage(),
                              ),
                            );
                          },
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
                                  color: Theme.of(context).colorScheme.primary,
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
                      child: Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const EawasePage(),
                            //   ),
                            // );
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: Text('絵合わせ'),
                                content: Text('絵合わせはまだ作成中です'),
                              ),
                            );
                          },
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
                                  color: Theme.of(context).colorScheme.primary,
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
                      child: Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const HelpPage(),
                              ),
                            );
                          },
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
                                  color: Theme.of(context).colorScheme.primary,
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
                      child: Card(
                        elevation: 4,
                        child: InkWell(
                          onTap: () {
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => const SettingPage(),
                            //   ),
                            // );
                            showDialog(
                              context: context,
                              builder: (context) => const AlertDialog(
                                title: Text('設定'),
                                content: Text('設定はまだ作成中です'),
                              ),
                            );
                          },
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
                                  color: Theme.of(context).colorScheme.primary,
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
          );
        },
      ),
    );
  }
}
