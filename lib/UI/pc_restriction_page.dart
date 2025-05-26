import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PCRestrictionPage extends StatelessWidget {
  const PCRestrictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 400),
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.warning_amber_rounded,
                size: 80,
                color: Colors.orange,
              ),
              const SizedBox(height: 20),
              const Text(
                'このアプリはモバイル端末専用です',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                '以下のQRコードをスマートフォンで読み取って\n'
                'アプリにアクセスしてください',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 30),
              QrImageView(
                data: 'https://hana-score.web.app',
                version: QrVersions.auto,
                size: 200.0,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
