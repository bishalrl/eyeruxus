import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/live_room.dart';
import '../repositories/live_repository.dart';

class GetLiveRoomsUseCase implements UseCase<List<LiveRoom>, GetLiveRoomsParams> {
  final LiveRepository repository;

  GetLiveRoomsUseCase(this.repository);

  @override
  Future<Either<Failure, List<LiveRoom>>> call(GetLiveRoomsParams params) {
    return repository.getRooms(
      accessToken: params.accessToken,
      sessionType: params.sessionType,
    );
  }
}

class GetLiveRoomsParams extends Equatable {
  final String accessToken;
  final String? sessionType;

  const GetLiveRoomsParams({required this.accessToken, this.sessionType});

  @override
  List<Object?> get props => [accessToken, sessionType];
}
