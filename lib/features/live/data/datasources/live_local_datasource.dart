abstract class LiveLocalDataSource {
  Future<List<Map<String, dynamic>>> getRooms({String? sessionType});
}

class LiveLocalDataSourceImpl implements LiveLocalDataSource {
  static const _rooms = [
    {
      'id': 1,
      'title': '8 Chat Room',
      'session_type': 'audio_room',
      'current_participants': 6,
      'max_participants': 8,
      'is_private': false,
    },
    {
      'id': 2,
      'title': '16 Chat Room',
      'session_type': 'audio_room',
      'current_participants': 12,
      'max_participants': 16,
      'is_private': false,
    },
    {
      'id': 3,
      'title': 'PK Battle Arena',
      'session_type': 'video_battle',
      'current_participants': 2,
      'max_participants': 2,
      'is_private': false,
    },
    {
      'id': 4,
      'title': 'Private Party',
      'session_type': 'party',
      'current_participants': 4,
      'max_participants': 10,
      'is_private': true,
    },
    {
      'id': 5,
      'title': 'Video Live Room',
      'session_type': 'video_room',
      'current_participants': 1,
      'max_participants': 1,
      'is_private': false,
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> getRooms({String? sessionType}) async {
    if (sessionType == null) return List.from(_rooms);
    return _rooms
        .where((r) => r['session_type'] == sessionType)
        .map((r) => Map<String, dynamic>.from(r))
        .toList();
  }
}
