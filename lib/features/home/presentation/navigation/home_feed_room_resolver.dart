import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';

/// Maps home feed live cards to multi-seat chat room layout ids.
abstract final class HomeFeedRoomResolver {
  static String layoutRoomIdFor(RoomEntity room) {
    if (room.isPk) return 'pk';

    return switch (room.tag) {
      'Chatting' => 'movie',
      'Nearby' => 'room_4',
      'TOP10' => 'room_8',
      'New' => 'room_3',
      'Make Friends' => 'room_4',
      _ => 'movie',
    };
  }
}
