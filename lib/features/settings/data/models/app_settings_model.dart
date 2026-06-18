import '../../domain/entities/app_settings.dart';

class AppSettingsModel extends AppSettings {
  const AppSettingsModel({
    required super.languageCode,
    required super.pushNotificationsEnabled,
    required super.privacyModeEnabled,
    required super.securityLevel,
  });

  factory AppSettingsModel.fromJson(Map<String, dynamic> json) {
    return AppSettingsModel(
      languageCode: json['language_code'] as String? ?? 'en',
      pushNotificationsEnabled:
          json['push_notifications_enabled'] as bool? ?? true,
      privacyModeEnabled: json['privacy_mode_enabled'] as bool? ?? false,
      securityLevel: json['security_level'] as String? ?? 'medium',
    );
  }

  Map<String, dynamic> toJson() => {
        'language_code': languageCode,
        'push_notifications_enabled': pushNotificationsEnabled,
        'privacy_mode_enabled': privacyModeEnabled,
        'security_level': securityLevel,
      };
}
