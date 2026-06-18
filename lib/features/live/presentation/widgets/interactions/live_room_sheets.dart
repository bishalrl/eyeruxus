import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveRoomMoreSheet extends StatelessWidget {
  const LiveRoomMoreSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<LiveRoomInteractionCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.white24,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 16),
            _MoreTile(
              icon: Icons.share_outlined,
              label: l10n.liveRoomShare,
              onTap: () {
                Navigator.pop(context);
                cubit.share();
              },
            ),
            _MoreTile(
              icon: Icons.favorite_outline,
              label: 'Double-tap to send love',
              onTap: () => Navigator.pop(context),
            ),
            _MoreTile(
              icon: Icons.report_outlined,
              label: 'Report user',
              onTap: () {
                Navigator.pop(context);
                cubit.reportUser('user');
              },
            ),
            _MoreTile(
              icon: Icons.block_outlined,
              label: 'Block user',
              onTap: () {
                Navigator.pop(context);
                cubit.blockUser('user');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, color: Colors.white),
      title: Text(label, style: const TextStyle(color: Colors.white)),
      onTap: onTap,
    );
  }
}

class LiveRoomSeatSheet extends StatelessWidget {
  const LiveRoomSeatSheet({super.key, required this.seatCount});

  final int seatCount;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<LiveRoomInteractionCubit>();

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              l10n.liveRoomPickSeat,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              alignment: WrapAlignment.center,
              children: [
                for (var i = 1; i <= seatCount; i++)
                  ActionChip(
                    label: Text('${l10n.liveRoomSeat} $i'),
                    backgroundColor: Colors.white24,
                    labelStyle: const TextStyle(color: Colors.white),
                    onPressed: () {
                      Navigator.pop(context);
                      cubit.requestSeat(i - 1);
                    },
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
