/// A single short-form video / reel item in the vertical feed.
class ReelPost {
  const ReelPost({
    required this.id,
    required this.authorName,
    required this.avatarAsset,
    required this.mediaAsset,
    required this.caption,
    required this.likeCount,
    required this.commentCount,
    required this.shareCount,
    this.isFollowing = false,
  });

  final String id;
  final String authorName;
  final String avatarAsset;
  final String mediaAsset;
  final String caption;
  final int likeCount;
  final int commentCount;
  final int shareCount;
  final bool isFollowing;

  ReelPost copyWith({
    bool? isFollowing,
    int? likeCount,
    int? commentCount,
  }) {
    return ReelPost(
      id: id,
      authorName: authorName,
      avatarAsset: avatarAsset,
      mediaAsset: mediaAsset,
      caption: caption,
      likeCount: likeCount ?? this.likeCount,
      commentCount: commentCount ?? this.commentCount,
      shareCount: shareCount,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }
}

enum ReelsFeedTab { following, forYou }
