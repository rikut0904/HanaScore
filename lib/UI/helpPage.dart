// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});

  @override
  State<HelpPage> createState() => _HelpPageState();
}

class _HelpPageState extends State<HelpPage> {
  final List<Map<String, String>> helpItems = [
    {
      'title': '花札のルール',
      'content': '・2人で対戦するゲームです\n'
          '・手札8枚、場札8枚で開始します\n'
          '・手札から1枚出し、場札と合わせて役を作ります\n',
    },
    {
      'title': '花合わせのルール',
      'content': '・2人で対戦するゲームです\n'
          '・手札8枚、場札8枚で開始します\n'
          '・手札から1枚出し、場札と合わせて花を揃えます\n'
          '・同じ月の札を揃えると得点になります\n',
    },
    {
      'title': '役一覧',
      'content': '・光：20点\n'
          '・タネ：10点\n'
          '・タン：5点\n'
          '・カス：1点',
    },
    {'title': '使い方', 'content': 'アプリの基本的な使い方です。\n'},
  ];

  Future<void> _launchURL() async {
    final Uri url = Uri.parse(
      'https://www.nintendo.com/jp/others/hanafuda_kabufuda/howtoplay/koikoi/index.html',
    );
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('URLを開けませんでした: $url');
    }
  }

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
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: helpItems.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.only(bottom: 16.0),
            child: ExpansionTile(
              title: Text(
                helpItems[index]['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        helpItems[index]['content']!,
                        style: const TextStyle(fontSize: 16),
                      ),
                      if (index == 2) // 役一覧の場合
                        TextButton(
                          onPressed: _launchURL,
                          child: const Text(
                            '詳しくはこちら',
                            style: TextStyle(
                              color: Colors.blue,
                              fontSize: 16,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
