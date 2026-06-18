import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dev_route.dart';
import '../repositories/dev_tools_repository.dart';

class GetDevRoutesUseCase implements UseCase<List<DevRoute>, NoParams> {
  final DevToolsRepository repository;

  GetDevRoutesUseCase(this.repository);

  @override
  Future<Either<Failure, List<DevRoute>>> call(NoParams params) {
    return repository.getRoutes();
  }
}
