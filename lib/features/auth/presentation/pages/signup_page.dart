import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_event.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_feedback_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/signup_form_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/navigation/auth_routes.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_gender_selector.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback_scope.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_gradient_form_shell.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_profile_avatar_picker.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_teal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class _CountryOption {
  const _CountryOption(this.name, this.flag);
  final String name;
  final String flag;
}

const _countries = [
  _CountryOption('India', '🇮🇳'),
  _CountryOption('United States', '🇺🇸'),
  _CountryOption('United Kingdom', '🇬🇧'),
  _CountryOption('Canada', '🇨🇦'),
  _CountryOption('Australia', '🇦🇺'),
];

class SignupPage extends StatelessWidget {
  const SignupPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AuthFeedbackScope(
      child: BlocProvider(
        create: (_) => sl<SignupFormCubit>(),
        child: const _SignupPageBody(),
      ),
    );
  }
}

class _SignupPageBody extends StatefulWidget {
  const _SignupPageBody();

  @override
  State<_SignupPageBody> createState() => _SignupPageBodyState();
}

class _SignupPageBodyState extends State<_SignupPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _nicknameController = TextEditingController();
  final _dobController = TextEditingController();
  final _countryController = TextEditingController(text: '🇮🇳  India');
  final _inviterController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nicknameController.dispose();
    _dobController.dispose();
    _countryController.dispose();
    _inviterController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _pickDateOfBirth() async {
    final formCubit = context.read<SignupFormCubit>();
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: formCubit.state.dateOfBirth ??
          DateTime(now.year - 18, now.month, now.day),
      firstDate: DateTime(1950),
      lastDate: now,
      builder: (context, child) => Theme(
        data: Theme.of(context).copyWith(
          colorScheme: const ColorScheme.light(primary: AuthTheme.formTeal),
        ),
        child: child!,
      ),
    );
    if (picked == null) return;
    final label = DateFormat('yyyy-MM-dd').format(picked);
    _dobController.text = label;
    formCubit.setDateOfBirth(picked, label);
  }

  Future<void> _pickCountry() async {
    final formCubit = context.read<SignupFormCubit>();
    final selected = await showModalBottomSheet<_CountryOption>(
      context: context,
      builder: (context) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: _countries
              .map(
                (c) => ListTile(
                  leading: Text(c.flag, style: const TextStyle(fontSize: 22)),
                  title: Text(c.name),
                  onTap: () => Navigator.pop(context, c),
                ),
              )
              .toList(),
        ),
      ),
    );
    if (selected == null) return;
    final label = '${selected.flag}  ${selected.name}';
    _countryController.text = label;
    formCubit.setCountry(label);
  }

  void _submit() {
    final formState = context.read<SignupFormCubit>().state;
    if (!_formKey.currentState!.validate()) return;
    if (formState.dateOfBirth == null) {
      context.read<AuthFeedbackCubit>().show(
            AuthFeedbackMessage(
              type: AuthFeedbackType.info,
              message: context.l10n.authDateOfBirthRequired,
            ),
          );
      return;
    }

    context.read<AuthFeedbackCubit>().clear();
    context.read<AuthBloc>().add(
          AuthRegisterRequested(
            username: _nicknameController.text.trim(),
            email: _emailController.text.trim(),
            password: _passwordController.text,
            passwordConfirmation: _confirmPasswordController.text,
            role: 'user',
          ),
        );
  }

  void _onAuthState(BuildContext context, AuthState state) {
    if (state is AuthAuthenticated) {
      return;
    }
    if (state is AuthUnauthenticated) {
      context.read<AuthFeedbackCubit>().show(
            AuthFeedbackMapper.signupSuccess(context.l10n),
          );
      Future.delayed(const Duration(milliseconds: 1800), () {
        if (!context.mounted) return;
        AuthRoutes.replaceWithLogin(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return AuthGradientFormShell(
      title: l10n.authUserRegistrationTitle,
      subtitle: l10n.authUserRegistrationSubtitle,
      footerNote: l10n.authRegistrationFooterNote,
      onAuthState: _onAuthState,
      headerTrailing: AuthProfileAvatarPicker(
        onTap: () {
          context.read<AuthFeedbackCubit>().show(
                const AuthFeedbackMessage(
                  type: AuthFeedbackType.info,
                  message: 'Profile photo upload coming soon.',
                ),
              );
        },
      ),
      bottomAction: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          final isLoading = state is AuthLoading;
          return AuthTealButton(
            label: l10n.authSave,
            onPressed: isLoading ? null : _submit,
          );
        },
      ),
      child: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, authState) {
          final isLoading = authState is AuthLoading;

          return BlocBuilder<SignupFormCubit, SignupFormState>(
            builder: (context, formState) {
              final formCubit = context.read<SignupFormCubit>();

              return Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AuthFormField(
                      label: l10n.authNicknameLabel,
                      controller: _nicknameController,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? l10n.authNicknameRequired : null,
                      suffix: IconButton(
                        icon: const Icon(Icons.close, size: 18, color: AuthTheme.brandMuted),
                        onPressed: isLoading ? null : () => _nicknameController.clear(),
                      ),
                    ),
                    AuthFormField(
                      label: l10n.authDateOfBirthLabel,
                      controller: _dobController,
                      readOnly: true,
                      onTap: isLoading ? null : _pickDateOfBirth,
                      validator: (v) =>
                          v == null || v.isEmpty ? l10n.authDateOfBirthRequired : null,
                    ),
                    AuthFormField(
                      label: l10n.authCountryLabel,
                      controller: _countryController,
                      readOnly: true,
                      onTap: isLoading ? null : _pickCountry,
                      validator: (v) =>
                          v == null || v.trim().isEmpty ? l10n.authCountryRequired : null,
                    ),
                    AuthFormField(
                      label: l10n.authInviterLabel,
                      labelSuffix: l10n.authInviterDisclaimer,
                      controller: _inviterController,
                      hint: l10n.authInviterHint,
                    ),
                    AuthFormField(
                      label: l10n.authEmailLabel,
                      controller: _emailController,
                      hint: l10n.authEmailSignupHint,
                      keyboardType: TextInputType.emailAddress,
                      validator: (v) {
                        if (v == null || v.trim().isEmpty) return l10n.authEmailRequired;
                        if (!v.contains('@')) return l10n.authEmailInvalid;
                        return null;
                      },
                    ),
                    AuthFormField(
                      label: l10n.authPasswordLabel,
                      controller: _passwordController,
                      hint: l10n.authPasswordHint,
                      obscureText: true,
                      validator: (v) {
                        if (v == null || v.length < 6) return l10n.authPasswordMinLength;
                        return null;
                      },
                    ),
                    AuthFormField(
                      label: l10n.authConfirmPasswordLabel,
                      controller: _confirmPasswordController,
                      hint: l10n.authPasswordHint,
                      obscureText: true,
                      validator: (v) {
                        if (v != _passwordController.text) return l10n.authPasswordMismatch;
                        return null;
                      },
                    ),
                    const SizedBox(height: 4),
                    AuthGenderSelector(
                      value: formState.gender,
                      maleLabel: l10n.authMale,
                      femaleLabel: l10n.authFemale,
                      enabled: !isLoading,
                      onChanged: formCubit.setGender,
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
