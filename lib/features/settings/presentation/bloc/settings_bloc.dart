import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  final GetSettingsUseCase getSettingsUseCase;
  final UpdateSettingsUseCase updateSettingsUseCase;

  SettingsBloc({
    required this.getSettingsUseCase,
    required this.updateSettingsUseCase,
  }) : super(const SettingsInitial()) {
    on<SettingsLoadRequested>(_onLoad);
    on<SettingsUpdateRequested>(_onUpdate);
  }

  Future<void> _onLoad(
    SettingsLoadRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    final result = await getSettingsUseCase(const NoParams());
    result.fold(
      (failure) => emit(SettingsFailure(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }

  Future<void> _onUpdate(
    SettingsUpdateRequested event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoading());
    final result = await updateSettingsUseCase(
      UpdateSettingsParams(event.settings),
    );
    result.fold(
      (failure) => emit(SettingsFailure(failure.message)),
      (settings) => emit(SettingsLoaded(settings)),
    );
  }
}
