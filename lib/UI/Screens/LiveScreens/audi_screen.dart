import 'package:flutter/material.dart';

class PrevieAudio extends StatelessWidget {
  const PrevieAudio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Audio Preview')),
      body: const Center(child: Text('Audio Preview Screen')),
    );
  }
}
