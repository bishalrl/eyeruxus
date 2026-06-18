import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/utils/feed_seat_preview_builder.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_seat_grid.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

/// Live preview card: tap a vacant seat to request joining (host must approve).
class FeedRoomLiveCard extends StatelessWidget {
  const FeedRoomLiveCard({
    super.key,
    required this.title,
    required this.layoutRoomId,
    required this.stageMemberCount,
    required this.hostName,
    required this.hostAvatarUrl,
    required this.onEmptySeatTap,
    required this.onWatch,
    this.coverAsset,
    this.badgeLabel,
    this.badgeColor = HomeColors.accentOrange,
    this.viewsLabel,
    this.countryFlag,
    this.previewSeed = '',
  });

  final String title;
  final String layoutRoomId;
  final int stageMemberCount;
  final String hostName;
  final String hostAvatarUrl;
  final void Function(int seatIndex) onEmptySeatTap;
  final VoidCallback onWatch;
  final String? coverAsset;
  final String? badgeLabel;
  final Color badgeColor;
  final String? viewsLabel;
  final String? countryFlag;
  final String previewSeed;

  @override
  Widget build(BuildContext context) {
    final seats = FeedSeatPreviewBuilder.build(
      layoutRoomId: layoutRoomId,
      hostName: hostName,
      hostAvatarUrl: hostAvatarUrl,
      stageMemberCount: stageMemberCount,
      seed: previewSeed,
    );
    final hasVacantSeat = seats.any((s) => s.status == LiveSeatStatus.empty);

    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (coverAsset != null)
            AppAssetImage(asset: coverAsset!, fit: BoxFit.cover)
          else
            Container(color: HomeColors.cardBackground),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.black.withValues(alpha: 0.25),
                  Colors.black.withValues(alpha: 0.88),
                ],
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 0),
                child: Row(
                  children: [
                    if (badgeLabel != null)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: badgeColor,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          badgeLabel!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    const Spacer(),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFFE53935),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Text(
                      'LIVE',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  child: LiveSeatGrid(
                    seats: seats,
                    compact: true,
                    emphasizeHostSeat: true,
                    onEmptySeatTap: onEmptySeatTap,
                    onOccupiedSeatTap: (_, __) => onWatch(),
                  ),
                ),
              ),
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: onWatch,
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(14, 0, 14, 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            if (countryFlag != null) ...[
                              Text(countryFlag!, style: const TextStyle(fontSize: 12)),
                              const SizedBox(width: 4),
                            ],
                            Expanded(
                              child: Text(
                                title,
                                style: const TextStyle(
                                  color: HomeColors.textWhite,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            if (viewsLabel != null) ...[
                              const Icon(Icons.visibility_outlined,
                                  color: HomeColors.textGrey, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                viewsLabel!,
                                style: const TextStyle(
                                  color: HomeColors.textGrey,
                                  fontSize: 11,
                                ),
                              ),
                            ],
                            const Spacer(),
                            Text(
                              hasVacantSeat ? 'Tap + to request seat' : 'Tap to browse',
                              style: TextStyle(
                                color: hasVacantSeat
                                    ? HomeColors.accentAmber
                                    : HomeColors.textGrey,
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
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
