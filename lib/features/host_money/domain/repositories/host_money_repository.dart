import '../entities/host_money_entities.dart';

abstract class HostMoneyRepository {
  Future<HostMoneyDashboard> getDashboard();
  Future<HostManagementData> getHostManagement();
  Future<LiveDataMetrics> getLiveData();
  Future<List<RankingEntry>> getRanking({required RankingPeriod period});
  Future<List<RewardMission>> getRewards({required RewardCategory category});
  Future<List<CoinsTradingOffer>> getCoinsTradingOffers();
  Future<InviteHostResult> inviteHosts({
    required List<String> hostIds,
    String? message,
  });
  Future<InviteHostResult> inviteAgent({
    required String agentId,
    String? message,
  });
  Future<InviteHostResult> purchaseCoinsOffer({
    required String offerId,
    required int coins,
  });
  Future<InviteHostResult> claimReward({required String missionId});
}
