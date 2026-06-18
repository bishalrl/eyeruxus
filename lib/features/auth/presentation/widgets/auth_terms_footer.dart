import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/auth/presentation/theme/auth_theme.dart';
import 'package:flutter/material.dart';

/// Terms checkbox + linked copy from the eRupai login mockup.
class AuthTermsFooter extends StatelessWidget {
  const AuthTermsFooter({
    super.key,
    required this.value,
    required this.onChanged,
    this.enabled = true,
  });

  final bool value;
  final ValueChanged<bool?>? onChanged;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: value,
            onChanged: enabled ? onChanged : null,
            activeColor: AuthTheme.brandAccent,
            side: const BorderSide(color: AuthTheme.brandBorder, width: 1.5),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            visualDensity: VisualDensity.compact,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 2),
            child: Text.rich(
              TextSpan(
                text: l10n.authTermsAgreedPrefix,
                style: AuthTheme.bodySm(context),
                children: [
                  TextSpan(
                    text: l10n.authTermsOfServices,
                    style: AuthTheme.bodySm(context).copyWith(
                      color: AuthTheme.brandAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  TextSpan(text: l10n.authTermsAgreedAnd),
                  TextSpan(
                    text: l10n.authPrivacyPolicy,
                    style: AuthTheme.bodySm(context).copyWith(
                      color: AuthTheme.brandAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: '.'),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
