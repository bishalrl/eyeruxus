import 'package:eye_rex_us/features/live/domain/entities/live_platform_entities.dart';

/// In-app coin/diamond ledger for gifts and store (swap for wallet API later).
class LiveEconomyService {
  LiveEconomyService();

  int _coins = 125000;
  int _diamonds = 4200;
  int _points = 13294;
  final _giftCombos = <String, LiveGiftComboState>{};
  final _globalLeaderboard = <LivePlatformLeaderboardEntry>[];

  int get coins => _coins;
  int get diamonds => _diamonds;
  int get points => _points;
  List<LivePlatformLeaderboardEntry> get globalLeaderboard => _globalLeaderboard;

  /// Returns false if insufficient balance.
  bool spendCoins(int amount) {
    if (amount > _coins) return false;
    _coins -= amount;
    return true;
  }

  void creditHostDiamonds(int amount) {
    _diamonds += amount;
  }

  bool purchaseStoreItem({required int coinCost, required String productName}) {
    if (!spendCoins(coinCost)) return false;
    return true;
  }

  LiveGiftComboState registerGiftCombo(String giftId) {
    final current = _giftCombos[giftId] ?? const LiveGiftComboState();
    final next = LiveGiftComboState(
      giftId: giftId,
      count: current.count + 1,
      multiplier: current.count >= 4 ? 2 : 1,
    );
    _giftCombos[giftId] = next;
    return next;
  }

  void recordGiftToLeaderboard({
    required String hostName,
    required int coinValue,
  }) {
    final existing = _globalLeaderboard.indexWhere((e) => e.hostName == hostName);
    if (existing >= 0) {
      final e = _globalLeaderboard[existing];
      _globalLeaderboard[existing] = LivePlatformLeaderboardEntry(
        rank: e.rank,
        hostName: e.hostName,
        score: e.score + coinValue,
        avatarUrl: e.avatarUrl,
      );
    } else {
      _globalLeaderboard.add(
        LivePlatformLeaderboardEntry(
          rank: _globalLeaderboard.length + 1,
          hostName: hostName,
          score: coinValue,
        ),
      );
    }
    _globalLeaderboard.sort((a, b) => b.score.compareTo(a.score));
    for (var i = 0; i < _globalLeaderboard.length; i++) {
      final e = _globalLeaderboard[i];
      _globalLeaderboard[i] = LivePlatformLeaderboardEntry(
        rank: i + 1,
        hostName: e.hostName,
        score: e.score,
        avatarUrl: e.avatarUrl,
      );
    }
  }

  Future<bool> initiateRecharge({
    required LiveRechargeProvider provider,
    required int coinPack,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    _coins += coinPack;
    return true;
  }
}
