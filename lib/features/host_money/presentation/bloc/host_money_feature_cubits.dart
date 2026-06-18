import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:eye_rex_us/features/host_money/domain/usecases/host_money_usecases.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RankingState extends Equatable {
  const RankingState({
    this.period = RankingPeriod.weekly,
    this.isLoading = false,
    this.entries = const [],
    this.error,
  });

  final RankingPeriod period;
  final bool isLoading;
  final List<RankingEntry> entries;
  final String? error;

  @override
  List<Object?> get props => [period, isLoading, entries, error];
}

class RankingCubit extends Cubit<RankingState> {
  RankingCubit(this._getRanking) : super(const RankingState());

  final GetRankingUseCase _getRanking;

  Future<void> load({RankingPeriod? period}) async {
    final p = period ?? state.period;
    emit(RankingState(period: p, isLoading: true));
    try {
      final entries = await _getRanking(p);
      emit(RankingState(period: p, entries: entries));
    } catch (e) {
      emit(RankingState(period: p, error: e.toString()));
    }
  }
}

class RewardsState extends Equatable {
  const RewardsState({
    this.category = RewardCategory.pkMission,
    this.isLoading = false,
    this.missions = const [],
    this.message,
    this.error,
  });

  final RewardCategory category;
  final bool isLoading;
  final List<RewardMission> missions;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [category, isLoading, missions, message, error];
}

class RewardsCubit extends Cubit<RewardsState> {
  RewardsCubit({
    required GetHostRewardsUseCase getRewards,
    required ClaimHostRewardUseCase claimReward,
  })  : _getRewards = getRewards,
        _claimReward = claimReward,
        super(const RewardsState());

  final GetHostRewardsUseCase _getRewards;
  final ClaimHostRewardUseCase _claimReward;

  Future<void> load({RewardCategory? category}) async {
    final c = category ?? state.category;
    emit(RewardsState(category: c, isLoading: true));
    try {
      final missions = await _getRewards(c);
      emit(RewardsState(category: c, missions: missions));
    } catch (e) {
      emit(RewardsState(category: c, error: e.toString()));
    }
  }

  Future<void> claim(String missionId) async {
    emit(RewardsState(
      category: state.category,
      missions: state.missions,
      isLoading: true,
    ));
    final result = await _claimReward(missionId);
    await load();
    emit(RewardsState(
      category: state.category,
      missions: state.missions,
      message: result.message,
    ));
  }
}

class CoinsTradingState extends Equatable {
  const CoinsTradingState({
    this.isLoading = false,
    this.offers = const [],
    this.message,
    this.error,
  });

  final bool isLoading;
  final List<CoinsTradingOffer> offers;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isLoading, offers, message, error];
}

class CoinsTradingCubit extends Cubit<CoinsTradingState> {
  CoinsTradingCubit({
    required GetCoinsTradingUseCase getOffers,
    required PurchaseCoinsTradeUseCase purchase,
  })  : _getOffers = getOffers,
        _purchase = purchase,
        super(const CoinsTradingState());

  final GetCoinsTradingUseCase _getOffers;
  final PurchaseCoinsTradeUseCase _purchase;

  Future<void> load() async {
    emit(const CoinsTradingState(isLoading: true));
    try {
      final offers = await _getOffers();
      emit(CoinsTradingState(offers: offers));
    } catch (e) {
      emit(CoinsTradingState(error: e.toString()));
    }
  }

  Future<void> buy(CoinsTradingOffer offer) async {
    emit(CoinsTradingState(offers: state.offers, isLoading: true));
    final result = await _purchase(offerId: offer.id, coins: offer.coins);
    emit(CoinsTradingState(offers: state.offers, message: result.message));
  }
}

class InviteFormState extends Equatable {
  const InviteFormState({
    this.isSubmitting = false,
    this.message,
    this.error,
  });

  final bool isSubmitting;
  final String? message;
  final String? error;

  @override
  List<Object?> get props => [isSubmitting, message, error];
}

class AddHostCubit extends Cubit<InviteFormState> {
  AddHostCubit(this._inviteHost) : super(const InviteFormState());

  final InviteHostUseCase _inviteHost;

  Future<void> submit({
    required String hostIdsText,
    String? message,
  }) async {
    emit(const InviteFormState(isSubmitting: true));
    final ids = hostIdsText
        .split(RegExp(r'[,\s]+'))
        .map((e) => e.trim())
        .where((e) => e.isNotEmpty)
        .toList();
    final result = await _inviteHost(hostIds: ids, message: message);
    emit(InviteFormState(
      isSubmitting: false,
      message: result.success ? result.message : null,
      error: result.success ? null : result.message,
    ));
  }
}

class InviteAgentCubit extends Cubit<InviteFormState> {
  InviteAgentCubit(this._inviteAgent) : super(const InviteFormState());

  final InviteAgentUseCase _inviteAgent;

  Future<void> submit({
    required String agentId,
    String? message,
  }) async {
    emit(const InviteFormState(isSubmitting: true));
    final result = await _inviteAgent(agentId: agentId, message: message);
    emit(InviteFormState(
      isSubmitting: false,
      message: result.success ? result.message : null,
      error: result.success ? null : result.message,
    ));
  }
}
