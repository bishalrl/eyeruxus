import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/home_feed_room_resolver.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/home_live_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/feed_room_live_card.dart';
import 'package:flutter/material.dart';

/// Live rooms on Home — scrolls with the main feed (no nested pager).
class HomeLiveFeedSection extends StatelessWidget {
  const HomeLiveFeedSection({
    super.key,
    required this.rooms,
  });

  static const _cardHeight = 340.0;

  final List<RoomEntity> rooms;

  @override
  Widget build(BuildContext context) {
    if (rooms.isEmpty) {
      return const Padding(
        padding: EdgeInsets.all(32),
        child: Center(
          child: Text(
            'No live rooms in this feed yet.',
            style: TextStyle(color: HomeColors.textWhite, fontSize: 14),
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Icon(Icons.sensors, color: HomeColors.accentOrange, size: 18),
              SizedBox(width: 6),
              Text(
                'Live now',
                style: TextStyle(
                  color: HomeColors.textWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Text(
                'Swipe for more rooms',
                style: TextStyle(color: HomeColors.textGrey, fontSize: 11),
              ),
            ],
          ),
        ),
        ListView.separated(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          itemCount: rooms.length,
          separatorBuilder: (_, __) => const SizedBox(height: 12),
          itemBuilder: (context, index) {
            final room = rooms[index];
            final layoutRoomId = HomeFeedRoomResolver.layoutRoomIdFor(room);

            return SizedBox(
              height: _cardHeight,
              child: FeedRoomLiveCard(
                title: room.title,
                layoutRoomId: layoutRoomId,
                stageMemberCount: room.stageMemberCount,
                hostName: room.title,
                hostAvatarUrl: 'https://i.pravatar.cc/150?u=${room.id}',
                coverAsset: room.coverUrl,
                badgeLabel: room.tag,
                badgeColor: _tagColor(room.tag),
                viewsLabel: room.views,
                countryFlag: room.countryFlag,
                previewSeed: room.id,
                onEmptySeatTap: (seatIndex) => HomeLiveRoutes.openBrowseFeed(
                  context,
                  rooms: rooms,
                  initialRoom: room,
                  preferredSeatIndex: seatIndex,
                ),
                onWatch: () => HomeLiveRoutes.openBrowseFeed(
                  context,
                  rooms: rooms,
                  initialRoom: room,
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Color _tagColor(String tag) {
    return switch (tag) {
      'Chatting' => HomeColors.tagChatting,
      'TOP10' => HomeColors.tagTop10,
      'New' => HomeColors.tagNew,
      'Nearby' => HomeColors.tagNearby,
      _ => HomeColors.tagFriends,
    };
  }
}
