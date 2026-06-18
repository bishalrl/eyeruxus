import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:eye_rex_us/features/host_money/domain/repositories/host_money_repository.dart';

class GetMakeMoneyDashboardUseCase {
  const GetMakeMoneyDashboardUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<HostMoneyDashboard> call() => _repository.getDashboard();
}

class GetHostManagementUseCase {
  const GetHostManagementUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<HostManagementData> call() => _repository.getHostManagement();
}

class GetLiveDataUseCase {
  const GetLiveDataUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<LiveDataMetrics> call() => _repository.getLiveData();
}

class GetRankingUseCase {
  const GetRankingUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<List<RankingEntry>> call(RankingPeriod period) =>
      _repository.getRanking(period: period);
}

class GetHostRewardsUseCase {
  const GetHostRewardsUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<List<RewardMission>> call(RewardCategory category) =>
      _repository.getRewards(category: category);
}

class GetCoinsTradingUseCase {
  const GetCoinsTradingUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<List<CoinsTradingOffer>> call() => _repository.getCoinsTradingOffers();
}

class InviteHostUseCase {
  const InviteHostUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<InviteHostResult> call({
    required List<String> hostIds,
    String? message,
  }) =>
      _repository.inviteHosts(hostIds: hostIds, message: message);
}

class InviteAgentUseCase {
  const InviteAgentUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<InviteHostResult> call({
    required String agentId,
    String? message,
  }) =>
      _repository.inviteAgent(agentId: agentId, message: message);
}

class PurchaseCoinsTradeUseCase {
  const PurchaseCoinsTradeUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<InviteHostResult> call({
    required String offerId,
    required int coins,
  }) =>
      _repository.purchaseCoinsOffer(offerId: offerId, coins: coins);
}

class ClaimHostRewardUseCase {
  const ClaimHostRewardUseCase(this._repository);

  final HostMoneyRepository _repository;

  Future<InviteHostResult> call(String missionId) =>
      _repository.claimReward(missionId: missionId);
}
