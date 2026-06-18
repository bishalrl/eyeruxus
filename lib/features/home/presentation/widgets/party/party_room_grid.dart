import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/core/utils/responsive_layout.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/utils/feed_seat_preview_builder.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_layout_registry.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_seat_grid.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class PartyRoomGrid extends StatelessWidget {
  const PartyRoomGrid({
    super.key,
    required this.rooms,
    required this.vibeLabelFor,
    required this.onJoinSeat,
    required this.onWatch,
  });

  final List<PartyRoom> rooms;
  final String Function(String vibeKey) vibeLabelFor;
  final void Function(PartyRoom room, int seatIndex) onJoinSeat;
  final void Function(PartyRoom room) onWatch;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    if (rooms.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(32),
        child: Center(
          child: Text(
            l10n.homePartyEmpty,
            textAlign: TextAlign.center,
            style: const TextStyle(color: HomeColors.textGrey, fontSize: 14),
          ),
        ),
      );
    }

    final crossAxisCount = ResponsiveLayout.getGridCrossAxisCount(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.68,
      ),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        return PartyRoomCard(
          room: room,
          vibeLabel: vibeLabelFor(room.vibeKey),
          membersLabel: l10n.homePartyMembersCount(
            room.memberCount,
            room.maxMembers,
          ),
          onJoinSeat: (seatIndex) => onJoinSeat(room, seatIndex),
          onWatch: () => onWatch(room),
        );
      },
    );
  }
}

class PartyRoomCard extends StatelessWidget {
  const PartyRoomCard({
    super.key,
    required this.room,
    required this.vibeLabel,
    required this.membersLabel,
    required this.onJoinSeat,
    required this.onWatch,
  });

  final PartyRoom room;
  final String vibeLabel;
  final String membersLabel;
  final void Function(int seatIndex) onJoinSeat;
  final VoidCallback onWatch;

  @override
  Widget build(BuildContext context) {
    final layoutId = room.layoutRoomId ?? 'room_8';
    final seatCount = LiveLayoutRegistry.seatCountForRoom(layoutId);
    final stageCount = room.memberCount.clamp(1, seatCount);
    final seats = FeedSeatPreviewBuilder.build(
      layoutRoomId: layoutId,
      hostName: room.hostName,
      hostAvatarUrl: 'https://i.pravatar.cc/150?u=${room.hostName}',
      stageMemberCount: stageCount,
      seed: room.id,
    );
    final hasVacantSeat = seats.any((s) => s.status == LiveSeatStatus.empty);

    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: Stack(
        fit: StackFit.expand,
        children: [
          AppAssetImage(asset: room.coverUrl, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.2),
                  Colors.black.withValues(alpha: 0.9),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: HomeColors.partyAccent,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        vibeLabel,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const Spacer(),
                    if (room.isPrivate)
                      const Icon(Icons.lock, color: Colors.white70, size: 14),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: LiveSeatGrid(
                    seats: seats,
                    compact: true,
                    emphasizeHostSeat: true,
                    onEmptySeatTap: onJoinSeat,
                    onOccupiedSeatTap: (_, __) => onWatch(),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onWatch,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 10,
                              backgroundColor: HomeColors.transparentTabBackground,
                              child: ClipOval(
                                child: AppAssetImage(
                                  asset: room.hostAvatar,
                                  width: 20,
                                  height: 20,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(width: 6),
                            Expanded(
                              child: Text(
                                room.hostName,
                                style: const TextStyle(
                                  color: HomeColors.textGrey,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          room.title,
                          style: const TextStyle(
                            color: HomeColors.textWhite,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.people_outline,
                                color: HomeColors.textGrey, size: 13),
                            const SizedBox(width: 4),
                            Text(
                              membersLabel,
                              style: const TextStyle(
                                color: HomeColors.textGrey,
                                fontSize: 10,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              hasVacantSeat ? 'Tap + to join' : 'Watch',
                              style: TextStyle(
                                color: hasVacantSeat
                                    ? HomeColors.partyAccent
                                    : HomeColors.textGrey,
                                fontSize: 10,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
