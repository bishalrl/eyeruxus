import '../models/app_settings_model.dart';

abstract class SettingsLocalDataSource {
  Future<AppSettingsModel> getSettings();
  Future<AppSettingsModel> saveSettings(AppSettingsModel settings);
}

class SettingsLocalDataSourceImpl implements SettingsLocalDataSource {
  AppSettingsModel _cache = const AppSettingsModel(
    languageCode: 'en',
    pushNotificationsEnabled: true,
    privacyModeEnabled: false,
    securityLevel: 'medium',
  );

  @override
  Future<AppSettingsModel> getSettings() async => _cache;

  @override
  Future<AppSettingsModel> saveSettings(AppSettingsModel settings) async {
    _cache = settings;
    return _cache;
  }
}
