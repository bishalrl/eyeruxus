import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/features/home/data/models/party_room_model.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';

abstract class PartyLocalDataSource {
  Future<PartyFeed> getPartyFeed({required PartyFeedTab tab});
}

class PartyLocalDataSourceImpl implements PartyLocalDataSource {
  static const _friendsInParty = [
    PartyFriendActivityModel(
      name: 'Jane',
      avatar: AppAssets.storyS2,
      partyTitle: 'Late Night Vibes',
    ),
    PartyFriendActivityModel(
      name: 'Kabir',
      avatar: AppAssets.storyS1,
      partyTitle: 'Bollywood Night',
    ),
    PartyFriendActivityModel(
      name: 'Priya',
      avatar: AppAssets.storyS3,
      partyTitle: 'Chill & Chat',
    ),
    PartyFriendActivityModel(
      name: 'Rahul',
      avatar: AppAssets.storyS4,
      partyTitle: 'Gaming Party',
    ),
  ];

  static const _hotRooms = [
    PartyRoomModel(
      id: 'p1',
      title: 'Weekend Hangout 🎉',
      hostName: 'Anime Lover',
      hostAvatar: AppAssets.storyS1,
      coverUrl: AppAssets.party,
      vibeKey: 'partyVibeChatting',
      memberCount: 8,
      maxMembers: 12,
      isPrivate: false,
      layoutRoomId: 'room_8',
    ),
    PartyRoomModel(
      id: 'p2',
      title: 'Bollywood Sing-Along',
      hostName: 'Priya',
      hostAvatar: AppAssets.storyS3,
      coverUrl: AppAssets.liveRoom,
      vibeKey: 'partyVibeSinging',
      memberCount: 6,
      maxMembers: 10,
      isPrivate: false,
      layoutRoomId: 'room_4',
    ),
    PartyRoomModel(
      id: 'p3',
      title: 'Private Party',
      hostName: 'Kabir',
      hostAvatar: AppAssets.storyS2,
      coverUrl: AppAssets.audio,
      vibeKey: 'partyVibeChill',
      memberCount: 4,
      maxMembers: 10,
      isPrivate: true,
      layoutRoomId: 'room_8',
    ),
    PartyRoomModel(
      id: 'p4',
      title: 'Gaming Squad',
      hostName: 'Vikram',
      hostAvatar: AppAssets.storyS4,
      coverUrl: AppAssets.stage,
      vibeKey: 'partyVibeGaming',
      memberCount: 5,
      maxMembers: 8,
      isPrivate: false,
      layoutRoomId: 'room_4',
    ),
    PartyRoomModel(
      id: 'p5',
      title: 'Dance Floor Live',
      hostName: 'Sneha',
      hostAvatar: AppAssets.storyS2,
      coverUrl: AppAssets.background,
      vibeKey: 'partyVibeDancing',
      memberCount: 12,
      maxMembers: 16,
      isPrivate: false,
      layoutRoomId: 'room_16',
    ),
    PartyRoomModel(
      id: 'p6',
      title: 'Crack Jokes Club',
      hostName: 'Rahul',
      hostAvatar: AppAssets.storyS1,
      coverUrl: AppAssets.liveRoom,
      vibeKey: 'partyVibeComedy',
      memberCount: 3,
      maxMembers: 8,
      isPrivate: false,
      layoutRoomId: 'room_3',
    ),
  ];

  static const _nearbyRooms = [
    PartyRoomModel(
      id: 'pn1',
      title: 'Around you — party',
      hostName: 'Neha',
      hostAvatar: AppAssets.storyS4,
      coverUrl: AppAssets.party,
      vibeKey: 'partyVibeChatting',
      memberCount: 7,
      maxMembers: 10,
      isPrivate: false,
      layoutRoomId: 'room_4',
    ),
    PartyRoomModel(
      id: 'pn2',
      title: 'Local Karaoke',
      hostName: 'Adarsh',
      hostAvatar: AppAssets.storyS3,
      coverUrl: AppAssets.audio,
      vibeKey: 'partyVibeSinging',
      memberCount: 4,
      maxMembers: 8,
      isPrivate: false,
      layoutRoomId: 'room_3',
    ),
    PartyRoomModel(
      id: 'pn3',
      title: 'Neighborhood Chill',
      hostName: 'Riya',
      hostAvatar: AppAssets.storyS2,
      coverUrl: AppAssets.stage,
      vibeKey: 'partyVibeChill',
      memberCount: 2,
      maxMembers: 6,
      isPrivate: false,
      layoutRoomId: 'movie',
    ),
  ];

  static const _friendsRooms = [
    PartyRoomModel(
      id: 'pf1',
      title: 'Jane\'s Birthday Bash',
      hostName: 'Jane',
      hostAvatar: AppAssets.storyS2,
      coverUrl: AppAssets.party,
      vibeKey: 'partyVibeChatting',
      memberCount: 9,
      maxMembers: 12,
      isPrivate: false,
      layoutRoomId: 'room_8',
    ),
    PartyRoomModel(
      id: 'pf2',
      title: 'Kabir\'s Squad Room',
      hostName: 'Kabir',
      hostAvatar: AppAssets.storyS1,
      coverUrl: AppAssets.liveRoom,
      vibeKey: 'partyVibeGaming',
      memberCount: 5,
      maxMembers: 8,
      isPrivate: false,
      layoutRoomId: 'pk',
    ),
  ];

  static const _privateRooms = [
    PartyRoomModel(
      id: 'pp1',
      title: 'Invite Only Lounge',
      hostName: 'Priya',
      hostAvatar: AppAssets.storyS3,
      coverUrl: AppAssets.audio,
      vibeKey: 'partyVibeChill',
      memberCount: 3,
      maxMembers: 6,
      isPrivate: true,
      usePartySession: true,
    ),
    PartyRoomModel(
      id: 'pp2',
      title: 'VIP Party Night',
      hostName: 'Vikram',
      hostAvatar: AppAssets.storyS4,
      coverUrl: AppAssets.party,
      vibeKey: 'partyVibeDancing',
      memberCount: 6,
      maxMembers: 10,
      isPrivate: true,
      layoutRoomId: 'room_10',
    ),
  ];

  @override
  Future<PartyFeed> getPartyFeed({required PartyFeedTab tab}) async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    final rooms = switch (tab) {
      PartyFeedTab.hot => _hotRooms,
      PartyFeedTab.nearby => _nearbyRooms,
      PartyFeedTab.friends => _friendsRooms,
      PartyFeedTab.private => _privateRooms,
    };
    return PartyFeed(
      rooms: List<PartyRoom>.from(rooms),
      friendsInParty: tab == PartyFeedTab.friends || tab == PartyFeedTab.hot
          ? List<PartyFriendActivity>.from(_friendsInParty)
          : const [],
    );
  }
}
