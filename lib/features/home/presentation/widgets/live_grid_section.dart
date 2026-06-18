import 'package:eye_rex_us/core/utils/responsive_layout.dart';
import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class LiveGridSection extends StatelessWidget {
  const LiveGridSection({
    super.key,
    required this.rooms,
    this.onRoomTap,
  });

  final List<RoomEntity> rooms;
  final void Function(RoomEntity room)? onRoomTap;

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

    final crossAxisCount = ResponsiveLayout.getGridCrossAxisCount(context);

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.78,
      ),
      itemCount: rooms.length,
      itemBuilder: (context, index) {
        final room = rooms[index];
        final tagColor = _tagColor(room.tag);

        return Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onRoomTap == null ? null : () => onRoomTap!(room),
            borderRadius: BorderRadius.circular(16),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  if (room.coverUrl != null)
                    AppAssetImage(
                      asset: room.coverUrl!,
                      fit: BoxFit.cover,
                    )
                  else
                    Container(color: HomeColors.cardBackground),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.black.withValues(alpha: 0.1),
                          Colors.black.withValues(alpha: 0.75),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    left: 10,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: tagColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        room.tag,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                  Positioned(
                    left: 10,
                    right: 10,
                    bottom: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(room.countryFlag, style: const TextStyle(fontSize: 12)),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                room.title,
                                style: const TextStyle(
                                  color: HomeColors.textWhite,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                const Icon(
                                  Icons.trending_up,
                                  color: HomeColors.textGrey,
                                  size: 14,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  room.views,
                                  style: const TextStyle(
                                    color: HomeColors.textGrey,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                            if (room.isPk)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 6,
                                  vertical: 2,
                                ),
                                decoration: BoxDecoration(
                                  color: HomeColors.pkBadge,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: const Text(
                                  'PK',
                                  style: TextStyle(
                                    color: HomeColors.textDark,
                                    fontSize: 9,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
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
