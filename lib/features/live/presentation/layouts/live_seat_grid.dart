import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_layout_registry.dart';
import 'package:eye_rex_us/features/live/presentation/theme/live_room_theme.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_camera_preview.dart';
import 'package:flutter/material.dart';

typedef LiveGuestMenuTap = void Function(int seatIndex, LiveParticipant participant);

class LiveSeatGrid extends StatelessWidget {
  const LiveSeatGrid({
    super.key,
    required this.seats,
    this.activeSpeakerId,
    this.onEmptySeatTap,
    this.onGuestMenuTap,
    this.onOccupiedSeatTap,
    this.compact = false,
    this.emphasizeHostSeat = false,
    this.emptySeatTapOnIconOnly = false,
  });

  final List<LiveSeat> seats;
  final String? activeSpeakerId;
  final ValueChanged<int>? onEmptySeatTap;
  final LiveGuestMenuTap? onGuestMenuTap;
  final LiveGuestMenuTap? onOccupiedSeatTap;
  final bool compact;
  final bool emphasizeHostSeat;

  /// When true, only the + icon on empty seats is tappable (card watch vs seat request).
  final bool emptySeatTapOnIconOnly;

  @override
  Widget build(BuildContext context) {
    final seatCount = seats.length;
    final grid = LiveLayoutRegistry.gridFor(seatCount);
    final aspect = grid.columns / grid.rows;

    return LayoutBuilder(
      builder: (context, constraints) {
        return Center(
          child: AspectRatio(
            aspectRatio: aspect.clamp(0.5, 2.0),
            child: GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.all(compact ? 4 : 8),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: grid.columns,
                mainAxisSpacing: compact ? 4 : 6,
                crossAxisSpacing: compact ? 4 : 6,
              ),
              itemCount: seats.length,
              itemBuilder: (context, index) {
                final seat = seats[index];
                final participant = seat.participant;
                final showGuestMenu = participant != null &&
                    onGuestMenuTap != null &&
                    seat.status == LiveSeatStatus.occupied &&
                    !LiveRoomInteractionCubit.isHostParticipant(participant);
                final canTapOccupied = participant != null &&
                    onGuestMenuTap == null &&
                    onOccupiedSeatTap != null &&
                    seat.status == LiveSeatStatus.occupied;

                return _SeatTile(
                  seat: seat,
                  isActiveSpeaker: participant?.id == activeSpeakerId,
                  isHostSeat: emphasizeHostSeat &&
                      index == 0 &&
                      participant?.role == LiveParticipantRole.host,
                  showLocalCamera: _isLocalCameraParticipant(participant),
                  emptySeatTapOnIconOnly: emptySeatTapOnIconOnly,
                  onTap: seat.status == LiveSeatStatus.empty && onEmptySeatTap != null
                      ? emptySeatTapOnIconOnly
                          ? null
                          : () => onEmptySeatTap!(index)
                      : canTapOccupied
                          ? () => onOccupiedSeatTap!(index, participant)
                          : null,
                  onEmptySeatIconTap: seat.status == LiveSeatStatus.empty &&
                          onEmptySeatTap != null &&
                          emptySeatTapOnIconOnly
                      ? () => onEmptySeatTap!(index)
                      : null,
                  onGuestMenuTap: showGuestMenu
                      ? () => onGuestMenuTap!(index, participant)
                      : null,
                );
              },
            ),
          ),
        );
      },
    );
  }

  static bool _isLocalCameraParticipant(LiveParticipant? participant) {
    if (participant == null) return false;
    return participant.id == 'host_me' || participant.id == 'me';
  }
}

class _SeatTile extends StatelessWidget {
  const _SeatTile({
    required this.seat,
    required this.isActiveSpeaker,
    this.isHostSeat = false,
    this.showLocalCamera = false,
    this.emptySeatTapOnIconOnly = false,
    this.onTap,
    this.onEmptySeatIconTap,
    this.onGuestMenuTap,
  });

  final LiveSeat seat;
  final bool isActiveSpeaker;
  final bool isHostSeat;
  final bool showLocalCamera;
  final bool emptySeatTapOnIconOnly;
  final VoidCallback? onTap;
  final VoidCallback? onEmptySeatIconTap;
  final VoidCallback? onGuestMenuTap;

  @override
  Widget build(BuildContext context) {
    final participant = seat.participant;
    final borderColor = isHostSeat
        ? LiveRoomTheme.gold
        : isActiveSpeaker
            ? const Color(0xFFFFD54F)
            : seat.status == LiveSeatStatus.requested
                ? const Color(0xFF42A5F5)
                : Colors.white24;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: borderColor, width: isActiveSpeaker ? 2.5 : 1),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.black.withValues(alpha: 0.55),
                const Color(0xFFAF1D18).withValues(alpha: 0.35),
              ],
            ),
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (participant != null && showLocalCamera)
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: const LiveCameraPreview(),
                )
              else if (participant != null && participant.isCameraOff)
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: ColoredBox(
                    color: const Color(0xFF2A2A2A),
                    child: Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircleAvatar(
                            radius: 22,
                            backgroundImage: NetworkImage(participant.avatarUrl),
                          ),
                          const SizedBox(height: 6),
                          const Icon(Icons.videocam_off, color: Colors.white54, size: 20),
                        ],
                      ),
                    ),
                  ),
                )
              else if (participant != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: Image.network(
                    participant.avatarUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const ColoredBox(
                      color: Color(0xFF2A2A2A),
                      child: Icon(Icons.person, color: Colors.white54),
                    ),
                    loadingBuilder: (_, child, progress) {
                      if (progress == null) return child;
                      return const ColoredBox(color: Color(0xFF2A2A2A));
                    },
                  ),
                )
              else
                Center(
                  child: onEmptySeatIconTap != null
                      ? Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: onEmptySeatIconTap,
                            customBorder: const CircleBorder(),
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Icon(
                                seat.status == LiveSeatStatus.locked
                                    ? Icons.lock_outline
                                    : Icons.add,
                                color: Colors.white,
                                size: 28,
                              ),
                            ),
                          ),
                        )
                      : Icon(
                          seat.status == LiveSeatStatus.locked
                              ? Icons.lock_outline
                              : seat.status == LiveSeatStatus.requested
                                  ? Icons.hourglass_top
                                  : Icons.add,
                          color: Colors.white54,
                          size: 28,
                        ),
                ),
              if (participant != null)
                Positioned(
                  left: 4,
                  right: 4,
                  bottom: 4,
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          participant.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            shadows: [Shadow(color: Colors.black, blurRadius: 4)],
                          ),
                        ),
                      ),
                      if (participant.isMuted)
                        const Icon(Icons.mic_off, size: 12, color: Colors.white70),
                      if (participant.isCameraOff)
                        const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: Icon(Icons.videocam_off, size: 12, color: Colors.white70),
                        ),
                      if (isActiveSpeaker)
                        const Padding(
                          padding: EdgeInsets.only(left: 2),
                          child: Icon(Icons.push_pin, size: 11, color: Color(0xFFFFD54F)),
                        ),
                      _QualityDot(quality: participant.connectionQuality),
                    ],
                  ),
                ),
              if (onGuestMenuTap != null)
                Positioned(
                  top: 2,
                  right: 2,
                  child: Material(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(10),
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: onGuestMenuTap,
                      child: const Padding(
                        padding: EdgeInsets.all(3),
                        child: Icon(Icons.more_vert, color: Colors.white, size: 16),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QualityDot extends StatelessWidget {
  const _QualityDot({required this.quality});

  final LiveConnectionQuality quality;

  @override
  Widget build(BuildContext context) {
    final color = switch (quality) {
      LiveConnectionQuality.excellent => Colors.greenAccent,
      LiveConnectionQuality.good => Colors.lightGreen,
      LiveConnectionQuality.fair => Colors.orangeAccent,
      LiveConnectionQuality.poor => Colors.redAccent,
    };
    return Container(
      width: 6,
      height: 6,
      margin: const EdgeInsets.only(left: 2),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
