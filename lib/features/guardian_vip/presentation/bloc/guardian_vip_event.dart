part of 'guardian_vip_bloc.dart';

abstract class GuardianVipEvent extends Equatable {
  const GuardianVipEvent();

  @override
  List<Object?> get props => [];
}

class GuardianVipTiersRequested extends GuardianVipEvent {
  const GuardianVipTiersRequested();
}
