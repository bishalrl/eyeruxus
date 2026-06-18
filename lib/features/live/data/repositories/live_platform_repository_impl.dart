import 'package:eye_rex_us/features/live/data/datasources/live_session_local_datasource.dart';
import 'package:eye_rex_us/features/live/data/services/live_economy_service.dart';
import 'package:eye_rex_us/features/live/data/services/live_realtime_sync_service.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_platform_entities.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/domain/repositories/live_platform_repository.dart';
import 'package:eye_rex_us/features/live/domain/repositories/live_session_repository.dart';

class LivePlatformRepositoryImpl implements LivePlatformRepository {
  LivePlatformRepositoryImpl(
    this._sessions,
    this._local,
    this._economy,
    this._sync,
  );

  final LiveSessionRepository _sessions;
  final LiveSessionLocalDataSource _local;
  final LiveEconomyService _economy;
  final LiveRealtimeSyncService _sync;

  static const _blockedWords = ['spam', 'scam', 'abuse'];

  @override
  Future<LiveDiscoveryPageResult> discoverRoomsPage({
    int page = 1,
    int pageSize = 12,
    String? query,
    LiveRoomCategory? category,
    String? countryCode,
    String? languageCode,
    bool followingOnly = false,
    bool friendsOnly = false,
    bool trendingOnly = false,
    bool promotedOnly = false,
  }) async {
    var rooms = await _sessions.discoverRooms(
      query: query,
      category: category,
      trendingOnly: trendingOnly,
    );
    if (followingOnly) {
      rooms = rooms.where((r) => r.isFollowing).toList();
    }
    if (friendsOnly) {
      rooms = rooms.where((r) => r.isFollowing || r.isNearby).toList();
    }
    if (countryCode != null && countryCode.isNotEmpty) {
      rooms = rooms
          .where((r) => r.country.toLowerCase().contains(countryCode.toLowerCase()))
          .toList();
    }
    if (languageCode != null && languageCode.isNotEmpty) {
      rooms = rooms
          .where((r) => r.language.toLowerCase().contains(languageCode.toLowerCase()))
          .toList();
    }
    if (promotedOnly) {
      rooms = rooms.where((r) => r.isTrending || r.isPopular).toList();
    }

    final start = (page - 1) * pageSize;
    final slice = rooms.skip(start).take(pageSize).toList();
    return LiveDiscoveryPageResult(
      rooms: slice,
      page: page,
      hasMore: start + pageSize < rooms.length,
      totalCount: rooms.length,
    );
  }

  @override
  Future<void> reportLive(LiveReportRequest request) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
  }

  @override
  Future<void> banUser({
    required String userId,
    required LiveBanScope scope,
    String? sessionId,
  }) async {
    if (sessionId == null) return;
    final session = await _local.getSessionById(sessionId);
    if (session == null) return;
    final banned = [...session.meta.bannedUserIds, userId];
    final updated = session.copyWith(
      meta: session.meta.copyWith(bannedUserIds: banned),
    );
    await _persist(sessionId, updated);
  }

  @override
  Future<LiveRoomSession> startPkInvite({
    required String sessionId,
    required String opponentHostName,
  }) async {
    final session = await _requireSession(sessionId);
    final pk = LivePkBattleState(
      phase: PkBattlePhase.countdown,
      opponentHostName: opponentHostName,
      secondsRemaining: 180,
    );
    return _persist(
      sessionId,
      session.copyWith(meta: session.meta.copyWith(pkBattle: () => pk)),
    );
  }

  @override
  Future<LiveRoomSession> tickPkBattle({
    required String sessionId,
    int hostGiftCoins = 0,
    int opponentGiftCoins = 0,
  }) async {
    final session = await _requireSession(sessionId);
    final pk = session.meta.pkBattle;
    if (pk == null || pk.phase == PkBattlePhase.idle) return session;

    final nextSeconds = (pk.secondsRemaining - 1).clamp(0, 999);
    var next = pk.copyWith(
      hostScore: pk.hostScore + hostGiftCoins,
      opponentScore: pk.opponentScore + opponentGiftCoins,
      secondsRemaining: nextSeconds,
      phase: nextSeconds == 0 ? PkBattlePhase.finished : PkBattlePhase.live,
    );
    if (nextSeconds == 0) {
      final winner = next.hostScore >= next.opponentScore ? session.host.id : 'opponent';
      next = next.copyWith(winnerId: () => winner);
    }
    return _persist(
      sessionId,
      session.copyWith(meta: session.meta.copyWith(pkBattle: () => next)),
    );
  }

  @override
  Future<LiveRoomSession> endPkBattle({required String sessionId}) async {
    final session = await _requireSession(sessionId);
    return _persist(
      sessionId,
      session.copyWith(
        meta: session.meta.copyWith(pkBattle: () => const LivePkBattleState()),
      ),
    );
  }

  @override
  Future<LiveSessionRecording?> endSessionWithRecording({
    required String sessionId,
    required int durationSeconds,
  }) async {
    final session = await _requireSession(sessionId);
    final url = 'https://replay.example.com/vod/$sessionId.mp4';
    final updated = session.copyWith(
      isLive: false,
      meta: session.meta.copyWith(recordingUrl: () => url),
    );
    await _persist(sessionId, updated);
    return LiveSessionRecording(
      sessionId: sessionId,
      playbackUrl: url,
      durationSeconds: durationSeconds,
      createdAt: DateTime.now(),
    );
  }

  @override
  Future<LiveRoomSession> applyPartyTheme({
    required String sessionId,
    required String themeId,
  }) async {
    final session = await _requireSession(sessionId);
    return _persist(
      sessionId,
      session.copyWith(meta: session.meta.copyWith(partyThemeId: () => themeId)),
    );
  }

  @override
  Future<bool> validateRoomPassword({
    required String sessionKey,
    required String password,
  }) async {
    final session = await _local.getSessionByRoomId(sessionKey);
    if (session == null) return true;
    final expected = session.meta.roomPassword;
    if (expected == null || expected.isEmpty) return true;
    return expected == password;
  }

  @override
  Future<void> inviteFriendToSeat({
    required String sessionId,
    required String friendName,
    required int seatIndex,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
  }

  @override
  List<LivePlatformLeaderboardEntry> globalHostLeaderboard({String period = 'daily'}) {
    return _economy.globalLeaderboard;
  }

  @override
  List<LivePlatformLeaderboardEntry> roomContributorLeaderboard(
    List<LiveContributorRank> ranks,
  ) {
    final sorted = [...ranks]..sort((a, b) => b.coinsSent.compareTo(a.coinsSent));
    return sorted
        .asMap()
        .entries
        .map(
          (e) => LivePlatformLeaderboardEntry(
            rank: e.key + 1,
            hostName: e.value.userName,
            score: e.value.coinsSent,
            avatarUrl: e.value.avatarUrl,
          ),
        )
        .toList();
  }

  @override
  String? filterChatKeyword(String text) {
    final lower = text.toLowerCase();
    for (final word in _blockedWords) {
      if (lower.contains(word)) {
        return text.replaceAll(RegExp(word, caseSensitive: false), '***');
      }
    }
    return null;
  }

  @override
  String buildLiveDeepLink({required String sessionKey, String? partyId}) {
    final base = 'eyerexus://live/$sessionKey';
    if (partyId != null) return '$base?party=$partyId';
    return base;
  }

  @override
  Future<bool> purchaseStoreProduct({
    required String productId,
    required int coinCost,
    required String productName,
  }) async {
    return _economy.purchaseStoreItem(coinCost: coinCost, productName: productName);
  }

  @override
  Future<bool> rechargeCoins({
    required LiveRechargeProvider provider,
    required int packSize,
  }) {
    return _economy.initiateRecharge(provider: provider, coinPack: packSize);
  }

  Future<LiveRoomSession> _requireSession(String sessionId) async {
    final session = await _local.getSessionById(sessionId);
    if (session == null) throw StateError('Session not found');
    return session;
  }

  Future<LiveRoomSession> _persist(String sessionId, LiveRoomSession session) async {
    final saved = await _local.saveSessionByKey(sessionId, session);
    _sync.publish(sessionId, saved);
    return saved;
  }
}
