import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/vip_tier.dart';
import '../../domain/usecases/get_vip_tiers_usecase.dart';

part 'guardian_vip_event.dart';
part 'guardian_vip_state.dart';

class GuardianVipBloc extends Bloc<GuardianVipEvent, GuardianVipState> {
  final GetVipTiersUseCase getVipTiersUseCase;

  GuardianVipBloc({required this.getVipTiersUseCase})
      : super(const GuardianVipInitial()) {
    on<GuardianVipTiersRequested>(_onTiersRequested);
  }

  Future<void> _onTiersRequested(
    GuardianVipTiersRequested event,
    Emitter<GuardianVipState> emit,
  ) async {
    emit(const GuardianVipLoading());
    final result = await getVipTiersUseCase(const NoParams());
    result.fold(
      (failure) => emit(GuardianVipFailure(failure.message)),
      (tiers) => emit(GuardianVipLoaded(tiers)),
    );
  }
}
