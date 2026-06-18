import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/host_application.dart';
import '../../domain/repositories/agency_repository.dart';
import '../datasources/agency_local_datasource.dart';
import '../datasources/agency_remote_datasource.dart';
import '../models/host_application_model.dart';

class AgencyRepositoryImpl implements AgencyRepository {
  final AgencyRemoteDataSource remoteDataSource;
  final AgencyLocalDataSource localDataSource;

  AgencyRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, HostApplication?>> getLatestApplication({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final json = await remoteDataSource.getLatestApplication(
        userId: userId,
        accessToken: accessToken,
      );
      if (json == null) return const Right(null);
      return Right(HostApplicationModel.fromJson(json));
    } catch (_) {
      final json = await localDataSource.getLatestApplication();
      if (json == null) return const Right(null);
      return Right(HostApplicationModel.fromJson(json));
    }
  }
}
