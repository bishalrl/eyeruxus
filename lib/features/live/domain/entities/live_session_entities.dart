import 'package:equatable/equatable.dart';

enum LiveParticipantRole { host, cohost, moderator, viewer }

enum LiveSeatStatus { empty, occupied, locked, requested }

enum LiveRoomPrivacy { publicRoom, followersOnly, privateRoom, passwordProtected }

enum LiveConnectionQuality { excellent, good, fair, poor }

enum LiveRoomCategory {
  chatting,
  singing,
  dancing,
  gaming,
  pk,
  party,
  trending,
}

class LiveParticipant extends Equatable {
  const LiveParticipant({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.role,
    this.isMuted = false,
    this.isCameraOff = false,
    this.isSpeaking = false,
    this.connectionQuality = LiveConnectionQuality.good,
    this.isFollowing = false,
  });

  final String id;
  final String name;
  final String avatarUrl;
  final LiveParticipantRole role;
  final bool isMuted;
  final bool isCameraOff;
  final bool isSpeaking;
  final LiveConnectionQuality connectionQuality;
  final bool isFollowing;

  LiveParticipant copyWith({
    LiveParticipantRole? role,
    bool? isMuted,
    bool? isCameraOff,
    bool? isSpeaking,
    LiveConnectionQuality? connectionQuality,
    bool? isFollowing,
  }) {
    return LiveParticipant(
      id: id,
      name: name,
      avatarUrl: avatarUrl,
      role: role ?? this.role,
      isMuted: isMuted ?? this.isMuted,
      isCameraOff: isCameraOff ?? this.isCameraOff,
      isSpeaking: isSpeaking ?? this.isSpeaking,
      connectionQuality: connectionQuality ?? this.connectionQuality,
      isFollowing: isFollowing ?? this.isFollowing,
    );
  }

  @override
  List<Object?> get props => [id, role, isMuted, isCameraOff, isSpeaking];
}

class LiveSeat extends Equatable {
  const LiveSeat({
    required this.index,
    required this.status,
    this.participant,
  });

  final int index;
  final LiveSeatStatus status;
  final LiveParticipant? participant;

  LiveSeat copyWith({
    LiveSeatStatus? status,
    LiveParticipant? Function()? participant,
  }) {
    return LiveSeat(
      index: index,
      status: status ?? this.status,
      participant: participant != null ? participant() : this.participant,
    );
  }

  @override
  List<Object?> get props => [index, status, participant?.id];
}

class LiveSeatRequest extends Equatable {
  const LiveSeatRequest({
    required this.id,
    required this.userId,
    required this.userName,
    required this.avatarUrl,
    required this.seatIndex,
    required this.requestedAt,
  });

  final String id;
  final String userId;
  final String userName;
  final String avatarUrl;
  final int seatIndex;
  final DateTime requestedAt;

  @override
  List<Object?> get props => [id, seatIndex];
}

class LiveRoomSettings extends Equatable {
  const LiveRoomSettings({
    this.chatEnabled = true,
    this.giftsEnabled = true,
    this.seatRequestsEnabled = true,
    this.seatsLocked = false,
    this.reactionsEnabled = true,
  });

  final bool chatEnabled;
  final bool giftsEnabled;
  final bool seatRequestsEnabled;
  final bool seatsLocked;
  final bool reactionsEnabled;

  LiveRoomSettings copyWith({
    bool? chatEnabled,
    bool? giftsEnabled,
    bool? seatRequestsEnabled,
    bool? seatsLocked,
    bool? reactionsEnabled,
  }) {
    return LiveRoomSettings(
      chatEnabled: chatEnabled ?? this.chatEnabled,
      giftsEnabled: giftsEnabled ?? this.giftsEnabled,
      seatRequestsEnabled: seatRequestsEnabled ?? this.seatRequestsEnabled,
      seatsLocked: seatsLocked ?? this.seatsLocked,
      reactionsEnabled: reactionsEnabled ?? this.reactionsEnabled,
    );
  }

  @override
  List<Object?> get props => [
        chatEnabled,
        giftsEnabled,
        seatRequestsEnabled,
        seatsLocked,
        reactionsEnabled,
      ];
}

class LiveRoomSession extends Equatable {
  const LiveRoomSession({
    required this.id,
    required this.title,
    required this.description,
    required this.host,
    required this.seatCount,
    required this.category,
    required this.privacy,
    required this.language,
    required this.viewerCount,
    required this.likeCount,
    required this.seats,
    required this.participants,
    required this.seatRequests,
    required this.settings,
    this.coverImageUrl,
    this.isLive = true,
    this.activeSpeakerId,
    this.pinnedMessageId,
    this.currentUserRole = LiveParticipantRole.viewer,
  });

  final String id;
  final String title;
  final String description;
  final LiveParticipant host;
  final int seatCount;
  final LiveRoomCategory category;
  final LiveRoomPrivacy privacy;
  final String language;
  final int viewerCount;
  final int likeCount;
  final List<LiveSeat> seats;
  final List<LiveParticipant> participants;
  final List<LiveSeatRequest> seatRequests;
  final LiveRoomSettings settings;
  final String? coverImageUrl;
  final bool isLive;
  final String? activeSpeakerId;
  final String? pinnedMessageId;
  final LiveParticipantRole currentUserRole;

  bool get isHost => currentUserRole == LiveParticipantRole.host;

  bool get canModerate =>
      currentUserRole == LiveParticipantRole.host ||
      currentUserRole == LiveParticipantRole.moderator;

  LiveRoomSession copyWith({
    String? title,
    LiveParticipant? host,
    int? viewerCount,
    int? likeCount,
    List<LiveSeat>? seats,
    List<LiveParticipant>? participants,
    List<LiveSeatRequest>? seatRequests,
    LiveRoomSettings? settings,
    String? activeSpeakerId,
    String? Function()? pinnedMessageId,
    LiveParticipantRole? currentUserRole,
  }) {
    return LiveRoomSession(
      id: id,
      title: title ?? this.title,
      description: description,
      host: host ?? this.host,
      seatCount: seatCount,
      category: category,
      privacy: privacy,
      language: language,
      viewerCount: viewerCount ?? this.viewerCount,
      likeCount: likeCount ?? this.likeCount,
      seats: seats ?? this.seats,
      participants: participants ?? this.participants,
      seatRequests: seatRequests ?? this.seatRequests,
      settings: settings ?? this.settings,
      coverImageUrl: coverImageUrl,
      isLive: isLive,
      activeSpeakerId: activeSpeakerId ?? this.activeSpeakerId,
      pinnedMessageId:
          pinnedMessageId != null ? pinnedMessageId() : this.pinnedMessageId,
      currentUserRole: currentUserRole ?? this.currentUserRole,
    );
  }

  @override
  List<Object?> get props => [id, viewerCount, seats, seatRequests, settings];
}

class LiveRoomListing extends Equatable {
  const LiveRoomListing({
    required this.id,
    required this.title,
    required this.hostName,
    required this.hostAvatarUrl,
    required this.viewerCount,
    required this.seatCount,
    required this.category,
    required this.isTrending,
    required this.isRecommended,
    required this.coverImageUrl,
    required this.roomId,
    this.isPopular = false,
    this.isFollowing = false,
    this.isNearby = false,
    this.isNewCreator = false,
    this.language = 'English',
    this.country = 'Global',
  });

  final String id;
  final String title;
  final String hostName;
  final String hostAvatarUrl;
  final int viewerCount;
  final int seatCount;
  final LiveRoomCategory category;
  final bool isTrending;
  final bool isRecommended;
  final String coverImageUrl;
  final String roomId;
  final bool isPopular;
  final bool isFollowing;
  final bool isNearby;
  final bool isNewCreator;
  final String language;
  final String country;

  @override
  List<Object?> get props => [id];
}

class LiveHostAnalytics extends Equatable {
  const LiveHostAnalytics({
    this.liveDurationSeconds = 0,
    this.currentViewers = 0,
    this.peakViewers = 0,
    this.totalEngagement = 0,
    this.giftsReceived = 0,
    this.giftEarnings = 0,
    this.revenueTotal = 0,
    this.newFollowers = 0,
    this.followersCount = 0,
  });

  final int liveDurationSeconds;
  final int currentViewers;
  final int peakViewers;
  final int totalEngagement;
  final int giftsReceived;
  final int giftEarnings;
  final int revenueTotal;
  final int newFollowers;
  final int followersCount;

  LiveHostAnalytics copyWith({
    int? liveDurationSeconds,
    int? currentViewers,
    int? peakViewers,
    int? totalEngagement,
    int? giftsReceived,
    int? giftEarnings,
    int? revenueTotal,
    int? newFollowers,
    int? followersCount,
  }) {
    return LiveHostAnalytics(
      liveDurationSeconds: liveDurationSeconds ?? this.liveDurationSeconds,
      currentViewers: currentViewers ?? this.currentViewers,
      peakViewers: peakViewers ?? this.peakViewers,
      totalEngagement: totalEngagement ?? this.totalEngagement,
      giftsReceived: giftsReceived ?? this.giftsReceived,
      giftEarnings: giftEarnings ?? this.giftEarnings,
      revenueTotal: revenueTotal ?? this.revenueTotal,
      newFollowers: newFollowers ?? this.newFollowers,
      followersCount: followersCount ?? this.followersCount,
    );
  }

  @override
  List<Object?> get props => [liveDurationSeconds, currentViewers, peakViewers];
}

class CreateLiveRoomRequest extends Equatable {
  const CreateLiveRoomRequest({
    required this.title,
    required this.description,
    required this.seatCount,
    required this.category,
    required this.privacy,
    required this.language,
    this.coverImageUrl,
    this.password,
  });

  final String title;
  final String description;
  final int seatCount;
  final LiveRoomCategory category;
  final LiveRoomPrivacy privacy;
  final String language;
  final String? coverImageUrl;
  final String? password;

  @override
  List<Object?> get props => [title, seatCount, category];
}
