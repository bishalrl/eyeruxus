import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/usecases/get_party_feed_usecase.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/party_event.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/party_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PartyBloc extends Bloc<PartyEvent, PartyState> {
  PartyBloc({required GetPartyFeedUseCase getPartyFeedUseCase})
      : _getPartyFeedUseCase = getPartyFeedUseCase,
        super(const PartyInitial()) {
    on<PartyFeedRequested>(_onFeedRequested);
    on<PartyTabChanged>(_onTabChanged);
  }

  final GetPartyFeedUseCase _getPartyFeedUseCase;

  Future<void> _onFeedRequested(
    PartyFeedRequested event,
    Emitter<PartyState> emit,
  ) async {
    final tab = event.tab ??
        switch (state) {
          PartyLoaded(:final tab) => tab,
          PartyLoading(:final tab) => tab,
          PartyError(:final tab) => tab,
          _ => PartyFeedTab.hot,
        };
    await _load(tab, emit);
  }

  Future<void> _onTabChanged(
    PartyTabChanged event,
    Emitter<PartyState> emit,
  ) async {
    if (state is PartyLoaded && (state as PartyLoaded).tab == event.tab) {
      return;
    }
    await _load(event.tab, emit);
  }

  Future<void> _load(PartyFeedTab tab, Emitter<PartyState> emit) async {
    emit(PartyLoading(tab: tab));
    final result = await _getPartyFeedUseCase(GetPartyFeedParams(tab: tab));
    result.fold(
      (failure) => emit(PartyError(message: failure.message, tab: tab)),
      (feed) => emit(
        PartyLoaded(
          tab: tab,
          rooms: feed.rooms,
          friendsInParty: feed.friendsInParty,
        ),
      ),
    );
  }
}
