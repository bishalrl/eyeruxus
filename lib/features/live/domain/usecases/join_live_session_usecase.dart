import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/live_session_descriptor.dart';
import '../repositories/live_repository.dart';

class JoinLiveSessionParams extends Equatable {
  const JoinLiveSessionParams({
    required this.accessToken,
    required this.sessionId,
    required this.userId,
  });

  final String accessToken;
  final String sessionId;
  final int userId;

  @override
  List<Object?> get props => [accessToken, sessionId, userId];
}

class JoinLiveSessionUseCase
    implements UseCase<LiveSessionDescriptor, JoinLiveSessionParams> {
  const JoinLiveSessionUseCase(this.repository);

  final LiveRepository repository;

  @override
  Future<Either<Failure, LiveSessionDescriptor>> call(
    JoinLiveSessionParams params,
  ) {
    return repository.joinSession(
      accessToken: params.accessToken,
      sessionId: params.sessionId,
      userId: params.userId,
    );
  }
}
