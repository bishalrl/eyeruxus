import 'package:flutter/material.dart';

class LiveBattleScreen extends StatelessWidget {
  const LiveBattleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Live Battle')),
      body: const Center(child: Text('Live Battle Screen')),
    );
  }
}
