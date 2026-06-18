abstract class ChatRoomLocalDataSource {
  Future<Map<String, dynamic>?> getRoomConfig(String roomId);
}

class ChatRoomLocalDataSourceImpl implements ChatRoomLocalDataSource {
  static const _rooms = {
    'movie': {
      'id': 'movie',
      'title_key': 'devMovieScreen',
      'seat_count': 1,
      'layout_type': 'video',
    },
    'room_8': {
      'id': 'room_8',
      'title_key': 'devChatRoom8',
      'seat_count': 8,
      'layout_type': 'grid',
    },
    'room_16': {
      'id': 'room_16',
      'title_key': 'devChatRoom16',
      'seat_count': 16,
      'layout_type': 'grid',
    },
    'room_32': {
      'id': 'room_32',
      'title_key': 'devChatRoom32',
      'seat_count': 32,
      'layout_type': 'grid',
    },
    'room_12': {
      'id': 'room_12',
      'title_key': 'devChatRoom12',
      'seat_count': 12,
      'layout_type': 'grid',
    },
    'room_4': {
      'id': 'room_4',
      'title_key': 'devChatRoom4',
      'seat_count': 4,
      'layout_type': 'grid',
    },
    'room_6': {
      'id': 'room_6',
      'title_key': 'devChatRoom6',
      'seat_count': 6,
      'layout_type': 'grid',
    },
    'room_10': {
      'id': 'room_10',
      'title_key': 'devChatRoom10',
      'seat_count': 10,
      'layout_type': 'grid',
    },
    'room_3': {
      'id': 'room_3',
      'title_key': 'devChatRoom3',
      'seat_count': 3,
      'layout_type': 'grid',
    },
    'room_20': {
      'id': 'room_20',
      'title_key': 'devChatRoom20',
      'seat_count': 20,
      'layout_type': 'grid',
    },
    'room_18': {
      'id': 'room_18',
      'title_key': 'devChatRoom18',
      'seat_count': 18,
      'layout_type': 'grid',
    },
    'pk': {
      'id': 'pk',
      'title_key': 'devPkScreen',
      'seat_count': 2,
      'layout_type': 'pk',
    },
    'room_ludo': {
      'id': 'room_ludo',
      'title_key': 'devChatRoomLudo',
      'seat_count': 4,
      'layout_type': 'grid',
    },
  };

  @override
  Future<Map<String, dynamic>?> getRoomConfig(String roomId) async {
    final config = _rooms[roomId];
    if (config == null) return null;
    return Map<String, dynamic>.from(config);
  }
}
