import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/live_room.dart';
import '../../domain/entities/live_session_descriptor.dart';
import '../../domain/entities/live_session_type.dart';
import '../../domain/repositories/live_repository.dart';
import '../datasources/live_local_datasource.dart';
import '../datasources/live_remote_datasource.dart';
import '../models/live_room_model.dart';

class LiveRepositoryImpl implements LiveRepository {
  final LiveRemoteDataSource remoteDataSource;
  final LiveLocalDataSource localDataSource;

  LiveRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, List<LiveRoom>>> getRooms({
    required String accessToken,
    String? sessionType,
  }) async {
    try {
      final rows = await remoteDataSource.getRooms(
        accessToken: accessToken,
        sessionType: sessionType,
      );
      return Right(rows.map(LiveRoomModel.fromJson).toList());
    } catch (_) {
      final rows = await localDataSource.getRooms(sessionType: sessionType);
      return Right(rows.map(LiveRoomModel.fromJson).toList());
    }
  }

  @override
  Future<Either<Failure, LiveSessionDescriptor>> createSession({
    required String accessToken,
    required int hostUserId,
    required LiveSessionType type,
    String? roomId,
    int? seatCount,
    String? category,
    bool isPrivate = false,
  }) async {
    // Local stub until broadcast API is wired — keeps go-live flow testable.
    return Right(
      LiveSessionDescriptor(
        sessionId: 'local_${DateTime.now().millisecondsSinceEpoch}',
        type: type,
        hostUserId: hostUserId,
        roomId: roomId,
        seatCount: seatCount,
        category: category,
        isPrivate: isPrivate,
      ),
    );
  }

  @override
  Future<Either<Failure, LiveSessionDescriptor>> joinSession({
    required String accessToken,
    required String sessionId,
    required int userId,
  }) async {
    return Right(
      LiveSessionDescriptor(
        sessionId: sessionId,
        type: LiveSessionType.videoRoom,
        hostUserId: userId,
      ),
    );
  }
}
