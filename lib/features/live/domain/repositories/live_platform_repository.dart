import 'package:eye_rex_us/features/live/domain/entities/live_platform_entities.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';

abstract class LivePlatformRepository {
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
  });

  Future<void> reportLive(LiveReportRequest request);

  Future<void> banUser({
    required String userId,
    required LiveBanScope scope,
    String? sessionId,
  });

  Future<LiveRoomSession> startPkInvite({
    required String sessionId,
    required String opponentHostName,
  });

  Future<LiveRoomSession> tickPkBattle({
    required String sessionId,
    int hostGiftCoins = 0,
    int opponentGiftCoins = 0,
  });

  Future<LiveRoomSession> endPkBattle({required String sessionId});

  Future<LiveSessionRecording?> endSessionWithRecording({
    required String sessionId,
    required int durationSeconds,
  });

  Future<LiveRoomSession> applyPartyTheme({
    required String sessionId,
    required String themeId,
  });

  Future<bool> validateRoomPassword({
    required String sessionKey,
    required String password,
  });

  Future<void> inviteFriendToSeat({
    required String sessionId,
    required String friendName,
    required int seatIndex,
  });

  List<LivePlatformLeaderboardEntry> globalHostLeaderboard({String period = 'daily'});

  List<LivePlatformLeaderboardEntry> roomContributorLeaderboard(
    List<LiveContributorRank> ranks,
  );

  String? filterChatKeyword(String text);

  String buildLiveDeepLink({required String sessionKey, String? partyId});

  Future<bool> purchaseStoreProduct({
    required String productId,
    required int coinCost,
    required String productName,
  });

  Future<bool> rechargeCoins({
    required LiveRechargeProvider provider,
    required int packSize,
  });
}
