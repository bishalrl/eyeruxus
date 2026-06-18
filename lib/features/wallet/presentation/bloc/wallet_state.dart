part of 'wallet_bloc.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object?> get props => [];
}

class WalletInitial extends WalletState {
  const WalletInitial();
}

class WalletLoading extends WalletState {
  const WalletLoading();
}

class WalletLoaded extends WalletState {
  final WalletBalance balance;

  const WalletLoaded(this.balance);

  @override
  List<Object?> get props => [balance];
}

class WalletFailure extends WalletState {
  final String message;

  const WalletFailure(this.message);

  @override
  List<Object?> get props => [message];
}
