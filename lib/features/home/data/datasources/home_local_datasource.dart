import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/features/home/data/models/room_model.dart';
import 'package:eye_rex_us/features/home/data/models/story_model.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';

abstract class HomeLocalDataSource {
  Future<List<StoryModel>> getStories({required HomeFeedTab tab});
  Future<List<RoomModel>> getLiveRooms({required HomeFeedTab tab});
}

class HomeLocalDataSourceImpl implements HomeLocalDataSource {
  static const _allStories = [
    StoryModel(id: '1', name: 'Your Story', isUserStory: true, imageUrl: AppAssets.storyS3),
    StoryModel(id: '2', name: 'John', imageUrl: AppAssets.storyS1),
    StoryModel(id: '3', name: 'Jane', imageUrl: AppAssets.storyS2),
    StoryModel(id: '4', name: 'Peter', imageUrl: AppAssets.storyS4),
    StoryModel(id: '5', name: 'Adarsh', imageUrl: AppAssets.storyS3),
    StoryModel(id: '6', name: 'Rahul', imageUrl: AppAssets.storyS4),
    StoryModel(id: '7', name: 'Priya', imageUrl: AppAssets.storyS),
    StoryModel(id: '8', name: 'Sneha', imageUrl: AppAssets.storyS2),
    StoryModel(id: '9', name: 'Kabir', imageUrl: AppAssets.storyS1),
    StoryModel(id: '10', name: 'Neha', imageUrl: AppAssets.storyS4),
    StoryModel(id: '11', name: 'Vikram', imageUrl: AppAssets.storyS),
    StoryModel(id: '12', name: 'Riya', imageUrl: AppAssets.storyS2),
  ];

  @override
  Future<List<StoryModel>> getStories({required HomeFeedTab tab}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return switch (tab) {
      HomeFeedTab.following => _allStories.take(6).toList(),
      HomeFeedTab.explore => _allStories,
      HomeFeedTab.newTab => _allStories.skip(2).take(8).toList(),
      HomeFeedTab.nearby => _allStories.take(5).toList(),
    };
  }

  @override
  Future<List<RoomModel>> getLiveRooms({required HomeFeedTab tab}) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return switch (tab) {
      HomeFeedTab.following => _followingRooms,
      HomeFeedTab.explore => _exploreRooms,
      HomeFeedTab.newTab => _newRooms,
      HomeFeedTab.nearby => _nearbyRooms,
    };
  }

  static const _exploreRooms = [
    RoomModel(
      id: '1',
      title: 'Hey itz ur fav g',
      tag: 'Chatting',
      views: '6394',
      countryFlag: '🇮🇳',
      isPk: true,
      coverUrl: AppAssets.liveRoom,
      stageMemberCount: 1,
    ),
    RoomModel(
      id: '2',
      title: 'सत्यानाश',
      tag: 'Make Friends',
      views: '8023',
      countryFlag: '🇮🇳',
      isPk: true,
      coverUrl: AppAssets.audio,
      stageMemberCount: 3,
    ),
    RoomModel(
      id: '3',
      title: 'Welcome to my live room',
      tag: 'Make Friends',
      views: '1205',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.stage,
      stageMemberCount: 2,
    ),
    RoomModel(
      id: '4',
      title: 'TOP10 Streaming',
      tag: 'TOP10',
      views: '9432',
      countryFlag: '🇮🇳',
      isPk: true,
      coverUrl: AppAssets.liveRoom,
      stageMemberCount: 5,
    ),
  ];

  static const _followingRooms = [
    RoomModel(
      id: 'f1',
      title: 'Kabir is live now',
      tag: 'Chatting',
      views: '2104',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.storyS1,
    ),
    RoomModel(
      id: 'f2',
      title: 'Priya evening vibes',
      tag: 'Make Friends',
      views: '1580',
      countryFlag: '🇮🇳',
      isPk: true,
      coverUrl: AppAssets.storyS2,
    ),
    RoomModel(
      id: 'f3',
      title: 'Rahul music room',
      tag: 'Chatting',
      views: '920',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.audio,
    ),
  ];

  static const _newRooms = [
    RoomModel(
      id: 'n1',
      title: 'Just went live — join me',
      tag: 'New',
      views: '412',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.storyS4,
    ),
    RoomModel(
      id: 'n2',
      title: 'Fresh stream tonight',
      tag: 'New',
      views: '287',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.storyS,
    ),
    RoomModel(
      id: 'n3',
      title: 'New host on air',
      tag: 'TOP10',
      views: '1055',
      countryFlag: '🇮🇳',
      isPk: true,
      coverUrl: AppAssets.liveRoom,
    ),
    RoomModel(
      id: 'n4',
      title: 'First live session',
      tag: 'Make Friends',
      views: '198',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.stage,
    ),
  ];

  static const _nearbyRooms = [
    RoomModel(
      id: 'nb1',
      title: 'Delhi hangout room',
      tag: 'Nearby',
      views: '3340',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.storyS3,
    ),
    RoomModel(
      id: 'nb2',
      title: 'Mumbai street chat',
      tag: 'Nearby',
      views: '2891',
      countryFlag: '🇮🇳',
      isPk: true,
      coverUrl: AppAssets.storyS2,
    ),
    RoomModel(
      id: 'nb3',
      title: 'Local creators live',
      tag: 'Chatting',
      views: '1764',
      countryFlag: '🇮🇳',
      isPk: false,
      coverUrl: AppAssets.audio,
    ),
    RoomModel(
      id: 'nb4',
      title: 'Around you — party',
      tag: 'Make Friends',
      views: '2210',
      countryFlag: '🇮🇳',
      isPk: true,
      coverUrl: AppAssets.liveRoom,
    ),
  ];
}
