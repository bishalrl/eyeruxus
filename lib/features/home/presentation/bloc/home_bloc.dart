import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/usecases/get_home_feed_usecase.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc({required GetHomeFeedUseCase getHomeFeedUseCase})
      : _getHomeFeedUseCase = getHomeFeedUseCase,
        super(const HomeInitial()) {
    on<LoadHomeDataEvent>(_onLoad);
    on<ChangeHomeFeedTabEvent>(_onTabChanged);
  }

  final GetHomeFeedUseCase _getHomeFeedUseCase;

  Future<void> _onLoad(
    LoadHomeDataEvent event,
    Emitter<HomeState> emit,
  ) async {
    await _fetchFeed(event.tab, emit);
  }

  Future<void> _onTabChanged(
    ChangeHomeFeedTabEvent event,
    Emitter<HomeState> emit,
  ) async {
    if (state is HomeLoadedState &&
        (state as HomeLoadedState).selectedTab == event.tab) {
      return;
    }
    await _fetchFeed(event.tab, emit);
  }

  Future<void> _fetchFeed(
    HomeFeedTab tab,
    Emitter<HomeState> emit,
  ) async {
    emit(HomeLoadingState(tab: tab));
    final result = await _getHomeFeedUseCase(GetHomeFeedParams(tab: tab));
    result.fold(
      (failure) => emit(HomeErrorState(errorMessage: failure.message)),
      (feed) => emit(
        HomeLoadedState(
          stories: feed.stories,
          rooms: feed.rooms,
          selectedTab: tab,
        ),
      ),
    );
  }
}
