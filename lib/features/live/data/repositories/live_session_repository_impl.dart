import 'package:eye_rex_us/features/live/data/datasources/live_session_local_datasource.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/domain/repositories/live_session_repository.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_layout_registry.dart';

class LiveSessionRepositoryImpl implements LiveSessionRepository {
  LiveSessionRepositoryImpl(this._local);

  final LiveSessionLocalDataSource _local;

  @override
  Future<LiveRoomSession> joinSession({
    required String roomId,
    String? password,
    LiveParticipantRole role = LiveParticipantRole.viewer,
  }) {
    return _local.loadSession(roomId: roomId, role: role);
  }

  @override
  Future<LiveRoomSession> createSession(CreateLiveRoomRequest request) {
    return _local.createSession(request);
  }

  @override
  Future<List<LiveRoomListing>> discoverRooms({
    String? query,
    LiveRoomCategory? category,
    bool trendingOnly = false,
    bool recommendedOnly = false,
  }) async {
    var rooms = await _local.listRooms();
    if (query != null && query.trim().isNotEmpty) {
      final q = query.toLowerCase();
      rooms = rooms
          .where(
            (r) =>
                r.title.toLowerCase().contains(q) ||
                r.hostName.toLowerCase().contains(q),
          )
          .toList();
    }
    if (category != null) {
      rooms = rooms.where((r) => r.category == category).toList();
    }
    if (trendingOnly) {
      rooms = rooms.where((r) => r.isTrending).toList();
    }
    if (recommendedOnly) {
      rooms = rooms.where((r) => r.isRecommended).toList();
    }
    return rooms;
  }

  @override
  Future<LiveRoomSession> requestSeat({
    required String sessionId,
    required int seatIndex,
  }) async {
    final session = await _findSession(sessionId);
    if (!session.settings.seatRequestsEnabled || session.settings.seatsLocked) {
      return session;
    }
    final seat = session.seats[seatIndex];
    if (seat.status != LiveSeatStatus.empty) return session;

    final request = LiveSeatRequest(
      id: 'req_${DateTime.now().millisecondsSinceEpoch}',
      userId: 'me',
      userName: 'You',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      seatIndex: seatIndex,
      requestedAt: DateTime.now(),
    );

    final seats = List<LiveSeat>.from(session.seats);
    seats[seatIndex] = seat.copyWith(status: LiveSeatStatus.requested);

    final updated = session.copyWith(
      seats: seats,
      seatRequests: [...session.seatRequests, request],
    );
    return _local.saveSession(updated);
  }

  @override
  Future<LiveRoomSession> approveSeatRequest({
    required String sessionId,
    required String requestId,
  }) async {
    final session = await _findSession(sessionId);
    final request = session.seatRequests.firstWhere((r) => r.id == requestId);
    final participant = LiveParticipant(
      id: request.userId,
      name: request.userName,
      avatarUrl: request.avatarUrl,
      role: LiveParticipantRole.cohost,
    );

    final seats = List<LiveSeat>.from(session.seats);
    seats[request.seatIndex] = LiveSeat(
      index: request.seatIndex,
      status: LiveSeatStatus.occupied,
      participant: participant,
    );

    final updated = session.copyWith(
      seats: seats,
      participants: [...session.participants, participant],
      seatRequests: session.seatRequests.where((r) => r.id != requestId).toList(),
    );
    return _local.saveSession(updated);
  }

  @override
  Future<LiveRoomSession> rejectSeatRequest({
    required String sessionId,
    required String requestId,
  }) async {
    final session = await _findSession(sessionId);
    final request = session.seatRequests.firstWhere((r) => r.id == requestId);
    final seats = List<LiveSeat>.from(session.seats);
    if (seats[request.seatIndex].status == LiveSeatStatus.requested) {
      seats[request.seatIndex] =
          LiveSeat(index: request.seatIndex, status: LiveSeatStatus.empty);
    }
    final updated = session.copyWith(
      seats: seats,
      seatRequests: session.seatRequests.where((r) => r.id != requestId).toList(),
    );
    return _local.saveSession(updated);
  }

  @override
  Future<LiveRoomSession> leaveSeat({required String sessionId}) async {
    final session = await _findSession(sessionId);
    final seats = session.seats.map((s) {
      if (s.participant?.id == 'me' || s.participant?.id == 'host_me') {
        return LiveSeat(index: s.index, status: LiveSeatStatus.empty);
      }
      return s;
    }).toList();
    final updated = session.copyWith(
      seats: seats,
      currentUserRole: LiveParticipantRole.viewer,
    );
    return _local.saveSession(updated);
  }

  @override
  Future<LiveRoomSession> instantJoinSeat({
    required String sessionId,
    int? seatIndex,
  }) async {
    final session = await _findSession(sessionId);
    if (session.settings.seatsLocked) return session;

    final targetIndex = seatIndex ??
        session.seats.indexWhere((s) => s.status == LiveSeatStatus.empty);
    if (targetIndex < 0) return session;

    const me = LiveParticipant(
      id: 'me',
      name: 'You',
      avatarUrl: 'https://i.pravatar.cc/150?img=3',
      role: LiveParticipantRole.cohost,
    );

    final seats = session.seats.asMap().entries.map((entry) {
      final seat = entry.value;
      if (seat.participant?.id == 'me') {
        return LiveSeat(index: seat.index, status: LiveSeatStatus.empty);
      }
      return seat;
    }).toList();

    seats[targetIndex] = LiveSeat(
      index: targetIndex,
      status: LiveSeatStatus.occupied,
      participant: me,
    );

    final participants = [
      ...session.participants.where((p) => p.id != 'me'),
      me,
    ];

    final updated = session.copyWith(
      seats: seats,
      participants: participants,
      currentUserRole: LiveParticipantRole.cohost,
      seatRequests: session.seatRequests
          .where((r) => r.userId != 'me')
          .toList(),
    );
    return _local.saveSession(updated);
  }

  @override
  Future<LiveRoomSession> muteParticipant({
    required String sessionId,
    required String participantId,
    required bool muted,
  }) async {
    final session = await _findSession(sessionId);
    final participants = session.participants.map((p) {
      if (p.id == participantId) return p.copyWith(isMuted: muted);
      return p;
    }).toList();
    final seats = session.seats.map((s) {
      if (s.participant?.id == participantId) {
        return s.copyWith(
          participant: () => s.participant!.copyWith(isMuted: muted),
        );
      }
      return s;
    }).toList();
    return _local.saveSession(
      session.copyWith(participants: participants, seats: seats),
    );
  }

  @override
  Future<LiveRoomSession> setParticipantCamera({
    required String sessionId,
    required String participantId,
    required bool cameraOff,
  }) async {
    final session = await _findSession(sessionId);
    return _local.saveSession(
      _patchParticipant(session, participantId, (p) => p.copyWith(isCameraOff: cameraOff)),
    );
  }

  @override
  Future<LiveRoomSession> assignCohost({
    required String sessionId,
    required String participantId,
  }) async {
    final session = await _findSession(sessionId);
    return _local.saveSession(
      _patchParticipant(
        session,
        participantId,
        (p) => p.copyWith(role: LiveParticipantRole.cohost),
      ),
    );
  }

  @override
  Future<LiveRoomSession> demoteParticipant({
    required String sessionId,
    required String participantId,
  }) async {
    final session = await _findSession(sessionId);
    final seats = session.seats.map((s) {
      if (s.participant?.id == participantId) {
        return LiveSeat(index: s.index, status: LiveSeatStatus.empty);
      }
      return s;
    }).toList();
    final participants = session.participants.map((p) {
      if (p.id == participantId) {
        return p.copyWith(
          role: LiveParticipantRole.viewer,
          isMuted: false,
          isCameraOff: false,
        );
      }
      return p;
    }).toList();
    return _local.saveSession(
      session.copyWith(seats: seats, participants: participants),
    );
  }

  @override
  Future<LiveRoomSession> kickParticipant({
    required String sessionId,
    required String participantId,
  }) async {
    final session = await _findSession(sessionId);
    final seats = session.seats.map((s) {
      if (s.participant?.id == participantId) {
        return LiveSeat(index: s.index, status: LiveSeatStatus.empty);
      }
      return s;
    }).toList();
    return _local.saveSession(
      session.copyWith(
        seats: seats,
        participants:
            session.participants.where((p) => p.id != participantId).toList(),
      ),
    );
  }

  @override
  Future<LiveRoomSession> updateSettings({
    required String sessionId,
    required LiveRoomSettings settings,
  }) async {
    final session = await _findSession(sessionId);
    return _local.saveSession(session.copyWith(settings: settings));
  }

  @override
  Future<LiveRoomSession> assignModerator({
    required String sessionId,
    required String participantId,
  }) async {
    final session = await _findSession(sessionId);
    return _local.saveSession(
      _patchParticipant(
        session,
        participantId,
        (p) => p.copyWith(role: LiveParticipantRole.moderator),
      ),
    );
  }

  @override
  Future<LiveRoomSession> pinParticipant({
    required String sessionId,
    required String participantId,
  }) async {
    final session = await _findSession(sessionId);
    final nextId =
        session.activeSpeakerId == participantId ? null : participantId;
    return _local.saveSession(session.copyWith(activeSpeakerId: nextId));
  }

  LiveRoomSession _patchParticipant(
    LiveRoomSession session,
    String participantId,
    LiveParticipant Function(LiveParticipant) patch,
  ) {
    final participants = session.participants.map((p) {
      if (p.id == participantId) return patch(p);
      return p;
    }).toList();
    final seats = session.seats.map((s) {
      if (s.participant?.id == participantId) {
        return s.copyWith(participant: () => patch(s.participant!));
      }
      return s;
    }).toList();
    return session.copyWith(participants: participants, seats: seats);
  }

  @override
  Future<void> endSession({required String sessionId}) async {
    final session = await _findSession(sessionId);
    await _local.saveSession(
      session.copyWith(viewerCount: 0),
    );
  }

  @override
  Future<LiveRoomSession> rejoinSession({required String sessionId}) {
    return _findSession(sessionId);
  }

  Future<LiveRoomSession> _findSession(String sessionId) async {
    final byId = await _local.getSessionById(sessionId);
    if (byId != null) return byId;

    const prefix = 'session_';
    if (sessionId.startsWith(prefix)) {
      final roomId = sessionId.substring(prefix.length);
      final byRoom = await _local.getSessionByRoomId(roomId);
      if (byRoom != null) return byRoom;
    }

    for (final count in LiveLayoutRegistry.supportedSeatCounts) {
      final roomId = LiveLayoutRegistry.roomIdForSeatCount(count);
      final session = await _local.getSessionByRoomId(roomId);
      if (session != null && session.id == sessionId) return session;
    }

    throw StateError('Live session not found: $sessionId');
  }
}
