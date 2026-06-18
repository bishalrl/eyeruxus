import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_feedback_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_aura_background.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback_scope.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_inline_banner.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

typedef AuthStateListener = void Function(BuildContext context, AuthState state);

enum AuthPageBackground { aura, peach, plain }

/// Reusable auth layout: back button, synced progress, inline feedback, themed body.
class AuthPageShell extends StatelessWidget {
  const AuthPageShell({
    super.key,
    required this.child,
    this.showBackButton = false,
    this.onBack,
    this.onAuthState,
    this.maxWidth = 480,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
    this.background = AuthPageBackground.aura,
  });

  final Widget child;
  final bool showBackButton;
  final VoidCallback? onBack;
  final AuthStateListener? onAuthState;
  final double maxWidth;
  final EdgeInsets padding;
  final AuthPageBackground background;

  Color _scaffoldColor(AuthPageBackground style) => switch (style) {
        AuthPageBackground.peach => AuthTheme.brandPeach,
        AuthPageBackground.plain => AuthTheme.background,
        AuthPageBackground.aura => AuthTheme.background,
      };

  @override
  Widget build(BuildContext context) {
    return AuthFeedbackProvider(
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            context.read<AuthFeedbackCubit>().show(
                  AuthFeedbackMapper.fromFailure(context.l10n, state.message),
                );
          }
          onAuthState?.call(context, state);
        },
        child: Scaffold(
          backgroundColor: _scaffoldColor(background),
          appBar: showBackButton
              ? AppBar(
                  backgroundColor: _scaffoldColor(background).withValues(alpha: 0.92),
                  elevation: 0,
                  scrolledUnderElevation: 0,
                  leading: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                    color: background == AuthPageBackground.peach
                        ? AuthTheme.brandAccent
                        : AuthTheme.primary,
                    onPressed: onBack ?? () => AppRouter.maybePop(context),
                  ),
                )
              : null,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const AuthSyncProgressIndicator(),
              BlocBuilder<AuthFeedbackCubit, AuthFeedbackMessage?>(
                builder: (context, feedback) {
                  if (feedback == null) return const SizedBox.shrink();
                  return AuthInlineBanner(
                    feedback: feedback,
                    onDismiss: context.read<AuthFeedbackCubit>().clear,
                  );
                },
              ),
              Expanded(
                child: _BodyBackground(
                  style: background,
                  child: SafeArea(
                    top: !showBackButton,
                    child: Center(
                      child: SingleChildScrollView(
                        padding: padding,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(maxWidth: maxWidth),
                          child: BlocBuilder<AuthBloc, AuthState>(
                            builder: (context, state) => child,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _BodyBackground extends StatelessWidget {
  const _BodyBackground({required this.style, required this.child});

  final AuthPageBackground style;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return switch (style) {
      AuthPageBackground.aura => AuthAuraBackground(child: child),
      AuthPageBackground.peach => child,
      AuthPageBackground.plain => child,
    };
  }
}
