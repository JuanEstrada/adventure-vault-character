import 'package:flutter/material.dart';

void main() {
  runApp(const AdventureVaultApp());
}

class AdventureVaultApp extends StatelessWidget {
  const AdventureVaultApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventure Vault Character',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3A5A40)),
      ),
      home: const BootstrapScreen(),
    );
  }
}

class BootstrapScreen extends StatelessWidget {
  const BootstrapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure Vault Character'),
      ),
      body: const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'Flutter bootstrap ready. Next step: generate full platform '
            'scaffolding and implement the first MVP slice.',
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
