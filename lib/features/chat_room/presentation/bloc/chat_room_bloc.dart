import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/chat_room_config.dart';
import '../../domain/usecases/get_chat_room_config_usecase.dart';

part 'chat_room_event.dart';
part 'chat_room_state.dart';

class ChatRoomBloc extends Bloc<ChatRoomEvent, ChatRoomState> {
  final GetChatRoomConfigUseCase getChatRoomConfigUseCase;

  ChatRoomBloc({required this.getChatRoomConfigUseCase})
      : super(const ChatRoomInitial()) {
    on<ChatRoomLoadRequested>(_onLoad);
  }

  Future<void> _onLoad(
    ChatRoomLoadRequested event,
    Emitter<ChatRoomState> emit,
  ) async {
    emit(ChatRoomLoading(roomId: event.roomId));
    final result = await getChatRoomConfigUseCase(
      GetChatRoomConfigParams(event.roomId),
    );
    result.fold(
      (failure) => emit(ChatRoomFailure(failure.message)),
      (config) => emit(ChatRoomLoaded(config)),
    );
  }
}
