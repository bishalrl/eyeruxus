import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_gift.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_room_comment.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';

class LiveLikeBurst extends Equatable {
  const LiveLikeBurst({
    required this.id,
    required this.dx,
    required this.dy,
    this.emoji = '❤️',
  });

  final String id;
  final double dx;
  final double dy;
  final String emoji;

  @override
  List<Object?> get props => [id, dx, dy, emoji];
}

class LiveGiftEvent extends Equatable {
  const LiveGiftEvent({
    required this.id,
    required this.gift,
    required this.senderName,
  });

  final String id;
  final LiveGift gift;
  final String senderName;

  @override
  List<Object?> get props => [id, gift, senderName];
}

enum LiveRoomLoadStatus { initial, loading, ready, error, ended }

class LiveRoomInteractionState extends Equatable {
  const LiveRoomInteractionState({
    required this.roomId,
    this.status = LiveRoomLoadStatus.initial,
    this.session,
    this.hasJoined = false,
    this.likeCount = 0,
    this.viewerCount = 128,
    this.comments = const [],
    this.likeBursts = const [],
    this.giftEvents = const [],
    this.giftPanelOpen = false,
    this.commentSheetOpen = false,
    this.moreMenuOpen = false,
    this.seatSheetOpen = false,
    this.moderationSheetOpen = false,
    this.message,
    this.joinBanner,
    this.unreadInbox = 2,
    this.micEnabled = true,
    this.cameraEnabled = true,
    this.speakerEnabled = true,
    this.selectedSeat,
    this.seatCount = 8,
    this.isFollowingHost = false,
    this.connectionQuality = LiveConnectionQuality.good,
    this.errorMessage,
    this.hostControlsOpen = false,
    this.analyticsOpen = false,
    this.giftDashboardOpen = false,
    this.hostAnalytics = const LiveHostAnalytics(),
    this.beautyFilterEnabled = false,
    this.backgroundBlurEnabled = false,
    this.seatRequestRejectedMessage,
    this.walletCoins = 0,
  });

  final String roomId;
  final LiveRoomLoadStatus status;
  final LiveRoomSession? session;
  final bool hasJoined;
  final int likeCount;
  final int viewerCount;
  final List<LiveRoomComment> comments;
  final List<LiveLikeBurst> likeBursts;
  final List<LiveGiftEvent> giftEvents;
  final bool giftPanelOpen;
  final bool commentSheetOpen;
  final bool moreMenuOpen;
  final bool seatSheetOpen;
  final bool moderationSheetOpen;
  final String? message;
  final String? joinBanner;
  final int unreadInbox;
  final bool micEnabled;
  final bool cameraEnabled;
  final bool speakerEnabled;
  final int? selectedSeat;
  final int seatCount;
  final bool isFollowingHost;
  final LiveConnectionQuality connectionQuality;
  final String? errorMessage;
  final bool hostControlsOpen;
  final bool analyticsOpen;
  final bool giftDashboardOpen;
  final LiveHostAnalytics hostAnalytics;
  final bool beautyFilterEnabled;
  final bool backgroundBlurEnabled;
  final String? seatRequestRejectedMessage;
  final int walletCoins;

  bool get isViewer => !isHost && !canModerate;
  bool get canModerate => session?.canModerate ?? false;
  bool get isHost => session?.isHost ?? false;
  List<LiveSeat> get seats => session?.seats ?? const [];
  List<LiveSeatRequest> get seatRequests => session?.seatRequests ?? const [];
  bool get hasPendingSeatRequest =>
      seatRequests.any((request) => request.userId == 'me');

  LiveRoomInteractionState copyWith({
    LiveRoomLoadStatus? status,
    LiveRoomSession? session,
    bool? hasJoined,
    int? likeCount,
    int? viewerCount,
    List<LiveRoomComment>? comments,
    List<LiveLikeBurst>? likeBursts,
    List<LiveGiftEvent>? giftEvents,
    bool? giftPanelOpen,
    bool? commentSheetOpen,
    bool? moreMenuOpen,
    bool? seatSheetOpen,
    bool? moderationSheetOpen,
    String? Function()? message,
    String? Function()? joinBanner,
    int? unreadInbox,
    bool? micEnabled,
    bool? cameraEnabled,
    bool? speakerEnabled,
    int? Function()? selectedSeat,
    int? seatCount,
    bool? isFollowingHost,
    LiveConnectionQuality? connectionQuality,
    String? Function()? errorMessage,
    bool? hostControlsOpen,
    bool? analyticsOpen,
    bool? giftDashboardOpen,
    LiveHostAnalytics? hostAnalytics,
    bool? beautyFilterEnabled,
    bool? backgroundBlurEnabled,
    String? Function()? seatRequestRejectedMessage,
    int? walletCoins,
  }) {
    return LiveRoomInteractionState(
      roomId: roomId,
      status: status ?? this.status,
      session: session ?? this.session,
      hasJoined: hasJoined ?? this.hasJoined,
      likeCount: likeCount ?? this.likeCount,
      viewerCount: viewerCount ?? this.viewerCount,
      comments: comments ?? this.comments,
      likeBursts: likeBursts ?? this.likeBursts,
      giftEvents: giftEvents ?? this.giftEvents,
      giftPanelOpen: giftPanelOpen ?? this.giftPanelOpen,
      commentSheetOpen: commentSheetOpen ?? this.commentSheetOpen,
      moreMenuOpen: moreMenuOpen ?? this.moreMenuOpen,
      seatSheetOpen: seatSheetOpen ?? this.seatSheetOpen,
      moderationSheetOpen: moderationSheetOpen ?? this.moderationSheetOpen,
      message: message != null ? message() : this.message,
      joinBanner: joinBanner != null ? joinBanner() : this.joinBanner,
      unreadInbox: unreadInbox ?? this.unreadInbox,
      micEnabled: micEnabled ?? this.micEnabled,
      cameraEnabled: cameraEnabled ?? this.cameraEnabled,
      speakerEnabled: speakerEnabled ?? this.speakerEnabled,
      selectedSeat: selectedSeat != null ? selectedSeat() : this.selectedSeat,
      seatCount: seatCount ?? this.seatCount,
      isFollowingHost: isFollowingHost ?? this.isFollowingHost,
      connectionQuality: connectionQuality ?? this.connectionQuality,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
      hostControlsOpen: hostControlsOpen ?? this.hostControlsOpen,
      analyticsOpen: analyticsOpen ?? this.analyticsOpen,
      giftDashboardOpen: giftDashboardOpen ?? this.giftDashboardOpen,
      hostAnalytics: hostAnalytics ?? this.hostAnalytics,
      beautyFilterEnabled: beautyFilterEnabled ?? this.beautyFilterEnabled,
      backgroundBlurEnabled: backgroundBlurEnabled ?? this.backgroundBlurEnabled,
      seatRequestRejectedMessage: seatRequestRejectedMessage != null
          ? seatRequestRejectedMessage()
          : this.seatRequestRejectedMessage,
      walletCoins: walletCoins ?? this.walletCoins,
    );
  }

  @override
  List<Object?> get props => [
        roomId,
        status,
        session,
        hasJoined,
        likeCount,
        viewerCount,
        comments,
        likeBursts,
        giftEvents,
        giftPanelOpen,
        commentSheetOpen,
        moreMenuOpen,
        seatSheetOpen,
        moderationSheetOpen,
        message,
        joinBanner,
        unreadInbox,
        micEnabled,
        cameraEnabled,
        speakerEnabled,
        selectedSeat,
        seatCount,
        isFollowingHost,
        connectionQuality,
        errorMessage,
        hostControlsOpen,
        analyticsOpen,
        giftDashboardOpen,
        hostAnalytics,
        beautyFilterEnabled,
        backgroundBlurEnabled,
        seatRequestRejectedMessage,
        walletCoins,
      ];
}
