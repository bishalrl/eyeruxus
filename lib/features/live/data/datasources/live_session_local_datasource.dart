import 'dart:math';

import 'package:eye_rex_us/features/live/domain/entities/live_platform_entities.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/domain/live_session_key.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_layout_registry.dart';

abstract class LiveSessionLocalDataSource {
  Future<LiveRoomSession> loadSession({
    required String roomId,
    String? partyId,
    String? password,
    LiveParticipantRole role,
  });

  Future<LiveRoomSession?> getSessionById(String sessionId);

  Future<LiveRoomSession?> getSessionByRoomId(String roomId);

  Future<LiveRoomSession> createSession(CreateLiveRoomRequest request);

  Future<List<LiveRoomListing>> listRooms();

  Future<LiveRoomSession> saveSession(LiveRoomSession session);

  Future<LiveRoomSession> saveSessionByKey(String sessionKey, LiveRoomSession session);

  LiveRoomSession clearLocalViewerState(LiveRoomSession session);
}

class LiveSessionLocalDataSourceImpl implements LiveSessionLocalDataSource {
  LiveSessionLocalDataSourceImpl();

  final _sessions = <String, LiveRoomSession>{};
  final _random = Random();

  static const _avatars = [
    'https://i.pravatar.cc/150?img=1',
    'https://i.pravatar.cc/150?img=5',
    'https://i.pravatar.cc/150?img=8',
    'https://i.pravatar.cc/150?img=12',
    'https://i.pravatar.cc/150?img=15',
  ];

  static const _covers = [
    'https://picsum.photos/seed/live1/400/600',
    'https://picsum.photos/seed/live2/400/600',
    'https://picsum.photos/seed/live3/400/600',
    'https://picsum.photos/seed/live4/400/600',
  ];

  @override
  Future<LiveRoomSession> loadSession({
    required String roomId,
    String? partyId,
    String? password,
    LiveParticipantRole role = LiveParticipantRole.viewer,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 280));
    final sessionKey = LiveSessionKey.forRoom(roomId: roomId, partyId: partyId);
    final existing = _sessions[sessionKey];
    if (existing != null) {
      if (existing.privacy == LiveRoomPrivacy.passwordProtected) {
        final expected = existing.meta.roomPassword;
        if (expected != null && expected.isNotEmpty && expected != password) {
          throw StateError('Invalid room password');
        }
      }
      final resolved = role == LiveParticipantRole.host
          ? _applyCurrentUserAsHost(existing)
          : existing.copyWith(currentUserRole: role);
      return _storeSession(sessionKey, resolved);
    }
    final session = _buildDefaultSession(
      roomId,
      role,
      partyId: partyId,
    );
    if (session.privacy == LiveRoomPrivacy.passwordProtected &&
        password != null &&
        password.isNotEmpty) {
      return _storeSession(
        sessionKey,
        session.copyWith(
          meta: session.meta.copyWith(roomPassword: () => password),
        ),
      );
    }
    return _storeSession(sessionKey, session);
  }

  LiveRoomSession _storeSession(String sessionKey, LiveRoomSession session) {
    final peak = session.viewerCount > session.meta.peakViewerCount
        ? session.viewerCount
        : session.meta.peakViewerCount;
    final withPeak = session.copyWith(
      meta: session.meta.copyWith(peakViewerCount: peak),
    );
    _sessions[sessionKey] = withPeak;
    _sessions[withPeak.id] = withPeak;
    return withPeak;
  }

  @override
  Future<LiveRoomSession?> getSessionById(String sessionId) async {
    final direct = _sessions[sessionId];
    if (direct != null) return direct;
    for (final session in _sessions.values) {
      if (session.id == sessionId) return session;
    }
    return null;
  }

  @override
  Future<LiveRoomSession?> getSessionByRoomId(String roomId) async {
    return _sessions[roomId];
  }

  LiveRoomSession _applyCurrentUserAsHost(LiveRoomSession session) {
    const me = LiveParticipant(
      id: 'host_me',
      name: 'You',
      avatarUrl: 'https://i.pravatar.cc/150?img=1',
      role: LiveParticipantRole.host,
      isSpeaking: true,
    );
    final seats = List<LiveSeat>.from(session.seats);
    if (seats.isNotEmpty) {
      seats[0] = LiveSeat(
        index: 0,
        status: LiveSeatStatus.occupied,
        participant: me,
      );
    }
    final participants = [
      me,
      ...session.participants.where((p) => p.id != 'host_me'),
    ];
    return session.copyWith(
      host: me,
      seats: seats,
      participants: participants,
      activeSpeakerId: me.id,
      currentUserRole: LiveParticipantRole.host,
    );
  }

  @override
  Future<LiveRoomSession> createSession(CreateLiveRoomRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    final roomId = LiveLayoutRegistry.roomIdForSeatCount(request.seatCount);
    final host = LiveParticipant(
      id: 'host_me',
      name: 'You',
      avatarUrl: _avatars.first,
      role: LiveParticipantRole.host,
    );
    final session = LiveRoomSession(
      id: 'session_${DateTime.now().millisecondsSinceEpoch}',
      title: request.title,
      description: request.description,
      host: host,
      seatCount: request.seatCount,
      category: request.category,
      privacy: request.privacy,
      language: request.language,
      viewerCount: 1,
      likeCount: 0,
      seats: _buildSeats(request.seatCount, hostOccupiesFirst: true),
      participants: [host],
      seatRequests: const [],
      settings: const LiveRoomSettings(),
      coverImageUrl: request.coverImageUrl ?? _covers.first,
      currentUserRole: LiveParticipantRole.host,
      meta: LiveSessionMeta(
        startedAt: DateTime.now(),
        roomPassword: request.password,
        voiceOnly: request.category == LiveRoomCategory.chatting &&
            request.seatCount <= 2,
        languageCode: request.language.toLowerCase().startsWith('en') ? 'en' : 'hi',
      ),
    );
    return _storeSession(roomId, session);
  }

  @override
  Future<LiveRoomSession> saveSessionByKey(
    String sessionKey,
    LiveRoomSession session,
  ) async {
    return _storeSession(sessionKey, session);
  }

  @override
  LiveRoomSession clearLocalViewerState(LiveRoomSession session) {
    final myRequestIndexes = session.seatRequests
        .where((r) => r.userId == 'me')
        .map((r) => r.seatIndex)
        .toSet();

    final seats = session.seats.map((seat) {
      if (seat.participant?.id == 'me') {
        return LiveSeat(index: seat.index, status: LiveSeatStatus.empty);
      }
      if (myRequestIndexes.contains(seat.index) &&
          seat.status == LiveSeatStatus.requested) {
        return LiveSeat(index: seat.index, status: LiveSeatStatus.empty);
      }
      return seat;
    }).toList();

    return session.copyWith(
      seats: seats,
      seatRequests:
          session.seatRequests.where((r) => r.userId != 'me').toList(),
      participants: session.participants.where((p) => p.id != 'me').toList(),
      currentUserRole: LiveParticipantRole.viewer,
    );
  }

  @override
  Future<List<LiveRoomListing>> listRooms() async {
    await Future<void>.delayed(const Duration(milliseconds: 320));
    final listings = <LiveRoomListing>[];
    var index = 0;
    for (final count in LiveLayoutRegistry.supportedSeatCounts) {
      if (count == 1) continue;
      final roomId = LiveLayoutRegistry.roomIdForSeatCount(count);
      listings.add(
        LiveRoomListing(
          id: 'listing_$roomId',
          title: _titleFor(count),
          hostName: _hostNames[index % _hostNames.length],
          hostAvatarUrl: _avatars[index % _avatars.length],
          viewerCount: 120 + _random.nextInt(4800),
          seatCount: count,
          category: LiveRoomCategory.values[index % 5],
          isTrending: index.isEven,
          isRecommended: index % 3 == 0,
          isPopular: index % 2 == 1,
          isFollowing: index % 4 == 0,
          isNearby: index % 5 == 1,
          isNewCreator: index < 2,
          coverImageUrl: _covers[index % _covers.length],
          roomId: roomId,
          language: index.isEven ? 'English' : 'Spanish',
          country: index % 3 == 0 ? 'USA' : 'Global',
        ),
      );
      index++;
    }
    return listings;
  }

  @override
  Future<LiveRoomSession> saveSession(LiveRoomSession session) async {
    final roomId = LiveLayoutRegistry.roomIdForSeatCount(session.seatCount);
    final key = LiveSessionKey.forRoom(roomId: roomId, partyId: session.meta.partyId);
    return _storeSession(key, session);
  }

  LiveRoomSession _buildDefaultSession(
    String roomId,
    LiveParticipantRole role, {
    String? partyId,
  }) {
    final seatCount = LiveLayoutRegistry.seatCountForRoom(roomId);

    if (role == LiveParticipantRole.host) {
      const me = LiveParticipant(
        id: 'host_me',
        name: 'You',
        avatarUrl: 'https://i.pravatar.cc/150?img=1',
        role: LiveParticipantRole.host,
        isSpeaking: true,
      );
      final seats = _buildSeats(seatCount, hostOccupiesFirst: true);
      return LiveRoomSession(
        id: 'session_$roomId',
        title: _titleFor(seatCount),
        description: 'Welcome to your live room!',
        host: me,
        seatCount: seatCount,
        category: LiveRoomCategory.chatting,
        privacy: LiveRoomPrivacy.publicRoom,
        language: 'English',
        viewerCount: 1,
        likeCount: 0,
        seats: seats,
        participants: [me],
        seatRequests: const [],
        settings: const LiveRoomSettings(),
        coverImageUrl: _covers[_random.nextInt(_covers.length)],
        activeSpeakerId: me.id,
        currentUserRole: LiveParticipantRole.host,
      );
    }

    final host = LiveParticipant(
      id: 'host_$roomId',
      name: _hostNames[_random.nextInt(_hostNames.length)],
      avatarUrl: _avatars[_random.nextInt(_avatars.length)],
      role: LiveParticipantRole.host,
      isSpeaking: true,
    );
    final cohosts = <LiveParticipant>[];
    for (var i = 1; i < min(3, seatCount); i++) {
      cohosts.add(
        LiveParticipant(
          id: 'user_${roomId}_$i',
          name: 'Guest $i',
          avatarUrl: _avatars[i % _avatars.length],
          role: LiveParticipantRole.cohost,
          isSpeaking: i == 1,
        ),
      );
    }
    final occupied = [host, ...cohosts];
    final updatedSeats = List<LiveSeat>.generate(seatCount, (i) {
      if (i < occupied.length) {
        return LiveSeat(
          index: i,
          status: LiveSeatStatus.occupied,
          participant: occupied[i],
        );
      }
      return LiveSeat(index: i, status: LiveSeatStatus.empty);
    });

    final viewers = 240 + _random.nextInt(1200);
    return LiveRoomSession(
      id: partyId != null ? 'session_party_${partyId}_$roomId' : 'session_$roomId',
      title: partyId != null ? 'Party Room' : _titleFor(seatCount),
      description: 'Welcome to the live room. Chat, send gifts, and take a seat!',
      host: host,
      seatCount: seatCount,
      category: roomId == 'pk' ? LiveRoomCategory.pk : LiveRoomCategory.chatting,
      privacy: LiveRoomPrivacy.publicRoom,
      language: 'English',
      viewerCount: viewers,
      likeCount: 50 + _random.nextInt(500),
      seats: updatedSeats,
      participants: occupied,
      seatRequests: const [],
      settings: const LiveRoomSettings(),
      coverImageUrl: _covers[_random.nextInt(_covers.length)],
      activeSpeakerId: host.id,
      currentUserRole: role,
      meta: LiveSessionMeta(
        startedAt: DateTime.now().subtract(const Duration(minutes: 3)),
        partyId: partyId,
        peakViewerCount: viewers,
        countryCode: 'IN',
        isPromoted: _random.nextBool(),
      ),
    );
  }

  List<LiveSeat> _buildSeats(int count, {bool hostOccupiesFirst = false}) {
    return List.generate(count, (i) {
      if (hostOccupiesFirst && i == 0) {
        return LiveSeat(
          index: i,
          status: LiveSeatStatus.occupied,
          participant: const LiveParticipant(
            id: 'host_me',
            name: 'You',
            avatarUrl: 'https://i.pravatar.cc/150?img=1',
            role: LiveParticipantRole.host,
          ),
        );
      }
      return LiveSeat(index: i, status: LiveSeatStatus.empty);
    });
  }

  static const _hostNames = [
    'Luna Star',
    'DJ Blaze',
    'Mia Live',
    'King Rex',
    'Nova Queen',
  ];

  static String _titleFor(int seatCount) {
    return switch (seatCount) {
      2 => 'PK Battle Live',
      3 => 'Trio Hangout',
      4 => 'Squad Party',
      6 => 'Six Seat Lounge',
      8 => 'Party Room 8',
      16 => 'Mega Room 16',
      32 => 'Arena 32',
      _ => 'Live Room',
    };
  }
}
