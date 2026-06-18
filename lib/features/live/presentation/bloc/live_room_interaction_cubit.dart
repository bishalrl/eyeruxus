import 'dart:async';
import 'dart:math';

import 'package:eye_rex_us/features/live/data/datasources/live_gift_local_datasource.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_room_comment.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/domain/repositories/live_session_repository.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_media_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_layout_registry.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'live_room_interaction_state.dart';

class LiveRoomInteractionCubit extends Cubit<LiveRoomInteractionState> {
  LiveRoomInteractionCubit({
    required String roomId,
    required LiveSessionRepository sessionRepository,
    required LiveMediaCubit mediaCubit,
    int seatCount = 8,
    LiveParticipantRole role = LiveParticipantRole.viewer,
    bool instantJoinSeat = false,
    int? preferredSeatIndex,
    String? partyTitle,
  })  : _sessionRepository = sessionRepository,
        _mediaCubit = mediaCubit,
        _role = role,
        _instantJoinSeat = instantJoinSeat,
        _preferredSeatIndex = preferredSeatIndex,
        _partyTitle = partyTitle,
        super(
          LiveRoomInteractionState(
            roomId: roomId,
            seatCount: seatCount,
            comments: LiveGiftLocalDataSource.initialComments(roomId),
          ),
        ) {
    _mediaSubscription = _mediaCubit.stream.listen(_onMediaChanged);
    _initialize();
  }

  final LiveSessionRepository _sessionRepository;
  final LiveMediaCubit _mediaCubit;
  final LiveParticipantRole _role;
  final bool _instantJoinSeat;
  final int? _preferredSeatIndex;
  final String? _partyTitle;
  final _random = Random();
  final List<Timer> _timers = [];
  StreamSubscription<LiveMediaState>? _mediaSubscription;

  LiveMediaCubit get mediaCubit => _mediaCubit;

  void _onMediaChanged(LiveMediaState media) {
    if (isClosed) return;
    emit(
      state.copyWith(
        cameraEnabled: media.cameraEnabled,
        micEnabled: media.microphoneEnabled,
        speakerEnabled: media.speakerEnabled,
        beautyFilterEnabled: media.beautyFilterEnabled,
        backgroundBlurEnabled: media.backgroundBlurEnabled,
      ),
    );
  }

  static int seatCountForRoom(String roomId) =>
      LiveLayoutRegistry.seatCountForRoom(roomId);

  bool _sessionHasLocalCameraSeat(LiveRoomSession session) {
    return session.seats.any((seat) {
      final id = seat.participant?.id;
      return id == 'host_me' || id == 'me';
    });
  }

  bool _hasLocalSeat(LiveRoomSession session) => _sessionHasLocalCameraSeat(session);

  static bool isHostParticipant(LiveParticipant participant) =>
      participant.role == LiveParticipantRole.host ||
      participant.id == 'host_me';

  LiveParticipant? _participantById(String participantId) {
    final session = state.session;
    if (session == null) return null;
    for (final p in session.participants) {
      if (p.id == participantId) return p;
    }
    for (final seat in session.seats) {
      final p = seat.participant;
      if (p != null && p.id == participantId) return p;
    }
    return null;
  }

  bool _canManageParticipant(String participantId) {
    final session = state.session;
    if (session == null || !state.canModerate) return false;
    final target = _participantById(participantId);
    if (target == null) return false;
    if (isHostParticipant(target)) return false;
    return true;
  }

  void _denyModeration(String participantId, {String? reason}) {
    final target = _participantById(participantId);
    if (target != null && isHostParticipant(target)) {
      emit(state.copyWith(message: () => 'Cannot moderate the host'));
      return;
    }
    emit(
      state.copyWith(
        message: () => reason ?? 'You do not have permission to manage guests',
      ),
    );
  }

  Future<void> _ensureLocalCameraForSession(LiveRoomSession session) async {
    if (!_sessionHasLocalCameraSeat(session)) return;
    if (_mediaCubit.state.previewReady && _mediaCubit.state.cameraEnabled) {
      return;
    }
    await _mediaCubit.startCameraPreview();
  }

  Future<void> _initialize() async {
    emit(state.copyWith(status: LiveRoomLoadStatus.loading));
    try {
      var session = await _sessionRepository.joinSession(
        roomId: state.roomId,
        role: _role,
      );
      if (_partyTitle != null && _partyTitle.trim().isNotEmpty) {
        session = session.copyWith(title: _partyTitle);
      }
      if (_instantJoinSeat && _role == LiveParticipantRole.viewer) {
        session = await _sessionRepository.instantJoinSeat(
          sessionId: session.id,
          seatIndex: _preferredSeatIndex,
        );
      }
      emit(
        state.copyWith(
          status: LiveRoomLoadStatus.ready,
          session: session,
          seatCount: session.seatCount,
          viewerCount: session.viewerCount + (_instantJoinSeat ? 1 : 0),
          likeCount: session.likeCount,
          hasJoined: true,
          hostAnalytics: LiveHostAnalytics(
            currentViewers: session.viewerCount,
            peakViewers: session.viewerCount,
            followersCount: 1200 + _random.nextInt(800),
          ),
          message: () => _instantJoinSeat && _hasLocalSeat(session)
              ? 'Joined party — you are on stage'
              : null,
        ),
      );
      if (!_instantJoinSeat &&
          _preferredSeatIndex != null &&
          _role == LiveParticipantRole.viewer) {
        await requestSeat(_preferredSeatIndex);
      }
      await _ensureLocalCameraForSession(session);
      if (_role == LiveParticipantRole.host) {
        _startHostLiveTimer();
      }
      joinRoom(userName: 'You');
      _scheduleJoinBanner('Vivek the king', const Duration(seconds: 2));
      _scheduleJoinBanner('Priya', const Duration(seconds: 5));
    } catch (e) {
      emit(
        state.copyWith(
          status: LiveRoomLoadStatus.error,
          errorMessage: () => e.toString(),
        ),
      );
    }
  }

  void _startHostLiveTimer() {
    _timers.add(
      Timer.periodic(const Duration(seconds: 1), (_) {
        if (isClosed) return;
        final analytics = state.hostAnalytics;
        emit(
          state.copyWith(
            hostAnalytics: analytics.copyWith(
              liveDurationSeconds: analytics.liveDurationSeconds + 1,
              currentViewers: state.viewerCount,
              peakViewers: state.viewerCount > analytics.peakViewers
                  ? state.viewerCount
                  : analytics.peakViewers,
            ),
          ),
        );
      }),
    );
  }

  void _scheduleJoinBanner(String name, Duration delay) {
    _timers.add(
      Timer(delay, () {
        if (isClosed) return;
        showJoinBanner('$name Joined');
      }),
    );
  }

  @override
  Future<void> close() async {
    for (final timer in _timers) {
      timer.cancel();
    }
    await _mediaSubscription?.cancel();
    return super.close();
  }

  Future<void> rejoin() async {
    if (state.session == null) return;
    emit(state.copyWith(status: LiveRoomLoadStatus.loading));
    try {
      final session =
          await _sessionRepository.rejoinSession(sessionId: state.session!.id);
      await _mediaCubit.recoverStream();
      emit(
        state.copyWith(
          status: LiveRoomLoadStatus.ready,
          session: session,
          connectionQuality: LiveConnectionQuality.good,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LiveRoomLoadStatus.error,
          errorMessage: () => 'Reconnection failed',
        ),
      );
    }
  }

  void joinRoom({String userName = 'You'}) {
    if (state.hasJoined && userName == 'You') return;
    emit(
      state.copyWith(
        hasJoined: true,
        viewerCount: state.viewerCount + 1,
        joinBanner: () => '$userName Joined',
      ),
    );
  }

  void showJoinBanner(String message) {
    emit(state.copyWith(joinBanner: () => message));
    _timers.add(
      Timer(const Duration(seconds: 3), () {
        if (isClosed) return;
        emit(state.copyWith(joinBanner: () => null));
      }),
    );
  }

  void sendReaction(String emoji) {
    sendLike(emoji: emoji);
  }

  void sendLike({double? dx, double? dy, String emoji = '❤️'}) {
    if (state.session?.settings.reactionsEnabled == false) return;
    final burst = LiveLikeBurst(
      id: '${DateTime.now().microsecondsSinceEpoch}',
      dx: dx ?? 0.5 + _random.nextDouble() * 0.3,
      dy: dy ?? 0.35 + _random.nextDouble() * 0.25,
      emoji: emoji,
    );
    final bursts = [...state.likeBursts, burst];
    if (bursts.length > 16) bursts.removeAt(0);
    emit(
      state.copyWith(
        likeCount: state.likeCount + 1,
        likeBursts: bursts,
        hostAnalytics: state.hostAnalytics.copyWith(
          totalEngagement: state.hostAnalytics.totalEngagement + 1,
        ),
      ),
    );
  }

  void clearLikeBurst(String id) {
    emit(
      state.copyWith(
        likeBursts: state.likeBursts.where((b) => b.id != id).toList(),
      ),
    );
  }

  void sendComment(String text) {
    if (state.session?.settings.chatEnabled == false) {
      emit(state.copyWith(message: () => 'Chat is disabled'));
      return;
    }
    final trimmed = text.trim();
    if (trimmed.isEmpty) return;
    final comment = LiveRoomComment(
      id: 'c_${DateTime.now().millisecondsSinceEpoch}',
      authorName: 'You',
      text: trimmed,
      timeLabel: 'now',
    );
    emit(
      state.copyWith(
        comments: [...state.comments, comment],
        unreadInbox: 0,
      ),
    );
  }

  void deleteComment(String commentId) {
    if (!state.canModerate) return;
    emit(
      state.copyWith(
        comments: state.comments.where((c) => c.id != commentId).toList(),
      ),
    );
  }

  void sendGift(String giftId) {
    if (state.session?.settings.giftsEnabled == false) {
      emit(state.copyWith(message: () => 'Gifts are disabled'));
      return;
    }
    final gift = LiveGiftLocalDataSource.giftById(giftId);
    if (gift == null) return;

    final event = LiveGiftEvent(
      id: 'g_${DateTime.now().millisecondsSinceEpoch}',
      gift: gift,
      senderName: 'You',
    );
    final events = [...state.giftEvents, event];
    if (events.length > 5) events.removeAt(0);

    emit(
      state.copyWith(
        giftEvents: events,
        giftPanelOpen: false,
        hostAnalytics: state.hostAnalytics.copyWith(
          giftsReceived: state.hostAnalytics.giftsReceived + 1,
          giftEarnings: state.hostAnalytics.giftEarnings + gift.coinCost,
          revenueTotal: state.hostAnalytics.revenueTotal + gift.coinCost,
          totalEngagement: state.hostAnalytics.totalEngagement + 5,
        ),
        comments: [
          ...state.comments,
          LiveRoomComment(
            id: event.id,
            authorName: 'You',
            text: 'sent ${gift.emoji} ${gift.name}',
            timeLabel: 'now',
          ),
        ],
      ),
    );
  }

  void removeGiftEvent(String id) {
    emit(
      state.copyWith(
        giftEvents: state.giftEvents.where((e) => e.id != id).toList(),
      ),
    );
  }

  void openGiftPanel() {
    if (state.session?.settings.giftsEnabled == false) return;
    emit(state.copyWith(giftPanelOpen: true));
  }

  void closeGiftPanel() => emit(state.copyWith(giftPanelOpen: false));

  void openCommentSheet() => emit(state.copyWith(commentSheetOpen: true));

  void closeCommentSheet() => emit(state.copyWith(commentSheetOpen: false));

  void openMoreMenu() => emit(state.copyWith(moreMenuOpen: true));

  void closeMoreMenu() => emit(state.copyWith(moreMenuOpen: false));

  void openSeatSheet() => emit(state.copyWith(seatSheetOpen: true));

  void closeSeatSheet() => emit(state.copyWith(seatSheetOpen: false));

  void openHostControls() => emit(state.copyWith(hostControlsOpen: true));

  void closeHostControls() => emit(state.copyWith(hostControlsOpen: false));

  void openAnalytics() => emit(state.copyWith(analyticsOpen: true));

  void closeAnalytics() => emit(state.copyWith(analyticsOpen: false));

  void openGiftDashboard() => emit(state.copyWith(giftDashboardOpen: true));

  void closeGiftDashboard() => emit(state.copyWith(giftDashboardOpen: false));

  Future<void> toggleBeautyFilter() async {
    _mediaCubit.toggleBeautyFilter();
  }

  Future<void> toggleBackgroundBlur() async {
    _mediaCubit.toggleBackgroundBlur();
  }

  Future<void> toggleRoomLock() async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the host can lock seats'));
      return;
    }
    final locked = !session.settings.seatsLocked;
    await updateSettings(
      session.settings.copyWith(seatsLocked: locked),
    );
  }

  Future<void> toggleRoomMute() async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the host can mute the room'));
      return;
    }
    await updateSettings(
      session.settings.copyWith(chatEnabled: !session.settings.chatEnabled),
    );
  }

  void leaveRoom() {
    _mediaCubit.stopCameraPreview();
    emit(state.copyWith(status: LiveRoomLoadStatus.ended));
  }

  void clearSeatRequestRejected() =>
      emit(state.copyWith(seatRequestRejectedMessage: () => null));

  Future<void> toggleMic() async {
    await _mediaCubit.toggleMicrophone();
  }

  Future<void> toggleCamera() async {
    await _mediaCubit.toggleCamera();
  }

  Future<void> toggleSpeaker() async {
    await _mediaCubit.toggleSpeaker();
  }

  Future<void> switchCamera() => _mediaCubit.switchCamera();

  Future<void> startScreenShare() => _mediaCubit.startScreenShare();

  Future<void> requestSeat(int seatIndex) async {
    final session = state.session;
    if (session == null) return;
    if (!session.settings.seatRequestsEnabled) {
      emit(state.copyWith(message: () => 'Seat requests are disabled'));
      return;
    }
    if (session.settings.seatsLocked) {
      emit(state.copyWith(message: () => 'Seats are locked'));
      return;
    }

    if (_instantJoinSeat) {
      final updated = await _sessionRepository.instantJoinSeat(
        sessionId: session.id,
        seatIndex: seatIndex,
      );
      emit(
        state.copyWith(
          session: updated,
          selectedSeat: () => seatIndex,
          seatSheetOpen: false,
          message: () => 'You joined seat ${seatIndex + 1}',
        ),
      );
      await _ensureLocalCameraForSession(updated);
      return;
    }

    final updated = await _sessionRepository.requestSeat(
      sessionId: session.id,
      seatIndex: seatIndex,
    );
    emit(
      state.copyWith(
        session: updated,
        selectedSeat: () => seatIndex,
        seatSheetOpen: false,
        message: () => 'Seat request sent — waiting for host approval',
      ),
    );
  }

  Future<void> approveSeatRequest(String requestId) async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the room owner can accept join requests'));
      return;
    }
    final updated = await _sessionRepository.approveSeatRequest(
      sessionId: session.id,
      requestId: requestId,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => 'Guest accepted as co-host',
      ),
    );
    await _ensureLocalCameraForSession(updated);
    showJoinBanner('Seat request approved');
  }

  Future<void> rejectSeatRequest(String requestId) async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the room owner can reject requests'));
      return;
    }
    final updated = await _sessionRepository.rejectSeatRequest(
      sessionId: session.id,
      requestId: requestId,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => 'Seat request rejected',
      ),
    );
  }

  Future<void> muteParticipant(String participantId, {required bool muted}) async {
    final session = state.session;
    if (session == null) return;
    if (!_canManageParticipant(participantId)) {
      _denyModeration(participantId);
      return;
    }
    final updated = await _sessionRepository.muteParticipant(
      sessionId: session.id,
      participantId: participantId,
      muted: muted,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => muted ? 'Guest muted' : 'Guest unmuted',
      ),
    );
  }

  Future<void> setParticipantCamera(String participantId, {required bool cameraOff}) async {
    final session = state.session;
    if (session == null) return;
    if (!_canManageParticipant(participantId)) {
      _denyModeration(participantId);
      return;
    }
    final updated = await _sessionRepository.setParticipantCamera(
      sessionId: session.id,
      participantId: participantId,
      cameraOff: cameraOff,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => cameraOff ? 'Guest camera turned off' : 'Guest camera turned on',
      ),
    );
  }

  Future<void> assignCohost(String participantId) async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the room owner can assign co-hosts'));
      return;
    }
    if (participantId == 'host_me') return;
    final updated = await _sessionRepository.assignCohost(
      sessionId: session.id,
      participantId: participantId,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => 'Co-host role assigned',
      ),
    );
  }

  Future<void> demoteParticipant(String participantId) async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the room owner can remove guests from seats'));
      return;
    }
    if (participantId == 'host_me') return;
    final updated = await _sessionRepository.demoteParticipant(
      sessionId: session.id,
      participantId: participantId,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => 'Guest removed from seat',
      ),
    );
  }

  Future<void> kickParticipant(String participantId) async {
    final session = state.session;
    if (session == null) return;
    if (!_canManageParticipant(participantId)) {
      _denyModeration(participantId);
      return;
    }
    final updated = await _sessionRepository.kickParticipant(
      sessionId: session.id,
      participantId: participantId,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => 'Guest removed from the room',
      ),
    );
  }

  Future<void> updateSettings(LiveRoomSettings settings) async {
    final session = state.session;
    if (session == null || !state.canModerate) {
      emit(state.copyWith(message: () => 'Only the host can change room settings'));
      return;
    }
    final updated = await _sessionRepository.updateSettings(
      sessionId: session.id,
      settings: settings,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => _settingsMessage(updated.settings),
      ),
    );
  }

  String _settingsMessage(LiveRoomSettings settings) {
    if (!settings.seatsLocked && settings.chatEnabled) {
      return 'Room settings updated';
    }
    if (settings.seatsLocked) return 'Seats are now locked';
    if (!settings.chatEnabled) return 'Room chat muted';
    return 'Room settings updated';
  }

  void inviteViewers() {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the host can invite viewers'));
      return;
    }
    emit(
      state.copyWith(
        message: () => 'Invite link ready — share "${session.title}" with friends',
      ),
    );
  }

  void openModerationPanel() => emit(state.copyWith(hostControlsOpen: true));

  Future<void> assignModerator(String participantId) async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the room owner can make admins'));
      return;
    }
    if (!_canManageParticipant(participantId)) {
      _denyModeration(participantId);
      return;
    }
    final updated = await _sessionRepository.assignModerator(
      sessionId: session.id,
      participantId: participantId,
    );
    emit(
      state.copyWith(
        session: updated,
        message: () => 'Admin role assigned',
      ),
    );
  }

  Future<void> pinParticipant(String participantId) async {
    final session = state.session;
    if (session == null) return;
    if (!_canManageParticipant(participantId)) {
      _denyModeration(participantId);
      return;
    }
    final updated = await _sessionRepository.pinParticipant(
      sessionId: session.id,
      participantId: participantId,
    );
    final pinned = updated.activeSpeakerId == participantId;
    emit(
      state.copyWith(
        session: updated,
        message: () => pinned ? 'Guest pinned to spotlight' : 'Guest unpinned',
      ),
    );
  }

  Future<void> endRoom() async {
    final session = state.session;
    if (session == null || !state.isHost) {
      emit(state.copyWith(message: () => 'Only the host can end the live'));
      return;
    }
    await _sessionRepository.endSession(sessionId: session.id);
    await _mediaCubit.stopCameraPreview();
    emit(
      state.copyWith(
        status: LiveRoomLoadStatus.ended,
        message: () => 'Live ended',
        hostControlsOpen: false,
        analyticsOpen: false,
        giftPanelOpen: false,
        giftDashboardOpen: false,
        commentSheetOpen: false,
      ),
    );
  }

  void toggleFollowHost() {
    final following = !state.isFollowingHost;
    emit(
      state.copyWith(
        isFollowingHost: following,
        hostAnalytics: following
            ? state.hostAnalytics.copyWith(
                newFollowers: state.hostAnalytics.newFollowers + 1,
              )
            : state.hostAnalytics,
      ),
    );
  }

  void openInbox() {
    emit(state.copyWith(unreadInbox: 0, commentSheetOpen: true));
  }

  void share() => emit(state.copyWith(message: () => 'shared'));

  void clearMessage() => emit(state.copyWith(message: () => null));

  void reportUser(String userId) {
    emit(state.copyWith(message: () => 'Report submitted'));
  }

  void blockUser(String userId) {
    emit(state.copyWith(message: () => 'User blocked'));
  }
}
