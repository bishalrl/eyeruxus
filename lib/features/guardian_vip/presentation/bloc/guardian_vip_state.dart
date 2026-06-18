part of 'guardian_vip_bloc.dart';

abstract class GuardianVipState extends Equatable {
  const GuardianVipState();

  @override
  List<Object?> get props => [];
}

class GuardianVipInitial extends GuardianVipState {
  const GuardianVipInitial();
}

class GuardianVipLoading extends GuardianVipState {
  const GuardianVipLoading();
}

class GuardianVipLoaded extends GuardianVipState {
  final List<VipTier> tiers;

  const GuardianVipLoaded(this.tiers);

  @override
  List<Object?> get props => [tiers];
}

class GuardianVipFailure extends GuardianVipState {
  final String message;

  const GuardianVipFailure(this.message);

  @override
  List<Object?> get props => [message];
}
