import '../../domain/entities/chat_room_config.dart';

class ChatRoomConfigModel extends ChatRoomConfig {
  const ChatRoomConfigModel({
    required super.id,
    required super.titleKey,
    required super.seatCount,
    required super.layoutType,
  });

  factory ChatRoomConfigModel.fromJson(Map<String, dynamic> json) {
    return ChatRoomConfigModel(
      id: json['id'] as String,
      titleKey: json['title_key'] as String,
      seatCount: (json['seat_count'] as num).toInt(),
      layoutType: json['layout_type'] as String,
    );
  }
}
