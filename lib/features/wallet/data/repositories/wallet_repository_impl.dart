import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/wallet_balance.dart';
import '../../domain/repositories/wallet_repository.dart';
import '../datasources/wallet_local_datasource.dart';
import '../datasources/wallet_remote_datasource.dart';
import '../models/wallet_balance_model.dart';

class WalletRepositoryImpl implements WalletRepository {
  final WalletRemoteDataSource remoteDataSource;
  final WalletLocalDataSource localDataSource;

  WalletRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, WalletBalance>> getBalance({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final json = await remoteDataSource.getBalance(
        userId: userId,
        accessToken: accessToken,
      );
      return Right(WalletBalanceModel.fromJson(json));
    } catch (_) {
      final json = await localDataSource.getBalance();
      return Right(WalletBalanceModel.fromJson(json));
    }
  }
}
