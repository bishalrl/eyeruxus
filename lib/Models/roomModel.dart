class RoomModel {
  final int? id;
  final String? uuid;
  final int? hostUserId;
  final String? sessionType;
  final String? title;
  final String? description;
  final String? roomCode;
  final String? password;
  final bool? isPrivate;
  final int? maxParticipants;
  final int? currentParticipants;
  final String? status;
  final String? scheduledAt;
  final String? startedAt;
  final String? endedAt;
  final String? createdAt;
  final String? updatedAt;

  // Additional host info (if included in response)
  final String? hostUsername;
  final String? hostAvatarUrl;

  RoomModel({
    this.id,
    this.uuid,
    this.hostUserId,
    this.sessionType,
    this.title,
    this.description,
    this.roomCode,
    this.password,
    this.isPrivate,
    this.maxParticipants,
    this.currentParticipants,
    this.status,
    this.scheduledAt,
    this.startedAt,
    this.endedAt,
    this.createdAt,
    this.updatedAt,
    this.hostUsername,
    this.hostAvatarUrl,
  });

  // Empty constructor
  factory RoomModel.empty() {
    return RoomModel(
      id: null,
      uuid: null,
      hostUserId: null,
      sessionType: null,
      title: null,
      description: null,
      roomCode: null,
      password: null,
      isPrivate: null,
      maxParticipants: null,
      currentParticipants: null,
      status: null,
      scheduledAt: null,
      startedAt: null,
      endedAt: null,
      createdAt: null,
      updatedAt: null,
      hostUsername: null,
      hostAvatarUrl: null,
    );
  }

  // From Map
  factory RoomModel.fromMap(Map<String, dynamic> map) {
    return RoomModel(
      id: map['id'] as int?,
      uuid: map['uuid'] as String?,
      hostUserId: map['host_user_id'] as int?,
      sessionType: map['session_type'] as String?,
      title: map['title'] as String?,
      description: map['description'] as String?,
      roomCode: map['room_code'] as String?,
      password: map['password'] as String?,
      isPrivate: map['is_private'] != null
          ? (map['is_private'] == 1 || map['is_private'] == true)
          : null,
      maxParticipants: map['max_participants'] as int?,
      currentParticipants: map['current_participants'] as int?,
      status: map['status'] as String?,
      scheduledAt: map['scheduled_at'] as String?,
      startedAt: map['started_at'] as String?,
      endedAt: map['ended_at'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      hostUsername: map['host_username'] as String?,
      hostAvatarUrl: map['host_avatar_url'] as String?,
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'host_user_id': hostUserId,
      'session_type': sessionType,
      'title': title,
      'description': description,
      'room_code': roomCode,
      'password': password,
      'is_private': isPrivate != null ? (isPrivate! ? 1 : 0) : null,
      'max_participants': maxParticipants,
      'current_participants': currentParticipants,
      'status': status,
      'scheduled_at': scheduledAt,
      'started_at': startedAt,
      'ended_at': endedAt,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'host_username': hostUsername,
      'host_avatar_url': hostAvatarUrl,
    };
  }

  // CopyWith
  RoomModel copyWith({
    int? id,
    String? uuid,
    int? hostUserId,
    String? sessionType,
    String? title,
    String? description,
    String? roomCode,
    String? password,
    bool? isPrivate,
    int? maxParticipants,
    int? currentParticipants,
    String? status,
    String? scheduledAt,
    String? startedAt,
    String? endedAt,
    String? createdAt,
    String? updatedAt,
    String? hostUsername,
    String? hostAvatarUrl,
  }) {
    return RoomModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      hostUserId: hostUserId ?? this.hostUserId,
      sessionType: sessionType ?? this.sessionType,
      title: title ?? this.title,
      description: description ?? this.description,
      roomCode: roomCode ?? this.roomCode,
      password: password ?? this.password,
      isPrivate: isPrivate ?? this.isPrivate,
      maxParticipants: maxParticipants ?? this.maxParticipants,
      currentParticipants: currentParticipants ?? this.currentParticipants,
      status: status ?? this.status,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      startedAt: startedAt ?? this.startedAt,
      endedAt: endedAt ?? this.endedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      hostUsername: hostUsername ?? this.hostUsername,
      hostAvatarUrl: hostAvatarUrl ?? this.hostAvatarUrl,
    );
  }

  // ToString
  @override
  String toString() {
    return 'RoomModel(id: $id, uuid: $uuid, hostUserId: $hostUserId, sessionType: $sessionType, title: $title, description: $description, roomCode: $roomCode, password: $password, isPrivate: $isPrivate, maxParticipants: $maxParticipants, currentParticipants: $currentParticipants, status: $status, scheduledAt: $scheduledAt, startedAt: $startedAt, endedAt: $endedAt, createdAt: $createdAt, updatedAt: $updatedAt, hostUsername: $hostUsername, hostAvatarUrl: $hostAvatarUrl)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is RoomModel &&
        other.id == id &&
        other.uuid == uuid &&
        other.hostUserId == hostUserId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
    uuid.hashCode ^
    hostUserId.hashCode;
  }

  // Helper methods
  bool get isAudioRoom => sessionType == 'audio_room';
  bool get isStreamingRoom => sessionType == 'streaming_room';
  bool get isWatchParty => sessionType == 'watch_party';
  bool get isGameSession => sessionType == 'game_session';

  bool get isLive => status == 'live';
  bool get isEnded => status == 'ended';
  bool get isWaiting => status == 'waiting';
  bool get isPreparing => status == 'preparing';
  bool get isInProgress => status == 'in_progress';

  bool get isFull => currentParticipants != null &&
      maxParticipants != null &&
      currentParticipants! >= maxParticipants!;
}