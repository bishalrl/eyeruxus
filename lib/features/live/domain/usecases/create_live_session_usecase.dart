import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/live_session_descriptor.dart';
import '../entities/live_session_type.dart';
import '../repositories/live_repository.dart';

class CreateLiveSessionParams extends Equatable {
  const CreateLiveSessionParams({
    required this.accessToken,
    required this.hostUserId,
    required this.type,
    this.roomId,
    this.seatCount,
    this.category,
    this.isPrivate = false,
  });

  final String accessToken;
  final int hostUserId;
  final LiveSessionType type;
  final String? roomId;
  final int? seatCount;
  final String? category;
  final bool isPrivate;

  @override
  List<Object?> get props =>
      [accessToken, hostUserId, type, roomId, seatCount, category, isPrivate];
}

class CreateLiveSessionUseCase
    implements UseCase<LiveSessionDescriptor, CreateLiveSessionParams> {
  const CreateLiveSessionUseCase(this.repository);

  final LiveRepository repository;

  @override
  Future<Either<Failure, LiveSessionDescriptor>> call(
    CreateLiveSessionParams params,
  ) {
    return repository.createSession(
      accessToken: params.accessToken,
      hostUserId: params.hostUserId,
      type: params.type,
      roomId: params.roomId,
      seatCount: params.seatCount,
      category: params.category,
      isPrivate: params.isPrivate,
    );
  }
}
