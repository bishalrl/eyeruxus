import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/dev_tools/presentation/bloc/dev_tools_bloc.dart';
import 'package:eye_rex_us/features/dev_tools/presentation/config/dev_launcher_config.dart';
import 'package:eye_rex_us/features/dev_tools/presentation/config/dev_launcher_labels.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppLauncherPage extends StatelessWidget {
  const AppLauncherPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;
    final entries = DevLauncherConfig.entries;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.devLauncherTitle,
          style: textTheme.titleLarge?.copyWith(color: colors.textPrimary),
        ),
      ),
      body: BlocBuilder<DevToolsBloc, DevToolsState>(
        builder: (context, state) {
          if (state is DevToolsLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is DevToolsFailure) {
            return Center(child: Text(state.message));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: entries.length,
            itemBuilder: (context, index) {
              final entry = entries[index];
              final label = DevLauncherLabels.resolve(l10n, entry.labelKey);

              return GestureDetector(
                onTap: () {
                  AppRouter.pushPage(context, entry.builder(context));
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: colors.navLauncherTile,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    label,
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.navLauncherText,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
