import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class ReelItemView extends StatelessWidget {
  const ReelItemView({
    super.key,
    required this.reel,
    required this.isLiked,
    required this.isFollowing,
    required this.likeLabel,
    required this.commentLabel,
    required this.shareLabel,
    required this.followLabel,
    required this.followingLabel,
    required this.onLike,
    required this.onComment,
    required this.onShare,
    required this.onFollow,
  });

  final ReelPost reel;
  final bool isLiked;
  final bool isFollowing;
  final String likeLabel;
  final String commentLabel;
  final String shareLabel;
  final String followLabel;
  final String followingLabel;
  final VoidCallback onLike;
  final VoidCallback onComment;
  final VoidCallback onShare;
  final VoidCallback onFollow;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        AppAssetImage(asset: reel.mediaAsset, fit: BoxFit.cover),
        const DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0x66000000),
                Colors.transparent,
                Color(0x99000000),
              ],
              stops: [0, 0.35, 1],
            ),
          ),
        ),
        Positioned(
          right: 12,
          bottom: 100,
          child: Column(
            children: [
              _ActionButton(
                icon: isLiked ? Icons.favorite : Icons.favorite_border,
                label: likeLabel,
                iconColor: isLiked ? Colors.redAccent : Colors.white,
                onTap: onLike,
              ),
              const SizedBox(height: 18),
              _ActionButton(
                icon: Icons.chat_bubble_outline,
                label: commentLabel,
                onTap: onComment,
              ),
              const SizedBox(height: 18),
              _ActionButton(
                icon: Icons.share_outlined,
                label: shareLabel,
                onTap: onShare,
              ),
              const SizedBox(height: 18),
              _FollowAvatar(
                avatarAsset: reel.avatarAsset,
                isFollowing: isFollowing,
                followLabel: followLabel,
                followingLabel: followingLabel,
                onTap: onFollow,
              ),
            ],
          ),
        ),
        Positioned(
          left: 16,
          right: 72,
          bottom: 32,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '@${reel.authorName.replaceAll(' ', '').toLowerCase()}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                reel.caption,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.label,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 56,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: iconColor, size: 32),
              const SizedBox(height: 4),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FollowAvatar extends StatelessWidget {
  const _FollowAvatar({
    required this.avatarAsset,
    required this.isFollowing,
    required this.followLabel,
    required this.followingLabel,
    required this.onTap,
  });

  final String avatarAsset;
  final bool isFollowing;
  final String followLabel;
  final String followingLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(avatarAsset),
              ),
              if (!isFollowing)
                Positioned(
                  bottom: -6,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: const BoxDecoration(
                        color: HomeColors.accentOrange,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 14,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            isFollowing ? followingLabel : followLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
