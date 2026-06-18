import 'package:eye_rex_us/l10n/app_localizations.dart';

abstract final class TimeHelper {
  static String getGreeting(AppLocalizations l10n) {
    final hour = DateTime.now().hour;
    if (hour < 12) return l10n.homeGreetingMorning;
    if (hour < 17) return l10n.homeGreetingAfternoon;
    return l10n.homeGreetingEvening;
  }
}
