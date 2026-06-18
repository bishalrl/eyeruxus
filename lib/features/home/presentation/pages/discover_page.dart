import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/discover_cubit.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/discover_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/discover/discover_post_card.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/discover/discover_topic_carousel.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/discover/discover_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Discover tab — topic carousel + social feed (mockup layout).
class DiscoverPage extends StatelessWidget {
  const DiscoverPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    final topics = <DiscoverTopic>[
      DiscoverTopic(
        imageAsset: AppAssets.storyS1,
        tag: l10n.discoverTopicAnniversary,
      ),
      DiscoverTopic(
        imageAsset: AppAssets.storyS2,
        tag: l10n.discoverTopicBirthday,
      ),
      DiscoverTopic(
        imageAsset: AppAssets.storyS3,
        tag: l10n.discoverTopicHeartbreak,
      ),
      DiscoverTopic(
        imageAsset: AppAssets.storyS4,
        tag: l10n.discoverTopicTravel,
      ),
    ];

    final posts = <DiscoverPostData>[
      DiscoverPostData(
        authorName: l10n.discoverPostAuthor,
        followersLabel: l10n.discoverFollowersCount('20k'),
        imageAsset: AppAssets.background,
        likes: l10n.discoverPostLikes,
        comments: l10n.discoverPostComments,
        caption: l10n.discoverPostCaption,
      ),
      DiscoverPostData(
        authorName: l10n.homeProfileName,
        followersLabel: l10n.discoverFollowersCount('12k'),
        imageAsset: AppAssets.liveRoom,
        likes: '856',
        comments: '142',
        caption: l10n.discoverPostCaptionAlt,
      ),
    ];

    return Container(
      decoration: const BoxDecoration(gradient: HomeColors.pageGradient),
      child: SafeArea(
        bottom: false,
        child: BlocBuilder<DiscoverCubit, DiscoverFeedTab>(
          builder: (context, selectedTab) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                DiscoverTopBar(
                  selectedTab: selectedTab,
                  onTabChanged: context.read<DiscoverCubit>().selectTab,
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(bottom: 128),
                    children: [
                      DiscoverTopicCarousel(
                        title: l10n.discoverChooseTopic,
                        topics: topics,
                      ),
                      const SizedBox(height: 8),
                      for (var i = 0; i < posts.length; i++)
                        DiscoverPostCard(
                          data: posts[i],
                          onTap: () => DiscoverRoutes.openReelsFeed(
                            context,
                            initialIndex: i,
                            feedTab: _mapDiscoverTab(selectedTab),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  ReelsFeedTab _mapDiscoverTab(DiscoverFeedTab tab) {
    return switch (tab) {
      DiscoverFeedTab.following => ReelsFeedTab.following,
      _ => ReelsFeedTab.forYou,
    };
  }
}
