import 'package:flutter/material.dart';

class PreviewWindow extends StatelessWidget {
  const PreviewWindow({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview Window')),
      body: const Center(child: Text('Preview Window Screen')),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Dashboard')),
      body: const Center(child: Text('Dashboard Screen')),
    );
  }
}
