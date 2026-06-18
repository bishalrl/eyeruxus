import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/live_room.dart';
import '../entities/live_session_descriptor.dart';
import '../entities/live_session_type.dart';

abstract class LiveRepository {
  Future<Either<Failure, List<LiveRoom>>> getRooms({
    required String accessToken,
    String? sessionType,
  });

  Future<Either<Failure, LiveSessionDescriptor>> createSession({
    required String accessToken,
    required int hostUserId,
    required LiveSessionType type,
    String? roomId,
    int? seatCount,
    String? category,
    bool isPrivate = false,
  });

  Future<Either<Failure, LiveSessionDescriptor>> joinSession({
    required String accessToken,
    required String sessionId,
    required int userId,
  });
}
