import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/party_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class PartyFeaturedBanner extends StatelessWidget {
  const PartyFeaturedBanner({super.key, this.rooms = const []});

  final List<PartyRoom> rooms;

  static const _featuredParty = PartyRoom(
    id: 'featured_party',
    title: 'Featured Party Night',
    hostName: 'Anime Lover',
    hostAvatar: AppAssets.storyS1,
    coverUrl: AppAssets.party,
    vibeKey: 'partyVibeChatting',
    memberCount: 8,
    maxMembers: 12,
    isPrivate: false,
    layoutRoomId: 'room_8',
  );

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => PartyRoutes.joinRoom(
            context,
            _featuredParty,
            allRooms: rooms.isNotEmpty ? rooms : const [_featuredParty],
          ),
          borderRadius: BorderRadius.circular(16),
          child: Ink(
            height: 100,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: const LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xFFE91E63), Color(0xFFFF7043)],
              ),
              boxShadow: const [
                BoxShadow(
                  color: HomeColors.shadowColor,
                  blurRadius: 8,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Positioned(
                    right: -20,
                    bottom: -10,
                    child: Opacity(
                      opacity: 0.35,
                      child: AppAssetImage(
                        asset: AppAssets.party,
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          l10n.homePartyFeaturedTitle,
                          style: const TextStyle(
                            color: HomeColors.textWhite,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          l10n.homePartyFeaturedSubtitle,
                          style: const TextStyle(
                            color: HomeColors.textWhite,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
