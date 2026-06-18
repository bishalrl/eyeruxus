import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/dev_route.dart';

abstract class DevToolsRepository {
  Future<Either<Failure, List<DevRoute>>> getRoutes();
}
