import 'package:equatable/equatable.dart';

import 'live_session_type.dart';

/// Runtime handle for an active or pending live session.
class LiveSessionDescriptor extends Equatable {
  const LiveSessionDescriptor({
    required this.sessionId,
    required this.type,
    required this.hostUserId,
    this.roomId,
    this.seatCount,
    this.category,
    this.isPrivate = false,
  });

  final String sessionId;
  final LiveSessionType type;
  final int hostUserId;
  final String? roomId;
  final int? seatCount;
  final String? category;
  final bool isPrivate;

  @override
  List<Object?> get props =>
      [sessionId, type, hostUserId, roomId, seatCount, category, isPrivate];
}
