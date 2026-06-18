import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Thin top progress bar synced with [AuthLoading].
class AuthSyncProgressIndicator extends StatelessWidget {
  const AuthSyncProgressIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthBloc, AuthState>(
      buildWhen: (prev, curr) =>
          (prev is AuthLoading) != (curr is AuthLoading),
      builder: (context, state) {
        final isLoading = state is AuthLoading;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          height: isLoading ? 3 : 0,
          child: isLoading
              ? const _GradientProgressBar()
              : const SizedBox.shrink(),
        );
      },
    );
  }
}

class _GradientProgressBar extends StatefulWidget {
  const _GradientProgressBar();

  @override
  State<_GradientProgressBar> createState() => _GradientProgressBarState();
}

class _GradientProgressBarState extends State<_GradientProgressBar>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final width = constraints.maxWidth;
            final barWidth = width * 0.35;
            final left = (width + barWidth) * _controller.value - barWidth;
            return Stack(
              clipBehavior: Clip.hardEdge,
              children: [
                Container(color: AuthTheme.surfaceContainerLow),
                Positioned(
                  left: left,
                  top: 0,
                  bottom: 0,
                  width: barWidth,
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: AuthTheme.gradient,
                      boxShadow: [
                        BoxShadow(
                          color: AuthTheme.primary.withValues(alpha: 0.35),
                          blurRadius: 6,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
