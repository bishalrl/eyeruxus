part of 'wallet_bloc.dart';

abstract class WalletEvent extends Equatable {
  const WalletEvent();

  @override
  List<Object?> get props => [];
}

class WalletBalanceRequested extends WalletEvent {
  final int userId;
  final String accessToken;

  const WalletBalanceRequested({
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userId, accessToken];
}
