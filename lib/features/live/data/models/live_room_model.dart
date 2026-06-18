import '../../domain/entities/live_room.dart';

class LiveRoomModel extends LiveRoom {
  const LiveRoomModel({
    required super.id,
    required super.title,
    required super.sessionType,
    required super.currentParticipants,
    required super.maxParticipants,
    required super.isPrivate,
  });

  factory LiveRoomModel.fromJson(Map<String, dynamic> json) {
    return LiveRoomModel(
      id: json['id'] as int,
      title: (json['title'] as String?) ?? '',
      sessionType: (json['session_type'] as String?) ?? 'audio_room',
      currentParticipants: (json['current_participants'] as int?) ?? 0,
      maxParticipants: (json['max_participants'] as int?) ?? 0,
      isPrivate: json['is_private'] == 1 || json['is_private'] == true,
    );
  }
}
