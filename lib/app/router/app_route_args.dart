import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';

class ReelsFeedRouteArgs {
  const ReelsFeedRouteArgs({
    this.initialIndex = 0,
    this.feedTab = ReelsFeedTab.forYou,
  });

  final int initialIndex;
  final ReelsFeedTab feedTab;
}

class ChatRoomRouteArgs {
  const ChatRoomRouteArgs({
    required this.roomId,
    this.role = LiveParticipantRole.viewer,
    this.instantJoinSeat = false,
    this.preferredSeatIndex,
    this.partyId,
    this.partyTitle,
  });

  final String roomId;
  final LiveParticipantRole role;

  /// Testing: join directly on a seat without host approval.
  final bool instantJoinSeat;

  /// Seat index to request when entering as viewer (host must approve).
  final int? preferredSeatIndex;
  final String? partyId;
  final String? partyTitle;
}

class OtpRouteArgs {
  const OtpRouteArgs({this.phoneNumber});

  final String? phoneNumber;
}

/// One room in the vertical live browse feed (Home / Party).
class LiveRoomBrowseEntry {
  const LiveRoomBrowseEntry({
    required this.roomId,
    this.title,
    this.partyId,
  });

  final String roomId;
  final String? title;
  final String? partyId;
}

class LiveRoomBrowseRouteArgs {
  const LiveRoomBrowseRouteArgs({
    required this.entries,
    this.initialIndex = 0,
    this.initialSeatRequestIndex,
    this.instantJoinSeat = false,
  });

  final List<LiveRoomBrowseEntry> entries;
  final int initialIndex;

  /// Applied only on the room opened from the feed (seat request or instant join).
  final int? initialSeatRequestIndex;
  final bool instantJoinSeat;
}
