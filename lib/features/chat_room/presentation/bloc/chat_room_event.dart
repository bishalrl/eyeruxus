part of 'chat_room_bloc.dart';

abstract class ChatRoomEvent extends Equatable {
  const ChatRoomEvent();

  @override
  List<Object?> get props => [];
}

class ChatRoomLoadRequested extends ChatRoomEvent {
  final String roomId;

  const ChatRoomLoadRequested(this.roomId);

  @override
  List<Object?> get props => [roomId];
}
