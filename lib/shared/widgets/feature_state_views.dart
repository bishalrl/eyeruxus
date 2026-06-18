import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:flutter/material.dart';

class FeatureLoadingView extends StatelessWidget {
  const FeatureLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}

class FeatureErrorView extends StatelessWidget {
  const FeatureErrorView({super.key, required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Text(
          message,
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge?.copyWith(
            color: context.colors.error,
          ),
        ),
      ),
    );
  }
}
