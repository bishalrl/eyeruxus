import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/vip_tier.dart';
import '../../domain/repositories/guardian_vip_repository.dart';
import '../datasources/guardian_vip_local_datasource.dart';
import '../models/vip_tier_model.dart';

class GuardianVipRepositoryImpl implements GuardianVipRepository {
  final GuardianVipLocalDataSource localDataSource;

  GuardianVipRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<VipTier>>> getVipTiers() async {
    try {
      final rows = await localDataSource.getVipTiers();
      return Right(rows.map(VipTierModel.fromJson).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
