import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_event.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_feedback_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/forgot_password_form_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback_scope.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_gradient_form_shell.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_teal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFeedbackScope(
      child: BlocProvider(
        create: (_) => sl<ForgotPasswordFormCubit>(),
        child: const _ForgotPasswordPageBody(),
      ),
    );
  }
}

class _ForgotPasswordPageBody extends StatefulWidget {
  const _ForgotPasswordPageBody();

  @override
  State<_ForgotPasswordPageBody> createState() => _ForgotPasswordPageBodyState();
}

class _ForgotPasswordPageBodyState extends State<_ForgotPasswordPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthFeedbackCubit>().clear();
    context.read<AuthBloc>().add(
          AuthForgotPasswordRequested(email: _emailController.text.trim()),
        );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthPasswordResetSent) {
      context.read<AuthFeedbackCubit>().show(
            AuthFeedbackMapper.resetSent(context.l10n),
          );
      Future.delayed(const Duration(milliseconds: 1600), () {
        if (context.mounted) AppRouter.pop(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AuthGradientFormShell(
      title: l10n.authForgotTitle,
      subtitle: l10n.authForgotPasswordHeaderSubtitle,
      onAuthState: _onAuthState,
      bottomAction: BlocBuilder<ForgotPasswordFormCubit, ForgotPasswordFormState>(
        builder: (context, formState) {
          return BlocBuilder<AuthBloc, AuthState>(
            builder: (context, authState) {
              final isLoading = authState is AuthLoading;
              return AuthTealButton(
                label: l10n.authSendResetLink,
                onPressed: formState.canSubmit && !isLoading ? _submit : null,
              );
            },
          );
        },
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          final formCubit = context.read<ForgotPasswordFormCubit>();

          return Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 8),
                AuthFormField(
                  label: l10n.authEmailLabel,
                  controller: _emailController,
                  hint: l10n.authEmailHint,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: formCubit.setEmail,
                  validator: (v) {
                    if (v == null || v.trim().isEmpty) return l10n.authEmailRequired;
                    if (!v.contains('@')) return l10n.authEmailInvalid;
                    return null;
                  },
                ),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: isLoading ? null : () => AppRouter.pop(context),
                  child: Text(l10n.authReturnToSignIn),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
