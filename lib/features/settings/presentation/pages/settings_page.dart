import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:eye_rex_us/shared/widgets/settings_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  void initState() {
    super.initState();
    context.read<SettingsBloc>().add(const SettingsLoadRequested());
  }

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
        final securityLevel = state is SettingsLoaded
            ? _securityLabel(context, state.settings.securityLevel)
            : l10n.settingsSecurityMedium;
        final showBadge = state is SettingsLoaded
            ? state.settings.pushNotificationsEnabled
            : true;

        return Scaffold(
      backgroundColor: colors.settingsBackground,
      appBar: AppBar(
        backgroundColor: colors.settingsBackground,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary, size: 20),
          onPressed: () => AppRouter.pop(context),
        ),
        title: Text(
          l10n.settingsTitle,
          style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                children: [
                  const SizedBox(height: 10),
                  SettingsListTile(
                    title: l10n.settingsAccountSecurity,
                    showBadge: showBadge,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Row(
                      children: [
                        Text(
                          l10n.settingsSecurityLevel,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.settingsAccent,
                          ),
                        ),
                        Text(
                          securityLevel,
                          style: textTheme.bodyMedium?.copyWith(
                            color: colors.settingsAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  SettingsListTile(title: l10n.settingsSecurityPassword),
                  const SizedBox(height: 16),
                  SettingsListTile(title: l10n.settingsLanguage),
                  const SizedBox(height: 16),
                  SettingsListTile(title: l10n.settingsBlacklist),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => AppRouter.navigateTo(
                      AppRoutes.privilegeSettings,
                    ),
                    child: SettingsListTile(title: l10n.settingsPrivilege),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    onTap: () => AppRouter.navigateTo(
                      AppRoutes.newMessagesNotification,
                    ),
                    child: SettingsListTile(title: l10n.settingsNotifications),
                  ),
                  const SizedBox(height: 16),
                  SettingsListTile(title: l10n.settingsPrivacy),
                  const SizedBox(height: 16),
                  SettingsListTile(
                    title: l10n.settingsVersion,
                    subtitle: '1.3.2.505.0911',
                  ),
                  const SizedBox(height: 16),
                  SettingsListTile(title: l10n.settingsAbout),
                  const SizedBox(height: 16),
                  SettingsListTile(title: l10n.settingsClearCache),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.settingsAccent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        l10n.settingsSwitchAccount,
                        style: textTheme.labelLarge?.copyWith(
                          color: colors.onPrimary,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: double.infinity,
                    height: 40,
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: colors.settingsAccent),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: Text(
                        l10n.settingsLogout,
                        style: textTheme.labelLarge?.copyWith(
                          color: colors.settingsAccent,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
      },
    );
  }
}
