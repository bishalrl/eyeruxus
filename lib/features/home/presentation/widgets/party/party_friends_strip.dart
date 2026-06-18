import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class PartyFriendsStrip extends StatelessWidget {
  const PartyFriendsStrip({
    super.key,
    required this.friends,
    required this.onFriendTap,
  });

  final List<PartyFriendActivity> friends;
  final void Function(PartyFriendActivity friend) onFriendTap;

  @override
  Widget build(BuildContext context) {
    if (friends.isEmpty) return const SizedBox.shrink();

    final l10n = context.l10n;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: Text(
            l10n.homePartyFriendsInParty,
            style: const TextStyle(
              color: HomeColors.textWhite,
              fontSize: 15,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(
          height: 88,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: friends.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final friend = friends[index];
              return GestureDetector(
                onTap: () => onFriendTap(friend),
                child: SizedBox(
                  width: 72,
                  child: Column(
                    children: [
                      Stack(
                        children: [
                          CircleAvatar(
                            radius: 28,
                            backgroundColor: HomeColors.transparentTabBackground,
                            child: ClipOval(
                              child: AppAssetImage(
                                asset: friend.avatar,
                                width: 52,
                                height: 52,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Positioned(
                            right: 2,
                            bottom: 2,
                            child: Container(
                              width: 14,
                              height: 14,
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: HomeColors.backgroundBlack,
                                  width: 2,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        friend.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          color: HomeColors.textWhite,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
