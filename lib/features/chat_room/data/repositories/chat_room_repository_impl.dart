import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/chat_room_config.dart';
import '../../domain/repositories/chat_room_repository.dart';
import '../datasources/chat_room_local_datasource.dart';
import '../models/chat_room_config_model.dart';

class ChatRoomRepositoryImpl implements ChatRoomRepository {
  final ChatRoomLocalDataSource localDataSource;

  ChatRoomRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, ChatRoomConfig>> getRoomConfig(String roomId) async {
    try {
      final json = await localDataSource.getRoomConfig(roomId);
      if (json == null) {
        return Left(ServerFailure('Chat room not found: $roomId'));
      }
      return Right(ChatRoomConfigModel.fromJson(json));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
