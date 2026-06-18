import '../../domain/entities/wallet_balance.dart';

class WalletBalanceModel extends WalletBalance {
  const WalletBalanceModel({
    required super.coins,
    required super.points,
    required super.withdrawableAmount,
  });

  factory WalletBalanceModel.fromJson(Map<String, dynamic> json) {
    return WalletBalanceModel(
      coins: (json['coins'] as num?)?.toInt() ?? 0,
      points: (json['points'] as num?)?.toInt() ?? 0,
      withdrawableAmount: (json['withdrawable_amount'] as num?)?.toDouble() ?? 0,
    );
  }
}
