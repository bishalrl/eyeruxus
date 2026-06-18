import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';

class MakeMoneyState extends Equatable {
  const MakeMoneyState({
    this.tab = MakeMoneyTab.makeMoney,
    this.isLoading = false,
    this.dashboard,
    this.management,
    this.liveData,
    this.error,
  });

  final MakeMoneyTab tab;
  final bool isLoading;
  final HostMoneyDashboard? dashboard;
  final HostManagementData? management;
  final LiveDataMetrics? liveData;
  final String? error;

  MakeMoneyState copyWith({
    MakeMoneyTab? tab,
    bool? isLoading,
    HostMoneyDashboard? dashboard,
    HostManagementData? management,
    LiveDataMetrics? liveData,
    String? Function()? error,
  }) {
    return MakeMoneyState(
      tab: tab ?? this.tab,
      isLoading: isLoading ?? this.isLoading,
      dashboard: dashboard ?? this.dashboard,
      management: management ?? this.management,
      liveData: liveData ?? this.liveData,
      error: error != null ? error() : this.error,
    );
  }

  @override
  List<Object?> get props => [tab, isLoading, dashboard, management, liveData, error];
}
