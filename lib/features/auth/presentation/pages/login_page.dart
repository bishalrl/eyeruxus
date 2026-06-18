import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_event.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_feedback_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/login_form_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/navigation/auth_routes.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_circular_icon_button.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback_scope.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_page_shell.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_social_pill_button.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_terms_footer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFeedbackScope(
      child: BlocProvider(
        create: (_) => sl<LoginFormCubit>(),
        child: const _LoginPageBody(),
      ),
    );
  }
}

class _LoginPageBody extends StatefulWidget {
  const _LoginPageBody();

  @override
  State<_LoginPageBody> createState() => _LoginPageBodyState();
}

class _LoginPageBodyState extends State<_LoginPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _ensureTerms(LoginFormState formState) {
    if (formState.acceptedTerms) return true;
    context.read<AuthFeedbackCubit>().show(
          AuthFeedbackMapper.termsRequired(context.l10n),
        );
    return false;
  }

  void _submit() {
    final formState = context.read<LoginFormCubit>().state;
    if (!_ensureTerms(formState)) return;
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthFeedbackCubit>().clear();
    context.read<AuthBloc>().add(
          AuthLoginRequested(
            email: _emailController.text.trim(),
            password: _passwordController.text,
          ),
        );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      context.read<AuthFeedbackCubit>().show(
            AuthFeedbackMapper.loginSuccess(context.l10n),
          );
    }
  }

  void _openPhoneLogin() {
    final formState = context.read<LoginFormCubit>().state;
    if (!_ensureTerms(formState)) return;
    AuthRoutes.openOtp(context);
  }

  void _onSocialTap(String provider) {
    final formState = context.read<LoginFormCubit>().state;
    if (!_ensureTerms(formState)) return;
    context.read<AuthFeedbackCubit>().clear();
    context.read<AuthBloc>().add(AuthDevLoginRequested(provider: provider));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AuthPageShell(
      background: AuthPageBackground.peach,
      maxWidth: 360,
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
      onAuthState: _onAuthState,
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final isLoading = authState is AuthLoading;

          return BlocBuilder<LoginFormCubit, LoginFormState>(
            builder: (context, formState) {
              final formCubit = context.read<LoginFormCubit>();

              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      l10n.authContinueWith,
                      textAlign: TextAlign.center,
                      style: AuthTheme.sectionTitle(context),
                    ),
                    const SizedBox(height: 16),
                    AuthSocialPillButton(
                      label: 'Google',
                      icon: const AuthSocialBrandIcon.google(),
                      enabled: !isLoading,
                      onPressed: () => _onSocialTap('Google'),
                    ),
                    const SizedBox(height: 10),
                    AuthSocialPillButton(
                      label: 'Apple',
                      icon: const AuthSocialBrandIcon.apple(),
                      enabled: !isLoading,
                      onPressed: () => _onSocialTap('Apple'),
                    ),
                    const SizedBox(height: 10),
                    AuthSocialPillButton(
                      label: 'Instagram',
                      icon: const AuthSocialBrandIcon.instagram(),
                      enabled: !isLoading,
                      onPressed: () => _onSocialTap('Instagram'),
                    ),
                    const SizedBox(height: 10),
                    AuthSocialPillButton(
                      label: 'Facebook',
                      icon: const AuthSocialBrandIcon.facebook(),
                      enabled: !isLoading,
                      onPressed: () => _onSocialTap('Facebook'),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      l10n.authTryAnotherLogin,
                      textAlign: TextAlign.center,
                      style: AuthTheme.captionMuted(context),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AuthCircularIconButton(
                          icon: Icons.person_outline,
                          tooltip: l10n.authSignIn,
                          enabled: !isLoading,
                          onPressed: formCubit.showEmailLogin,
                        ),
                        const SizedBox(width: 20),
                        AuthCircularIconButton(
                          icon: Icons.phone_iphone_outlined,
                          tooltip: 'Phone',
                          enabled: !isLoading,
                          onPressed: _openPhoneLogin,
                        ),
                        const SizedBox(width: 20),
                        AuthCircularIconButton(
                          icon: Icons.mail_outline,
                          tooltip: l10n.authEmailLabel,
                          enabled: !isLoading,
                          onPressed: formCubit.showEmailLogin,
                        ),
                      ],
                    ),
                    AnimatedSize(
                      duration: const Duration(milliseconds: 280),
                      curve: Curves.easeOutCubic,
                      alignment: Alignment.topCenter,
                      child: formState.method == LoginMethod.email
                          ? Padding(
                              padding: const EdgeInsets.only(top: 24),
                              child: _CredentialPanel(
                                emailController: _emailController,
                                passwordController: _passwordController,
                                obscurePassword: formState.obscurePassword,
                                isLoading: isLoading,
                                onTogglePassword: formCubit.togglePasswordVisibility,
                                onForgotPassword: () =>
                                    AuthRoutes.openForgotPassword(context),
                                onSubmit: _submit,
                              ),
                            )
                          : const SizedBox(width: double.infinity),
                    ),
                    const SizedBox(height: 28),
                    AuthTermsFooter(
                      value: formState.acceptedTerms,
                      enabled: !isLoading,
                      onChanged: formCubit.setAcceptedTerms,
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: '${l10n.authNoAccount} ',
                          style: AuthTheme.bodySm(context, color: AuthTheme.brandMuted),
                          children: [
                            WidgetSpan(
                              child: GestureDetector(
                                onTap: isLoading
                                    ? null
                                    : () => AuthRoutes.openSignup(context),
                                child: Text(
                                  l10n.authCreateAccount,
                                  style: AuthTheme.bodySm(context).copyWith(
                                    color: AuthTheme.brandAccent,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _CredentialPanel extends StatelessWidget {
  const _CredentialPanel({
    required this.emailController,
    required this.passwordController,
    required this.obscurePassword,
    required this.isLoading,
    required this.onTogglePassword,
    required this.onForgotPassword,
    required this.onSubmit,
  });

  final TextEditingController emailController;
  final TextEditingController passwordController;
  final bool obscurePassword;
  final bool isLoading;
  final VoidCallback onTogglePassword;
  final VoidCallback onForgotPassword;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AuthTheme.brandBorder.withValues(alpha: 0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _LoginField(
            controller: emailController,
            hint: l10n.authEmailHint,
            keyboardType: TextInputType.emailAddress,
            validator: (v) {
              if (v == null || v.trim().isEmpty) return l10n.authEmailRequired;
              if (!v.contains('@')) return l10n.authEmailInvalid;
              return null;
            },
          ),
          const SizedBox(height: 12),
          _LoginField(
            controller: passwordController,
            hint: l10n.authPasswordHint,
            obscureText: obscurePassword,
            validator: (v) {
              if (v == null || v.isEmpty) return l10n.authPasswordRequired;
              return null;
            },
            suffix: IconButton(
              icon: Icon(
                obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                size: 20,
                color: AuthTheme.brandMuted,
              ),
              onPressed: onTogglePassword,
            ),
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: isLoading ? null : onForgotPassword,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                l10n.authForgotPassword,
                style: AuthTheme.bodySm(context).copyWith(
                  color: AuthTheme.brandAccent,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          FilledButton(
            onPressed: isLoading ? null : onSubmit,
            style: FilledButton.styleFrom(
              backgroundColor: AuthTheme.brandAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
            ),
            child: Text(
              l10n.authSignIn,
              style: GoogleFonts.poppins(fontWeight: FontWeight.w600, fontSize: 15),
            ),
          ),
        ],
      ),
    );
  }
}

class _LoginField extends StatelessWidget {
  const _LoginField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.obscureText = false,
    this.validator,
    this.suffix,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool obscureText;
  final String? Function(String?)? validator;
  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      style: GoogleFonts.poppins(fontSize: 14, color: AuthTheme.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.poppins(fontSize: 14, color: AuthTheme.brandMuted),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AuthTheme.brandBorder.withValues(alpha: 0.5)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AuthTheme.brandBorder.withValues(alpha: 0.5)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AuthTheme.brandAccent, width: 1.5),
        ),
        suffixIcon: suffix,
      ),
    );
  }
}
