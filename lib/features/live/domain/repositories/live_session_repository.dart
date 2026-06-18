import '../entities/live_session_entities.dart';

abstract class LiveSessionRepository {
  Future<LiveRoomSession> joinSession({
    required String roomId,
    String? partyId,
    String? password,
    LiveParticipantRole role,
    LiveJoinIntent joinIntent,
  });

  Future<LiveRoomSession> createSession(CreateLiveRoomRequest request);

  Future<List<LiveRoomListing>> discoverRooms({
    String? query,
    LiveRoomCategory? category,
    bool trendingOnly,
    bool recommendedOnly,
  });

  Future<LiveRoomSession> requestSeat({
    required String sessionId,
    required int seatIndex,
  });

  Future<LiveRoomSession> approveSeatRequest({
    required String sessionId,
    required String requestId,
  });

  Future<LiveRoomSession> rejectSeatRequest({
    required String sessionId,
    required String requestId,
  });

  Future<LiveRoomSession> leaveSeat({required String sessionId});

  /// Places the local user on a seat immediately (testing / party join).
  Future<LiveRoomSession> instantJoinSeat({
    required String sessionId,
    int? seatIndex,
  });

  Future<LiveRoomSession> muteParticipant({
    required String sessionId,
    required String participantId,
    required bool muted,
  });

  Future<LiveRoomSession> setParticipantCamera({
    required String sessionId,
    required String participantId,
    required bool cameraOff,
  });

  Future<LiveRoomSession> assignCohost({
    required String sessionId,
    required String participantId,
  });

  Future<LiveRoomSession> demoteParticipant({
    required String sessionId,
    required String participantId,
  });

  Future<LiveRoomSession> kickParticipant({
    required String sessionId,
    required String participantId,
  });

  Future<LiveRoomSession> updateSettings({
    required String sessionId,
    required LiveRoomSettings settings,
  });

  Future<LiveRoomSession> assignModerator({
    required String sessionId,
    required String participantId,
  });

  Future<LiveRoomSession> pinParticipant({
    required String sessionId,
    required String participantId,
  });

  Future<void> endSession({required String sessionId});

  Future<LiveRoomSession> rejoinSession({required String sessionId});
}
