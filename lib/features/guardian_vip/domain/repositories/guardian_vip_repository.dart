import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/vip_tier.dart';

abstract class GuardianVipRepository {
  Future<Either<Failure, List<VipTier>>> getVipTiers();
}
