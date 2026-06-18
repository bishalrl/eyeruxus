import 'package:equatable/equatable.dart';

class AppSettings extends Equatable {
  final String languageCode;
  final bool pushNotificationsEnabled;
  final bool privacyModeEnabled;
  final String securityLevel;

  const AppSettings({
    required this.languageCode,
    required this.pushNotificationsEnabled,
    required this.privacyModeEnabled,
    required this.securityLevel,
  });

  @override
  List<Object?> get props =>
      [languageCode, pushNotificationsEnabled, privacyModeEnabled, securityLevel];
}
