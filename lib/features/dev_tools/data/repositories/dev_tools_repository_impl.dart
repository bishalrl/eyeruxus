import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/dev_route.dart';
import '../../domain/repositories/dev_tools_repository.dart';
import '../datasources/dev_tools_local_datasource.dart';
import '../models/dev_route_model.dart';

class DevToolsRepositoryImpl implements DevToolsRepository {
  final DevToolsLocalDataSource localDataSource;

  DevToolsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<DevRoute>>> getRoutes() async {
    try {
      final rows = await localDataSource.getRoutes();
      return Right(
        rows
            .map(
              (row) => DevRouteModel.fromConfig(
                labelKey: row['label_key'] as String,
                index: row['index'] as int,
              ),
            )
            .toList(),
      );
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
