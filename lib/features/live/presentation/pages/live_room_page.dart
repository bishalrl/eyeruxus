import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_seat_grid.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveRoomPage extends StatelessWidget {
  const LiveRoomPage({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
      builder: (context, state) {
        if (state.status == LiveRoomLoadStatus.loading) {
          return const _LiveRoomLoading();
        }
        if (state.status == LiveRoomLoadStatus.error) {
          return _LiveRoomError(
            message: state.errorMessage ?? 'Unable to join room',
            onRetry: () => context.read<LiveRoomInteractionCubit>().rejoin(),
          );
        }
        if (state.status == LiveRoomLoadStatus.ended) {
          return _LiveRoomEnded(onClose: () => Navigator.maybePop(context));
        }

        final session = state.session;
        return Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xFF1A1010), Color(0xFF0D0D0D), Color(0xFF000000)],
            ),
          ),
          child: SafeArea(
            bottom: false,
            child: Column(
              children: [
                _LiveRoomHeader(state: state),
                Expanded(
                  child: session == null
                      ? const Center(child: CircularProgressIndicator())
                      : _LiveSeatArea(
                          session: session,
                          isHost: state.isHost,
                        ),
                ),
                const SizedBox(height: 120),
              ],
            ),
          ),
        );
      },
    );
  }
}

class _LiveSeatArea extends StatelessWidget {
  const _LiveSeatArea({
    required this.session,
    required this.isHost,
  });

  final LiveRoomSession session;
  final bool isHost;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveRoomInteractionCubit>();

    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onDoubleTapDown: (details) {
        final box = context.findRenderObject() as RenderBox?;
        if (box == null) return;
        final local = box.globalToLocal(details.globalPosition);
        final size = box.size;
        cubit.sendLike(
          dx: (local.dx / size.width).clamp(0.1, 0.9),
          dy: (local.dy / size.height).clamp(0.1, 0.9),
        );
      },
      child: LiveSeatGrid(
        seats: session.seats,
        activeSpeakerId: session.activeSpeakerId,
        onEmptySeatTap: isHost
            ? null
            : (index) => cubit.requestSeat(index),
      ),
    );
  }
}

class _LiveRoomHeader extends StatelessWidget {
  const _LiveRoomHeader({required this.state});

  final LiveRoomInteractionState state;

  @override
  Widget build(BuildContext context) {
    final session = state.session;
    final host = session?.host;
    final cubit = context.read<LiveRoomInteractionCubit>();

    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
      child: Row(
        children: [
          if (host != null) ...[
            CircleAvatar(
              radius: 18,
              backgroundImage: NetworkImage(host.avatarUrl),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    host.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 14,
                    ),
                  ),
                  Text(
                    session?.title ?? 'Live Room',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white.withValues(alpha: 0.7), fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
          _LiveBadge(),
          const SizedBox(width: 8),
          _ViewerChip(count: state.viewerCount),
          const SizedBox(width: 6),
          _ConnectionChip(quality: state.connectionQuality),
          const SizedBox(width: 6),
          _HeaderIconButton(
            icon: state.isFollowingHost ? Icons.check : Icons.person_add_alt_1,
            label: state.isFollowingHost ? 'Following' : 'Follow',
            onTap: cubit.toggleFollowHost,
            filled: state.isFollowingHost,
          ),
          _HeaderIconButton(
            icon: Icons.share_outlined,
            onTap: cubit.share,
          ),
          if (state.canModerate)
            _HeaderIconButton(
              icon: Icons.admin_panel_settings_outlined,
              onTap: cubit.openHostControls,
            ),
        ],
      ),
    );
  }
}

class _LiveBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFAF1D18),
        borderRadius: BorderRadius.circular(6),
      ),
      child: const Text(
        'LIVE',
        style: TextStyle(
          color: Colors.white,
          fontSize: 10,
          fontWeight: FontWeight.w800,
          letterSpacing: 0.6,
        ),
      ),
    );
  }
}

class _ViewerChip extends StatelessWidget {
  const _ViewerChip({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.remove_red_eye_outlined, size: 12, color: Colors.white70),
          const SizedBox(width: 4),
          Text(
            _formatCount(count),
            style: const TextStyle(color: Colors.white, fontSize: 11),
          ),
        ],
      ),
    );
  }

  String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}

class _ConnectionChip extends StatelessWidget {
  const _ConnectionChip({required this.quality});

  final LiveConnectionQuality quality;

  @override
  Widget build(BuildContext context) {
    final label = switch (quality) {
      LiveConnectionQuality.excellent => 'HD',
      LiveConnectionQuality.good => 'Good',
      LiveConnectionQuality.fair => 'Fair',
      LiveConnectionQuality.poor => 'Poor',
    };
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(label, style: const TextStyle(color: Colors.white70, fontSize: 10)),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    this.label,
    this.onTap,
    this.filled = false,
  });

  final IconData icon;
  final String? label;
  final VoidCallback? onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 4),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
          decoration: BoxDecoration(
            color: filled ? const Color(0xFFAF1D18) : Colors.black45,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, size: 16, color: Colors.white),
              if (label != null) ...[
                const SizedBox(width: 4),
                Text(label!, style: const TextStyle(color: Colors.white, fontSize: 10)),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _LiveRoomLoading extends StatelessWidget {
  const _LiveRoomLoading();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: const Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: Color(0xFFAF1D18)),
            SizedBox(height: 16),
            Text('Connecting to live room…', style: TextStyle(color: Colors.white70)),
          ],
        ),
      ),
    );
  }
}

class _LiveRoomError extends StatelessWidget {
  const _LiveRoomError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(24),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.wifi_off, color: Colors.white54, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center, style: const TextStyle(color: Colors.white70)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onRetry,
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFFAF1D18)),
              child: const Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }
}

class _LiveRoomEnded extends StatelessWidget {
  const _LiveRoomEnded({required this.onClose});

  final VoidCallback onClose;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.live_tv, color: Colors.white54, size: 56),
            const SizedBox(height: 12),
            const Text('Live ended', style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(height: 16),
            FilledButton(
              onPressed: onClose,
              style: FilledButton.styleFrom(backgroundColor: const Color(0xFFAF1D18)),
              child: const Text('Close'),
            ),
          ],
        ),
      ),
    );
  }
}
