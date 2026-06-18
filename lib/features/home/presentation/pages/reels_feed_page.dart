import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_bloc.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_event.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/reels_state.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/reels/reel_item_view.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/reels/reels_comments_sheet.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/reels/reels_feed_top_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Full-screen vertical reels feed (TikTok style).
class ReelsFeedPage extends StatelessWidget {
  const ReelsFeedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: MultiBlocListener(
          listeners: [
            BlocListener<ReelsBloc, ReelsState>(
              listenWhen: (prev, curr) =>
                  curr.message != null && prev.message != curr.message,
              listener: (context, state) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(context.l10n.reelsShared),
                    behavior: SnackBarBehavior.floating,
                    duration: const Duration(seconds: 1),
                  ),
                );
                context.read<ReelsBloc>().add(const ReelsMessageConsumed());
              },
            ),
            BlocListener<ReelsBloc, ReelsState>(
              listenWhen: (prev, curr) =>
                  prev.activeCommentsReelId == null &&
                  curr.activeCommentsReelId != null,
              listener: (context, state) async {
                final reelId = state.activeCommentsReelId;
                if (reelId == null) return;

                await showModalBottomSheet<void>(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (sheetContext) => BlocProvider.value(
                    value: context.read<ReelsBloc>(),
                    child: ReelsCommentsSheet(reelId: reelId),
                  ),
                );
                if (context.mounted) {
                  context.read<ReelsBloc>().add(const ReelsCommentsClosed());
                }
              },
            ),
          ],
          child: BlocBuilder<ReelsBloc, ReelsState>(
            builder: (context, state) {
              final l10n = context.l10n;
              return Stack(
                fit: StackFit.expand,
                children: [
                  _ReelsVerticalPager(
                    key: ValueKey(state.pagerKey),
                    initialPage: state.initialPageIndex,
                    state: state,
                    formatCount: _formatCount,
                    followingLabel: l10n.reelsFollowing,
                    followLabel: l10n.reelsFollow,
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: ReelsFeedTopBar(
                      selectedTab: state.feedTab,
                      followingLabel: l10n.reelsTabFollowing,
                      forYouLabel: l10n.reelsTabForYou,
                      onTabChanged: (tab) => context
                          .read<ReelsBloc>()
                          .add(ReelsFeedTabChanged(tab)),
                      onBack: () => AppRouter.maybePop(context),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  static String _formatCount(int count) {
    if (count >= 1000000) {
      return '${(count / 1000000).toStringAsFixed(1)}M';
    }
    if (count >= 1000) {
      return '${(count / 1000).toStringAsFixed(1)}K';
    }
    return '$count';
  }
}

class _ReelsVerticalPager extends StatefulWidget {
  const _ReelsVerticalPager({
    super.key,
    required this.initialPage,
    required this.state,
    required this.formatCount,
    required this.followLabel,
    required this.followingLabel,
  });

  final int initialPage;
  final ReelsState state;
  final String Function(int) formatCount;
  final String followLabel;
  final String followingLabel;

  @override
  State<_ReelsVerticalPager> createState() => _ReelsVerticalPagerState();
}

class _ReelsVerticalPagerState extends State<_ReelsVerticalPager> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.initialPage);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final state = widget.state;
    final bloc = context.read<ReelsBloc>();

    return PageView.builder(
      controller: _pageController,
      scrollDirection: Axis.vertical,
      onPageChanged: (index) => bloc.add(ReelsNearEndReached(index)),
      itemCount: state.reels.length,
      itemBuilder: (context, index) {
        final reel = state.reels[index];
        return ReelItemView(
          reel: reel,
          isLiked: state.isLiked(reel.id),
          isFollowing: state.isFollowing(reel),
          likeLabel: l10n.reelsFormatCount(widget.formatCount(reel.likeCount)),
          commentLabel:
              l10n.reelsFormatCount(widget.formatCount(reel.commentCount)),
          shareLabel:
              l10n.reelsFormatCount(widget.formatCount(reel.shareCount)),
          followLabel: widget.followLabel,
          followingLabel: widget.followingLabel,
          onLike: () => bloc.add(ReelsLikeToggled(reel.id)),
          onComment: () => bloc.add(ReelsCommentsOpened(reel.id)),
          onShare: () => bloc.add(ReelsShareRequested(reel.id)),
          onFollow: () => bloc.add(ReelsFollowToggled(reel.id)),
        );
      },
    );
  }
}
