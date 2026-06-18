import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_comment.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';

/// Mock reel feed — replace with API pagination for production.
abstract final class ReelsLocalDataSource {
  static const _authors = [
    'Anime Lover',
    'Adarsh',
    'Music Queen',
    'Dance Star',
    'Travel Vibes',
    'Comedy King',
  ];

  static const _captions = [
    'Love Music #Topics you are...',
    'Weekend vibes #Travel #Music',
    'New dance challenge 🔥 #FYP',
    'Sunset moments #Nature #Peace',
    'POV: live room energy #Live',
    'Try this filter! #Trending',
  ];

  static const _media = [
    AppAssets.background,
    AppAssets.liveRoom,
    AppAssets.storyS1,
    AppAssets.storyS2,
    AppAssets.audio,
    AppAssets.stage,
  ];

  static List<ReelPost> initialFeed(ReelsFeedTab tab, {int startIndex = 0}) {
    return List.generate(8, (i) => _buildReel(tab, startIndex + i));
  }

  static List<ReelPost> loadMore(ReelsFeedTab tab, int offset) {
    return List.generate(6, (i) => _buildReel(tab, offset + i));
  }

  static ReelPost _buildReel(ReelsFeedTab tab, int index) {
    final author = _authors[index % _authors.length];
    final baseLikes = tab == ReelsFeedTab.forYou ? 2400 : 890;
    return ReelPost(
      id: '${tab.name}_$index',
      authorName: author,
      avatarAsset: AppAssets.avatar,
      mediaAsset: _media[index % _media.length],
      caption: _captions[index % _captions.length],
      likeCount: baseLikes + (index * 137) % 5000,
      commentCount: 120 + (index * 23) % 800,
      shareCount: 40 + (index * 11) % 300,
      isFollowing: tab == ReelsFeedTab.following,
    );
  }

  static List<ReelComment> commentsFor(String reelId) {
    return [
      ReelComment(
        id: '${reelId}_c0',
        authorName: 'Music Fan',
        avatarAsset: AppAssets.avatar,
        text: 'This is amazing! 🔥',
        timeLabel: '2h',
      ),
      ReelComment(
        id: '${reelId}_c1',
        authorName: 'Live Lover',
        avatarAsset: AppAssets.avatar,
        text: 'Can you do a live room next?',
        timeLabel: '5h',
      ),
      ReelComment(
        id: '${reelId}_c2',
        authorName: 'Dance Crew',
        avatarAsset: AppAssets.avatar,
        text: 'Tutorial please 🙏',
        timeLabel: '1d',
      ),
    ];
  }

  static ReelComment newComment(String text) {
    return ReelComment(
      id: 'local_${DateTime.now().millisecondsSinceEpoch}',
      authorName: 'You',
      avatarAsset: AppAssets.avatar,
      text: text,
      timeLabel: 'now',
    );
  }
}
