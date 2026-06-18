import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';

class PartyRoomModel extends PartyRoom {
  const PartyRoomModel({
    required super.id,
    required super.title,
    required super.hostName,
    required super.hostAvatar,
    required super.coverUrl,
    required super.vibeKey,
    required super.memberCount,
    required super.maxMembers,
    required super.isPrivate,
    super.layoutRoomId,
    super.usePartySession,
  });
}

class PartyFriendActivityModel extends PartyFriendActivity {
  const PartyFriendActivityModel({
    required super.name,
    required super.avatar,
    required super.partyTitle,
  });
}
