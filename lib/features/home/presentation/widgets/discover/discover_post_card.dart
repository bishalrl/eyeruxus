import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class DiscoverPostData {
  const DiscoverPostData({
    required this.authorName,
    required this.followersLabel,
    required this.imageAsset,
    required this.likes,
    required this.comments,
    required this.caption,
  });

  final String authorName;
  final String followersLabel;
  final String imageAsset;
  final String likes;
  final String comments;
  final String caption;
}

class DiscoverPostCard extends StatelessWidget {
  const DiscoverPostCard({
    super.key,
    required this.data,
    this.onTap,
  });

  final DiscoverPostData data;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _PostHeader(
            authorName: data.authorName,
            followersLabel: data.followersLabel,
          ),
          GestureDetector(
            onTap: onTap,
            child: AspectRatio(
              aspectRatio: 1,
              child: AppAssetImage(
                asset: data.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _PostInteractionBar(
            likes: data.likes,
            comments: data.comments,
            caption: data.caption,
          ),
        ],
      ),
    );
  }
}

class _PostHeader extends StatelessWidget {
  const _PostHeader({
    required this.authorName,
    required this.followersLabel,
  });

  final String authorName;
  final String followersLabel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 8, 10),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(AppAssets.avatar),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  authorName,
                  style: const TextStyle(
                    color: HomeColors.textWhite,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  followersLabel,
                  style: TextStyle(
                    color: HomeColors.textWhite.withValues(alpha: 0.85),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert, color: HomeColors.textWhite),
          ),
        ],
      ),
    );
  }
}

class _PostInteractionBar extends StatelessWidget {
  const _PostInteractionBar({
    required this.likes,
    required this.comments,
    required this.caption,
  });

  final String likes;
  final String comments;
  final String caption;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: HomeColors.accentAmber,
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.favorite, color: HomeColors.textWhite, size: 18),
              const SizedBox(width: 6),
              Text(
                likes,
                style: const TextStyle(
                  color: HomeColors.textWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 20),
              const Icon(
                Icons.chat_bubble_outline,
                color: HomeColors.textWhite,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                comments,
                style: const TextStyle(
                  color: HomeColors.textWhite,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            caption,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: HomeColors.textWhite,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
