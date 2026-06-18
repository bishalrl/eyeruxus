import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/host_application.dart';
import '../repositories/agency_repository.dart';

class GetHostApplicationUseCase
    implements UseCase<HostApplication?, GetHostApplicationParams> {
  final AgencyRepository repository;

  GetHostApplicationUseCase(this.repository);

  @override
  Future<Either<Failure, HostApplication?>> call(
    GetHostApplicationParams params,
  ) {
    return repository.getLatestApplication(
      userId: params.userId,
      accessToken: params.accessToken,
    );
  }
}

class GetHostApplicationParams extends Equatable {
  final int userId;
  final String accessToken;

  const GetHostApplicationParams({
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userId, accessToken];
}
