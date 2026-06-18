import 'package:equatable/equatable.dart';

import 'live_session_entities.dart';

enum PkBattlePhase { idle, inviting, countdown, live, finished }

enum LiveReportReason { harassment, spam, nudity, scam, other }

enum LiveBanScope { room, global, device }

enum LiveRechargeProvider { googlePlay, razorpay, applePay }

/// Extended session metadata — sync, economy, PK, party, compliance.
class LiveSessionMeta extends Equatable {
  const LiveSessionMeta({
    this.startedAt,
    this.peakViewerCount = 0,
    this.voiceOnly = false,
    this.partyId,
    this.partyThemeId,
    this.recordingUrl,
    this.roomPassword,
    this.pkBattle,
    this.countryCode = 'IN',
    this.languageCode = 'en',
    this.isPromoted = false,
    this.syncVersion = 0,
    this.hostDiamonds = 0,
    this.reconnectGeneration = 0,
    this.connectionDegraded = false,
    this.bannedUserIds = const [],
    this.keywordFilterEnabled = true,
    this.contributorRanks = const [],
    this.achievementBadges = const [],
    this.fanClubTier,
    this.guardianLevel = 0,
  });

  final DateTime? startedAt;
  final int peakViewerCount;
  final bool voiceOnly;
  final String? partyId;
  final String? partyThemeId;
  final String? recordingUrl;
  final String? roomPassword;
  final LivePkBattleState? pkBattle;
  final String countryCode;
  final String languageCode;
  final bool isPromoted;
  final int syncVersion;
  final int hostDiamonds;
  final int reconnectGeneration;
  final bool connectionDegraded;
  final List<String> bannedUserIds;
  final bool keywordFilterEnabled;
  final List<LiveContributorRank> contributorRanks;
  final List<String> achievementBadges;
  final String? fanClubTier;
  final int guardianLevel;

  LiveSessionMeta copyWith({
    DateTime? startedAt,
    int? peakViewerCount,
    bool? voiceOnly,
    String? Function()? partyId,
    String? Function()? partyThemeId,
    String? Function()? recordingUrl,
    String? Function()? roomPassword,
    LivePkBattleState? Function()? pkBattle,
    String? countryCode,
    String? languageCode,
    bool? isPromoted,
    int? syncVersion,
    int? hostDiamonds,
    int? reconnectGeneration,
    bool? connectionDegraded,
    List<String>? bannedUserIds,
    bool? keywordFilterEnabled,
    List<LiveContributorRank>? contributorRanks,
    List<String>? achievementBadges,
    String? Function()? fanClubTier,
    int? guardianLevel,
  }) {
    return LiveSessionMeta(
      startedAt: startedAt ?? this.startedAt,
      peakViewerCount: peakViewerCount ?? this.peakViewerCount,
      voiceOnly: voiceOnly ?? this.voiceOnly,
      partyId: partyId != null ? partyId() : this.partyId,
      partyThemeId: partyThemeId != null ? partyThemeId() : this.partyThemeId,
      recordingUrl: recordingUrl != null ? recordingUrl() : this.recordingUrl,
      roomPassword: roomPassword != null ? roomPassword() : this.roomPassword,
      pkBattle: pkBattle != null ? pkBattle() : this.pkBattle,
      countryCode: countryCode ?? this.countryCode,
      languageCode: languageCode ?? this.languageCode,
      isPromoted: isPromoted ?? this.isPromoted,
      syncVersion: syncVersion ?? this.syncVersion,
      hostDiamonds: hostDiamonds ?? this.hostDiamonds,
      reconnectGeneration: reconnectGeneration ?? this.reconnectGeneration,
      connectionDegraded: connectionDegraded ?? this.connectionDegraded,
      bannedUserIds: bannedUserIds ?? this.bannedUserIds,
      keywordFilterEnabled: keywordFilterEnabled ?? this.keywordFilterEnabled,
      contributorRanks: contributorRanks ?? this.contributorRanks,
      achievementBadges: achievementBadges ?? this.achievementBadges,
      fanClubTier: fanClubTier != null ? fanClubTier() : this.fanClubTier,
      guardianLevel: guardianLevel ?? this.guardianLevel,
    );
  }

  @override
  List<Object?> get props => [syncVersion, peakViewerCount, pkBattle];
}

class LivePkBattleState extends Equatable {
  const LivePkBattleState({
    this.phase = PkBattlePhase.idle,
    this.opponentHostName = '',
    this.opponentSessionId,
    this.hostScore = 0,
    this.opponentScore = 0,
    this.secondsRemaining = 180,
    this.winnerId,
  });

  final PkBattlePhase phase;
  final String opponentHostName;
  final String? opponentSessionId;
  final int hostScore;
  final int opponentScore;
  final int secondsRemaining;
  final String? winnerId;

  LivePkBattleState copyWith({
    PkBattlePhase? phase,
    String? opponentHostName,
    String? Function()? opponentSessionId,
    int? hostScore,
    int? opponentScore,
    int? secondsRemaining,
    String? Function()? winnerId,
  }) {
    return LivePkBattleState(
      phase: phase ?? this.phase,
      opponentHostName: opponentHostName ?? this.opponentHostName,
      opponentSessionId:
          opponentSessionId != null ? opponentSessionId() : this.opponentSessionId,
      hostScore: hostScore ?? this.hostScore,
      opponentScore: opponentScore ?? this.opponentScore,
      secondsRemaining: secondsRemaining ?? this.secondsRemaining,
      winnerId: winnerId != null ? winnerId() : this.winnerId,
    );
  }

  @override
  List<Object?> get props => [phase, hostScore, opponentScore, secondsRemaining];
}

class LiveContributorRank extends Equatable {
  const LiveContributorRank({
    required this.userId,
    required this.userName,
    required this.coinsSent,
    this.avatarUrl = '',
  });

  final String userId;
  final String userName;
  final int coinsSent;
  final String avatarUrl;

  @override
  List<Object?> get props => [userId, coinsSent];
}

class LiveGiftComboState extends Equatable {
  const LiveGiftComboState({
    this.giftId = '',
    this.count = 0,
    this.multiplier = 1,
  });

  final String giftId;
  final int count;
  final int multiplier;

  @override
  List<Object?> get props => [giftId, count];
}

class LiveDiscoveryPageResult extends Equatable {
  const LiveDiscoveryPageResult({
    required this.rooms,
    required this.page,
    required this.hasMore,
    required this.totalCount,
  });

  final List<LiveRoomListing> rooms;
  final int page;
  final bool hasMore;
  final int totalCount;

  @override
  List<Object?> get props => [page, hasMore, totalCount];
}

class LivePlatformLeaderboardEntry extends Equatable {
  const LivePlatformLeaderboardEntry({
    required this.rank,
    required this.hostName,
    required this.score,
    this.avatarUrl = '',
    this.period = 'daily',
  });

  final int rank;
  final String hostName;
  final int score;
  final String avatarUrl;
  final String period;

  @override
  List<Object?> get props => [rank, hostName, score];
}

class LiveReportRequest extends Equatable {
  const LiveReportRequest({
    required this.sessionId,
    required this.reportedUserId,
    required this.reason,
    this.details = '',
  });

  final String sessionId;
  final String reportedUserId;
  final LiveReportReason reason;
  final String details;

  @override
  List<Object?> get props => [sessionId, reportedUserId, reason];
}

class LiveSessionRecording extends Equatable {
  const LiveSessionRecording({
    required this.sessionId,
    required this.playbackUrl,
    required this.durationSeconds,
    required this.createdAt,
  });

  final String sessionId;
  final String playbackUrl;
  final int durationSeconds;
  final DateTime createdAt;

  @override
  List<Object?> get props => [sessionId, playbackUrl];
}
