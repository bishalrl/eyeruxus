import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/host_application.dart';
import '../../domain/usecases/get_host_application_usecase.dart';

part 'agency_event.dart';
part 'agency_state.dart';

class AgencyBloc extends Bloc<AgencyEvent, AgencyState> {
  final GetHostApplicationUseCase getHostApplicationUseCase;

  AgencyBloc({required this.getHostApplicationUseCase})
      : super(const AgencyInitial()) {
    on<AgencyApplicationRequested>(_onApplicationRequested);
  }

  Future<void> _onApplicationRequested(
    AgencyApplicationRequested event,
    Emitter<AgencyState> emit,
  ) async {
    emit(const AgencyLoading());
    final result = await getHostApplicationUseCase(
      GetHostApplicationParams(
        userId: event.userId,
        accessToken: event.accessToken,
      ),
    );
    result.fold(
      (failure) => emit(AgencyFailure(failure.message)),
      (application) => emit(AgencyLoaded(application)),
    );
  }
}
