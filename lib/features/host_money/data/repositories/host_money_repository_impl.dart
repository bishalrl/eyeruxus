import 'package:eye_rex_us/features/host_money/data/datasources/host_money_local_datasource.dart';
import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:eye_rex_us/features/host_money/domain/repositories/host_money_repository.dart';

class HostMoneyRepositoryImpl implements HostMoneyRepository {
  HostMoneyRepositoryImpl(this._local);

  final HostMoneyLocalDataSource _local;

  @override
  Future<HostMoneyDashboard> getDashboard() => _local.getDashboard();

  @override
  Future<HostManagementData> getHostManagement() => _local.getHostManagement();

  @override
  Future<LiveDataMetrics> getLiveData() => _local.getLiveData();

  @override
  Future<List<RankingEntry>> getRanking({required RankingPeriod period}) =>
      _local.getRanking(period);

  @override
  Future<List<RewardMission>> getRewards({required RewardCategory category}) =>
      _local.getRewards(category);

  @override
  Future<List<CoinsTradingOffer>> getCoinsTradingOffers() =>
      _local.getCoinsTradingOffers();

  @override
  Future<InviteHostResult> inviteHosts({
    required List<String> hostIds,
    String? message,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (hostIds.isEmpty) {
      return const InviteHostResult(
        success: false,
        message: 'Enter at least one host ID',
      );
    }
    return InviteHostResult(
      success: true,
      message: 'Invitation sent to ${hostIds.length} host(s)',
    );
  }

  @override
  Future<InviteHostResult> inviteAgent({
    required String agentId,
    String? message,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 400));
    if (agentId.trim().isEmpty) {
      return const InviteHostResult(
        success: false,
        message: 'Enter a valid agent ID',
      );
    }
    return const InviteHostResult(
      success: true,
      message: 'Agent invitation sent successfully',
    );
  }

  @override
  Future<InviteHostResult> purchaseCoinsOffer({
    required String offerId,
    required int coins,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 500));
    return InviteHostResult(
      success: true,
      message: 'Purchased $coins coins',
    );
  }

  @override
  Future<InviteHostResult> claimReward({required String missionId}) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const InviteHostResult(
      success: true,
      message: 'Reward claimed!',
    );
  }
}
