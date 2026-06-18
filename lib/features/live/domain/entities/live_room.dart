import 'package:equatable/equatable.dart';

class LiveRoom extends Equatable {
  final int id;
  final String title;
  final String sessionType;
  final int currentParticipants;
  final int maxParticipants;
  final bool isPrivate;

  const LiveRoom({
    required this.id,
    required this.title,
    required this.sessionType,
    required this.currentParticipants,
    required this.maxParticipants,
    required this.isPrivate,
  });

  @override
  List<Object?> get props =>
      [id, title, sessionType, currentParticipants, maxParticipants, isPrivate];
}
