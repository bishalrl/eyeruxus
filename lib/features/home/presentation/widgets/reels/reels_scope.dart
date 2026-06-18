import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Route-scoped reels bloc — one instance per reels feed screen.
class ReelsScope extends StatelessWidget {
  const ReelsScope({
    super.key,
    required this.initialTab,
    required this.initialIndex,
    required this.child,
  });

  final ReelsFeedTab initialTab;
  final int initialIndex;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ReelsBloc>()
        ..add(
          ReelsStarted(
            initialTab: initialTab,
            initialIndex: initialIndex,
          ),
        ),
      child: child,
    );
  }
}
