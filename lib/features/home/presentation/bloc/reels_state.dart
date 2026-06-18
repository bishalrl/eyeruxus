import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_comment.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';

class ReelsState extends Equatable {
  const ReelsState({
    required this.feedTab,
    required this.reels,
    required this.initialPageIndex,
    required this.pagerKey,
    this.likedReelIds = const {},
    this.followingOverrides = const {},
    this.commentsByReelId = const {},
    this.activeCommentsReelId,
    this.message,
  });

  final ReelsFeedTab feedTab;
  final List<ReelPost> reels;
  final int initialPageIndex;
  final int pagerKey;
  final Set<String> likedReelIds;
  final Map<String, bool> followingOverrides;
  final Map<String, List<ReelComment>> commentsByReelId;
  final String? activeCommentsReelId;
  final String? message;

  bool isLiked(String reelId) => likedReelIds.contains(reelId);

  bool isFollowing(ReelPost reel) =>
      followingOverrides[reel.id] ?? reel.isFollowing;

  List<ReelComment> commentsFor(String reelId) =>
      commentsByReelId[reelId] ?? const [];

  ReelsState copyWith({
    ReelsFeedTab? feedTab,
    List<ReelPost>? reels,
    int? initialPageIndex,
    int? pagerKey,
    Set<String>? likedReelIds,
    Map<String, bool>? followingOverrides,
    Map<String, List<ReelComment>>? commentsByReelId,
    String? Function()? activeCommentsReelId,
    String? Function()? message,
  }) {
    return ReelsState(
      feedTab: feedTab ?? this.feedTab,
      reels: reels ?? this.reels,
      initialPageIndex: initialPageIndex ?? this.initialPageIndex,
      pagerKey: pagerKey ?? this.pagerKey,
      likedReelIds: likedReelIds ?? this.likedReelIds,
      followingOverrides: followingOverrides ?? this.followingOverrides,
      commentsByReelId: commentsByReelId ?? this.commentsByReelId,
      activeCommentsReelId: activeCommentsReelId != null
          ? activeCommentsReelId()
          : this.activeCommentsReelId,
      message: message != null ? message() : this.message,
    );
  }

  @override
  List<Object?> get props => [
        feedTab,
        reels,
        initialPageIndex,
        pagerKey,
        likedReelIds,
        followingOverrides,
        commentsByReelId,
        activeCommentsReelId,
        message,
      ];
}
