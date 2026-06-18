import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_feedback_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback_scope.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_inline_banner.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

typedef AuthStateListener = void Function(BuildContext context, AuthState state);

/// Orange gradient header + overlapping white form card (registration mockup).
class AuthGradientFormShell extends StatelessWidget {
  const AuthGradientFormShell({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.onAuthState,
    this.onBack,
    this.headerTrailing,
    this.footerNote,
    this.bottomAction,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final AuthStateListener? onAuthState;
  final VoidCallback? onBack;
  final Widget? headerTrailing;
  final String? footerNote;
  final Widget? bottomAction;

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
          backgroundColor: AuthTheme.formGradientEnd,
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
                child: Column(
                  children: [
                    _GradientHeader(
                      title: title,
                      subtitle: subtitle,
                      onBack: onBack ?? () => AppRouter.maybePop(context),
                      trailing: headerTrailing,
                    ),
                    Expanded(
                      child: Transform.translate(
                        offset: const Offset(0, -24),
                        child: Container(
                          width: double.infinity,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
                          ),
                          child: Column(
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 16),
                                  child: BlocBuilder<AuthBloc, AuthState>(
                                    builder: (context, state) => child,
                                  ),
                                ),
                              ),
                              if (bottomAction != null)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 12),
                                  child: bottomAction!,
                                ),
                              if (footerNote != null)
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                                  child: Text(
                                    footerNote!,
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.poppins(
                                      fontSize: 11,
                                      color: AuthTheme.formFooterNote,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GradientHeader extends StatelessWidget {
  const _GradientHeader({
    required this.title,
    required this.subtitle,
    required this.onBack,
    this.trailing,
  });

  final String title;
  final String subtitle;
  final VoidCallback onBack;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(gradient: AuthTheme.formHeaderGradient),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 20, 36),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: onBack,
                    icon: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12, right: 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            height: 1.2,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          subtitle,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white.withValues(alpha: 0.92),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (trailing != null)
                Positioned(
                  top: 8,
                  right: 0,
                  child: trailing!,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
