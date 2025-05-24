// ignore_for_file: file_names
import 'package:flutter/material.dart';

class EawasePage extends StatefulWidget {
  const EawasePage({super.key});

  @override
  State<EawasePage> createState() => _EawasePageState();
}

class _EawasePageState extends State<EawasePage> {
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
      body: const Center(child: Text('絵合わせ')),
    );
  }
}
