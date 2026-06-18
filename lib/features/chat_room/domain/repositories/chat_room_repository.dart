import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/chat_room_config.dart';

abstract class ChatRoomRepository {
  Future<Either<Failure, ChatRoomConfig>> getRoomConfig(String roomId);
}
