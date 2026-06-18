import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/vip_tier.dart';
import '../repositories/guardian_vip_repository.dart';

class GetVipTiersUseCase implements UseCase<List<VipTier>, NoParams> {
  final GuardianVipRepository repository;

  GetVipTiersUseCase(this.repository);

  @override
  Future<Either<Failure, List<VipTier>>> call(NoParams params) {
    return repository.getVipTiers();
  }
}
