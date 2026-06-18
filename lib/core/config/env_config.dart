import 'package:flutter_dotenv/flutter_dotenv.dart';

abstract final class EnvConfig {
  static String get baseUrl {
    if (!dotenv.isInitialized) return _defaultBaseUrl;
    return dotenv.env['BASE_URL']?.trim() ?? _defaultBaseUrl;
  }

  /// Empty base URL keeps local datasource fallbacks working in dev.
  static const _defaultBaseUrl = '';

  /// Frontend-only mode: auth uses local mock sessions instead of the API.
  static bool get isFrontendDev => baseUrl.isEmpty;
}
