import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:eye_rex_us/features/host_money/domain/usecases/host_money_usecases.dart';
import 'package:eye_rex_us/features/host_money/presentation/bloc/make_money_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeMoneyCubit extends Cubit<MakeMoneyState> {
  MakeMoneyCubit({
    required GetMakeMoneyDashboardUseCase getDashboard,
    required GetHostManagementUseCase getManagement,
    required GetLiveDataUseCase getLiveData,
  })  : _getDashboard = getDashboard,
        _getManagement = getManagement,
        _getLiveData = getLiveData,
        super(const MakeMoneyState());

  final GetMakeMoneyDashboardUseCase _getDashboard;
  final GetHostManagementUseCase _getManagement;
  final GetLiveDataUseCase _getLiveData;

  Future<void> load() async {
    emit(state.copyWith(isLoading: true, error: () => null));
    try {
      final dashboard = await _getDashboard();
      emit(state.copyWith(isLoading: false, dashboard: dashboard));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: () => e.toString()));
    }
  }

  Future<void> selectTab(MakeMoneyTab tab) async {
    if (state.tab == tab) return;
    emit(state.copyWith(tab: tab, isLoading: true, error: () => null));
    try {
      switch (tab) {
        case MakeMoneyTab.makeMoney:
          if (state.dashboard == null) {
            final dashboard = await _getDashboard();
            emit(state.copyWith(isLoading: false, dashboard: dashboard));
          } else {
            emit(state.copyWith(isLoading: false));
          }
        case MakeMoneyTab.manage:
          if (state.management == null) {
            final management = await _getManagement();
            emit(state.copyWith(isLoading: false, management: management));
          } else {
            emit(state.copyWith(isLoading: false));
          }
        case MakeMoneyTab.data:
          if (state.liveData == null) {
            final liveData = await _getLiveData();
            emit(state.copyWith(isLoading: false, liveData: liveData));
          } else {
            emit(state.copyWith(isLoading: false));
          }
      }
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: () => e.toString()));
    }
  }
}
