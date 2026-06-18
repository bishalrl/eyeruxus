import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/host_application.dart';

abstract class AgencyRepository {
  Future<Either<Failure, HostApplication?>> getLatestApplication({
    required int userId,
    required String accessToken,
  });
}
