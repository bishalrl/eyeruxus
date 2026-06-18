import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_event.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_feedback_cubit.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_form_field.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback_scope.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_gradient_form_shell.dart';
import 'package:eye_rex_us/features/auth/presentation/widgets/auth_teal_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpPage extends StatelessWidget {
  const OtpPage({super.key, this.phoneNumber});

  final String? phoneNumber;

  @override
  Widget build(BuildContext context) {
    return AuthFeedbackScope(
      child: _OtpPageBody(phoneNumber: phoneNumber),
    );
  }
}

class _OtpPageBody extends StatefulWidget {
  const _OtpPageBody({this.phoneNumber});

  final String? phoneNumber;

  @override
  State<_OtpPageBody> createState() => _OtpPageBodyState();
}

class _OtpPageBodyState extends State<_OtpPageBody> {
  final _formKey = GlobalKey<FormState>();
  final _phoneController = TextEditingController();
  final _otpController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty) {
      _phoneController.text = widget.phoneNumber!;
    }
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _otpController.dispose();
    super.dispose();
  }

  void _verify() {
    if (!_formKey.currentState!.validate()) return;
    context.read<AuthFeedbackCubit>().clear();
    context.read<AuthBloc>().add(const AuthDevLoginRequested(provider: 'phone'));
  }

  void _resend() {
    context.read<AuthFeedbackCubit>().show(
          AuthFeedbackMessage(
            type: AuthFeedbackType.info,
            message: context.l10n.authOtpResent,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final hasPhone = widget.phoneNumber != null && widget.phoneNumber!.isNotEmpty;

    return AuthGradientFormShell(
      title: l10n.authOtpTitle,
      subtitle: l10n.authOtpSubtitle,
      bottomAction: AuthTealButton(
        label: l10n.authOtpVerify,
        onPressed: _verify,
      ),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            if (!hasPhone)
              AuthFormField(
                label: l10n.authPhoneLabel,
                controller: _phoneController,
                hint: '+91 00000 00000',
                keyboardType: TextInputType.phone,
                validator: (v) {
                  if (v == null || v.trim().length < 8) return l10n.authPhoneRequired;
                  return null;
                },
              ),
            AuthFormField(
              label: l10n.authOtpLabel,
              controller: _otpController,
              hint: l10n.authOtpHint,
              keyboardType: TextInputType.number,
              maxLength: 6,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (v) {
                if (v == null || v.length != 6) return l10n.authOtpInvalid;
                return null;
              },
            ),
            Align(
              alignment: Alignment.center,
              child: TextButton(
                onPressed: _resend,
                child: Text(
                  l10n.authOtpResend,
                  style: GoogleFonts.poppins(
                    color: AuthTheme.formTeal,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
