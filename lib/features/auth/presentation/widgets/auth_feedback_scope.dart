import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_feedback_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Provides [AuthFeedbackCubit] for auth screens.
///
/// Place above any widget that calls `context.read<AuthFeedbackCubit>()`.
class AuthFeedbackScope extends StatelessWidget {
  const AuthFeedbackScope({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<AuthFeedbackCubit>(),
      child: child,
    );
  }
}

/// Returns [child] wrapped with [AuthFeedbackScope] only when no ancestor exists.
class AuthFeedbackProvider extends StatelessWidget {
  const AuthFeedbackProvider({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    try {
      context.read<AuthFeedbackCubit>();
      return child;
    } catch (_) {
      return AuthFeedbackScope(child: child);
    }
  }
}
