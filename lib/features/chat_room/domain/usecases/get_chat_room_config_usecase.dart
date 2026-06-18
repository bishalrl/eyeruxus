import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/chat_room_config.dart';
import '../repositories/chat_room_repository.dart';

class GetChatRoomConfigUseCase
    implements UseCase<ChatRoomConfig, GetChatRoomConfigParams> {
  final ChatRoomRepository repository;

  GetChatRoomConfigUseCase(this.repository);

  @override
  Future<Either<Failure, ChatRoomConfig>> call(
    GetChatRoomConfigParams params,
  ) {
    return repository.getRoomConfig(params.roomId);
  }
}

class GetChatRoomConfigParams extends Equatable {
  final String roomId;

  const GetChatRoomConfigParams(this.roomId);

  @override
  List<Object?> get props => [roomId];
}
