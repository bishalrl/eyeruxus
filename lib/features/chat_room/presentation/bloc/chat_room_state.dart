part of 'chat_room_bloc.dart';

abstract class ChatRoomState extends Equatable {
  const ChatRoomState();

  @override
  List<Object?> get props => [];
}

class ChatRoomInitial extends ChatRoomState {
  const ChatRoomInitial();
}

class ChatRoomLoading extends ChatRoomState {
  const ChatRoomLoading({required this.roomId});

  final String roomId;

  @override
  List<Object?> get props => [roomId];
}

class ChatRoomLoaded extends ChatRoomState {
  final ChatRoomConfig config;

  const ChatRoomLoaded(this.config);

  @override
  List<Object?> get props => [config];
}

class ChatRoomFailure extends ChatRoomState {
  final String message;

  const ChatRoomFailure(this.message);

  @override
  List<Object?> get props => [message];
}
