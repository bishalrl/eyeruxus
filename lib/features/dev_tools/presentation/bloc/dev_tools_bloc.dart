import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/dev_route.dart';
import '../../domain/usecases/get_dev_routes_usecase.dart';

part 'dev_tools_event.dart';
part 'dev_tools_state.dart';

class DevToolsBloc extends Bloc<DevToolsEvent, DevToolsState> {
  final GetDevRoutesUseCase getDevRoutesUseCase;

  DevToolsBloc({required this.getDevRoutesUseCase})
      : super(const DevToolsInitial()) {
    on<DevRoutesRequested>(_onRoutesRequested);
  }

  Future<void> _onRoutesRequested(
    DevRoutesRequested event,
    Emitter<DevToolsState> emit,
  ) async {
    emit(const DevToolsLoading());
    final result = await getDevRoutesUseCase(const NoParams());
    result.fold(
      (failure) => emit(DevToolsFailure(failure.message)),
      (routes) => emit(DevToolsLoaded(routes)),
    );
  }
}
