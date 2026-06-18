import 'package:eye_rex_us/features/live/domain/entities/live_platform_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveReportSheet extends StatelessWidget {
  const LiveReportSheet({
    super.key,
    required this.reportedUserId,
    required this.reportedUserName,
  });

  final String reportedUserId;
  final String reportedUserName;

  static Future<void> show(
    BuildContext context, {
    required String reportedUserId,
    required String reportedUserName,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      backgroundColor: const Color(0xFF1A1A24),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => LiveReportSheet(
        reportedUserId: reportedUserId,
        reportedUserName: reportedUserName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveRoomInteractionCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Report $reportedUserName',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 16),
            for (final reason in LiveReportReason.values)
              ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  reason.name,
                  style: const TextStyle(color: Colors.white70),
                ),
                onTap: () {
                  cubit.reportUser(reportedUserId, reason: reason);
                  Navigator.pop(context);
                },
              ),
            const Divider(color: Colors.white24),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.block, color: LiveRoomTheme.accent),
              title: const Text('Block user', style: TextStyle(color: Colors.white)),
              onTap: () {
                cubit.blockUser(reportedUserId);
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
