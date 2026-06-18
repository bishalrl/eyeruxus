import 'package:equatable/equatable.dart';

class WalletBalance extends Equatable {
  final int coins;
  final int points;
  final double withdrawableAmount;

  const WalletBalance({
    required this.coins,
    required this.points,
    required this.withdrawableAmount,
  });

  @override
  List<Object?> get props => [coins, points, withdrawableAmount];
}
