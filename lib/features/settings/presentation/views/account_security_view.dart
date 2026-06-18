import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/core/theme/app_colors.dart';
import 'package:eye_rex_us/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AccountSecurityView extends StatelessWidget {
  const AccountSecurityView({super.key});

  String _securityLabel(BuildContext context, String level) {
    final l10n = context.l10n;
    switch (level.toLowerCase()) {
      case 'high':
        return l10n.settingsSecurityHigh;
      case 'low':
        return l10n.settingsSecurityLow;
      default:
        return l10n.settingsSecurityMedium;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        final level = state is SettingsLoaded
            ? _securityLabel(context, state.settings.securityLevel)
            : l10n.settingsSecurityMedium;

        return Scaffold(
          backgroundColor: colors.scaffoldBackground,
          appBar: AppBar(
            backgroundColor: colors.scaffoldBackground,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary, size: 18.sp),
              onPressed: () => AppRouter.pop(context),
            ),
            title: Text(
              l10n.settingsAccountSecurity,
              style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
            ),
            centerTitle: true,
          ),
          body: SafeArea(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              children: [
                SizedBox(height: 20.h),
                Icon(Icons.shield, color: colors.info, size: 80.sp),
                SizedBox(height: 8.h),
                Text(
                  '${l10n.settingsSecurityLevel} $level',
                  textAlign: TextAlign.center,
                  style: textTheme.titleMedium?.copyWith(color: colors.info),
                ),
                SizedBox(height: 24.h),
                _SettingsRow(title: l10n.settingsSecurityPassword, colors: colors, textTheme: textTheme),
                _SettingsRow(title: l10n.settingsLanguage, colors: colors, textTheme: textTheme),
                _SettingsRow(title: l10n.settingsBlacklist, colors: colors, textTheme: textTheme),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({
    required this.title,
    required this.colors,
    required this.textTheme,
  });

  final String title;
  final AppColors colors;
  final TextTheme textTheme;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(title, style: textTheme.bodyLarge?.copyWith(color: colors.textPrimary)),
      trailing: Icon(Icons.chevron_right, color: colors.textMuted),
      onTap: () {},
    );
  }
}
