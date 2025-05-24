import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class PCRestrictionPage extends StatelessWidget {
  const PCRestrictionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'このアプリはモバイルデバイスでのみ利用可能です',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              '以下のQRコードをスマートフォンで読み取ってください',
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            QrImageView(
              data: Uri.base.toString(),
              version: QrVersions.auto,
              size: 200.0,
            ),
          ],
        ),
      ),
    );
  }
}
