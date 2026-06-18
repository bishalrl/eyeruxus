import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/live_room.dart';
import '../../domain/usecases/get_live_rooms_usecase.dart';

part 'live_event.dart';
part 'live_state.dart';

class LiveBloc extends Bloc<LiveEvent, LiveState> {
  final GetLiveRoomsUseCase getLiveRoomsUseCase;

  LiveBloc({required this.getLiveRoomsUseCase}) : super(const LiveInitial()) {
    on<LiveRoomsRequested>(_onRoomsRequested);
  }

  Future<void> _onRoomsRequested(
    LiveRoomsRequested event,
    Emitter<LiveState> emit,
  ) async {
    emit(LiveLoading(scopeKey: event.scopeKey, sessionType: event.sessionType));
    final result = await getLiveRoomsUseCase(
      GetLiveRoomsParams(
        accessToken: event.accessToken,
        sessionType: event.sessionType,
      ),
    );
    result.fold(
      (failure) => emit(LiveFailure(failure.message)),
      (rooms) => emit(
        LiveLoaded(
          rooms,
          scopeKey: event.scopeKey,
          sessionType: event.sessionType,
        ),
      ),
    );
  }
}
