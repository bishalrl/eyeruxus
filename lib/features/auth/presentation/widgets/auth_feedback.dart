import 'package:eye_rex_us/l10n/app_localizations.dart';

enum AuthFeedbackType { success, error, info }

class AuthFeedbackMessage {
  const AuthFeedbackMessage({
    required this.type,
    required this.message,
  });

  final AuthFeedbackType type;
  final String message;
}

abstract final class AuthFeedbackMapper {
  static AuthFeedbackMessage fromFailure(AppLocalizations l10n, String raw) {
    final lower = raw.toLowerCase();
    if (lower.contains('network') || lower.contains('connection') || lower.contains('socket')) {
      return AuthFeedbackMessage(type: AuthFeedbackType.error, message: l10n.authErrorNetwork);
    }
    if (lower.contains('401') ||
        lower.contains('credential') ||
        lower.contains('unauthorized') ||
        lower.contains('invalid')) {
      return AuthFeedbackMessage(type: AuthFeedbackType.error, message: l10n.authErrorInvalidCredentials);
    }
    if (lower.contains('email') && lower.contains('taken')) {
      return AuthFeedbackMessage(type: AuthFeedbackType.error, message: l10n.authErrorEmailTaken);
    }
    return AuthFeedbackMessage(type: AuthFeedbackType.error, message: l10n.authErrorGeneric);
  }

  static AuthFeedbackMessage signupSuccess(AppLocalizations l10n) =>
      AuthFeedbackMessage(type: AuthFeedbackType.success, message: l10n.authSuccessSignup);

  static AuthFeedbackMessage loginSuccess(AppLocalizations l10n) =>
      AuthFeedbackMessage(type: AuthFeedbackType.success, message: l10n.authSuccessLogin);

  static AuthFeedbackMessage resetSent(AppLocalizations l10n) =>
      AuthFeedbackMessage(type: AuthFeedbackType.success, message: l10n.authSuccessResetSent);

  static AuthFeedbackMessage termsRequired(AppLocalizations l10n) =>
      AuthFeedbackMessage(type: AuthFeedbackType.info, message: l10n.authInfoTermsRequired);
}
