import 'package:eye_rex_us/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

extension ContextX on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  AppColors get colors =>
      Theme.of(this).extension<AppColors>() ?? AppColors.light;

  TextTheme get textTheme => Theme.of(this).textTheme;

  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  void unfocus() => FocusScope.of(this).unfocus();
}
