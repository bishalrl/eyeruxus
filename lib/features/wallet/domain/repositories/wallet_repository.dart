import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/wallet_balance.dart';

abstract class WalletRepository {
  Future<Either<Failure, WalletBalance>> getBalance({
    required int userId,
    required String accessToken,
  });
}
