import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/wallet_balance.dart';
import '../../domain/usecases/get_wallet_balance_usecase.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final GetWalletBalanceUseCase getWalletBalanceUseCase;

  WalletBloc({required this.getWalletBalanceUseCase}) : super(const WalletInitial()) {
    on<WalletBalanceRequested>(_onBalanceRequested);
  }

  Future<void> _onBalanceRequested(
    WalletBalanceRequested event,
    Emitter<WalletState> emit,
  ) async {
    emit(const WalletLoading());
    final result = await getWalletBalanceUseCase(
      GetWalletBalanceParams(
        userId: event.userId,
        accessToken: event.accessToken,
      ),
    );
    result.fold(
      (failure) => emit(WalletFailure(failure.message)),
      (balance) => emit(WalletLoaded(balance)),
    );
  }
}
