class PartyRoom {
  const PartyRoom({
    required this.id,
    required this.title,
    required this.hostName,
    required this.hostAvatar,
    required this.coverUrl,
    required this.vibeKey,
    required this.memberCount,
    required this.maxMembers,
    required this.isPrivate,
    this.layoutRoomId,
    this.usePartySession = false,
  });

  final String id;
  final String title;
  final String hostName;
  final String hostAvatar;
  final String coverUrl;
  final String vibeKey;
  final int memberCount;
  final int maxMembers;
  final bool isPrivate;
  final String? layoutRoomId;
  final bool usePartySession;
}

class PartyFriendActivity {
  const PartyFriendActivity({
    required this.name,
    required this.avatar,
    required this.partyTitle,
  });

  final String name;
  final String avatar;
  final String partyTitle;
}

class PartyFeed {
  const PartyFeed({
    required this.rooms,
    required this.friendsInParty,
  });

  final List<PartyRoom> rooms;
  final List<PartyFriendActivity> friendsInParty;
}
