import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/wallet_balance.dart';
import '../repositories/wallet_repository.dart';

class GetWalletBalanceUseCase
    implements UseCase<WalletBalance, GetWalletBalanceParams> {
  final WalletRepository repository;

  GetWalletBalanceUseCase(this.repository);

  @override
  Future<Either<Failure, WalletBalance>> call(GetWalletBalanceParams params) {
    return repository.getBalance(
      userId: params.userId,
      accessToken: params.accessToken,
    );
  }
}

class GetWalletBalanceParams extends Equatable {
  final int userId;
  final String accessToken;

  const GetWalletBalanceParams({
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userId, accessToken];
}
