import 'package:eye_rex_us/UI/Screens/LiveScreens/audi_screen.dart';
import 'package:eye_rex_us/UI/Screens/LiveScreens/preview_red_screen.dart';
import 'package:eye_rex_us/UI/Screens/LiveScreens/preview_window.dart';
import 'package:eye_rex_us/UI/Screens/LiveScreens/video_battle.dart';
import 'package:eye_rex_us/UI/Screens/LiveScreens/video_live_screen.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_type.dart';
import 'package:eye_rex_us/features/live/presentation/constants/live_scope_keys.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_session_page.dart';
import 'package:eye_rex_us/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class LiveSessionDefinition {
  const LiveSessionDefinition({
    required this.type,
    required this.scopeKey,
    required this.labelKey,
    required this.icon,
    required this.page,
    this.sessionType,
  });

  final LiveSessionType type;
  final String scopeKey;
  final String labelKey;
  final IconData icon;
  final Widget page;
  final String? sessionType;
}

/// Central registry for live session screens — routing, labels, and scope keys.
abstract final class LiveSessionRegistry {
  static LiveSessionPage buildPage({
    required LiveSessionType type,
    bool embedded = false,
  }) {
    return switch (type) {
      LiveSessionType.videoRoom => LiveSessionPage(
          scopeKey: LiveScopeKeys.session(LiveSessionType.videoRoom.apiValue),
          sessionType: LiveSessionType.videoRoom.apiValue,
          embedded: embedded,
          child: const LiveRoomScreen1(),
        ),
      LiveSessionType.audioRoom => LiveSessionPage(
          scopeKey: LiveScopeKeys.session(LiveSessionType.audioRoom.apiValue),
          sessionType: LiveSessionType.audioRoom.apiValue,
          embedded: embedded,
          child: const PrevieAudio(),
        ),
      LiveSessionType.party => LiveSessionPage(
          scopeKey: LiveScopeKeys.session(LiveSessionType.party.apiValue),
          sessionType: LiveSessionType.party.apiValue,
          embedded: embedded,
          child: const ReviewPartyScreen(),
        ),
      LiveSessionType.videoBattle => LiveSessionPage(
          scopeKey: LiveScopeKeys.session(LiveSessionType.videoBattle.apiValue),
          sessionType: LiveSessionType.videoBattle.apiValue,
          embedded: embedded,
          child: const LiveBattleScreen(),
        ),
      LiveSessionType.previewWindow => LiveSessionPage(
          scopeKey: LiveScopeKeys.previewWindow,
          embedded: embedded,
          child: const PreviewWindow(),
        ),
      LiveSessionType.dashboard => LiveSessionPage(
          scopeKey: LiveScopeKeys.dashboard,
          embedded: embedded,
          child: const DashboardScreen(),
        ),
    };
  }

  static const discoverItems = <LiveSessionDefinition>[
    LiveSessionDefinition(
      type: LiveSessionType.videoRoom,
      scopeKey: 'session_video_room',
      labelKey: 'liveScreenVideo',
      icon: Icons.videocam,
      sessionType: 'video_room',
      page: LiveVideoRoomPage(),
    ),
    LiveSessionDefinition(
      type: LiveSessionType.audioRoom,
      scopeKey: 'session_audio_room',
      labelKey: 'liveScreenAudio',
      icon: Icons.mic,
      sessionType: 'audio_room',
      page: LiveAudioPreviewPage(),
    ),
    LiveSessionDefinition(
      type: LiveSessionType.party,
      scopeKey: 'session_party',
      labelKey: 'liveScreenParty',
      icon: Icons.celebration,
      sessionType: 'party',
      page: LiveReviewPartyPage(),
    ),
    LiveSessionDefinition(
      type: LiveSessionType.videoBattle,
      scopeKey: 'session_video_battle',
      labelKey: 'liveScreenBattle',
      icon: Icons.sports_mma,
      sessionType: 'video_battle',
      page: LiveBattlePage(),
    ),
    LiveSessionDefinition(
      type: LiveSessionType.previewWindow,
      scopeKey: LiveScopeKeys.previewWindow,
      labelKey: 'liveScreenPreview',
      icon: Icons.window,
      page: LivePreviewWindowPage(),
    ),
    LiveSessionDefinition(
      type: LiveSessionType.dashboard,
      scopeKey: LiveScopeKeys.dashboard,
      labelKey: 'liveScreenDashboard',
      icon: Icons.dashboard,
      page: LiveDashboardPage(),
    ),
  ];

  static String labelFor(AppLocalizations l10n, String labelKey) {
    return switch (labelKey) {
      'liveScreenVideo' => l10n.liveScreenVideo,
      'liveScreenAudio' => l10n.liveScreenAudio,
      'liveScreenParty' => l10n.liveScreenParty,
      'liveScreenBattle' => l10n.liveScreenBattle,
      'liveScreenPreview' => l10n.liveScreenPreview,
      'liveScreenDashboard' => l10n.liveScreenDashboard,
      _ => labelKey,
    };
  }

  static LiveSessionType pageTypeForSessionType(String sessionType) {
    return LiveSessionType.fromApiValue(sessionType) ?? LiveSessionType.videoRoom;
  }
}

// Thin public aliases — keeps imports stable across the app.
class LiveAudioPreviewPage extends StatelessWidget {
  const LiveAudioPreviewPage({super.key, this.embedded = false});
  final bool embedded;
  @override
  Widget build(BuildContext context) =>
      LiveSessionRegistry.buildPage(type: LiveSessionType.audioRoom, embedded: embedded);
}

class LiveVideoRoomPage extends StatelessWidget {
  const LiveVideoRoomPage({super.key, this.embedded = false});
  final bool embedded;
  @override
  Widget build(BuildContext context) =>
      LiveSessionRegistry.buildPage(type: LiveSessionType.videoRoom, embedded: embedded);
}

class LiveReviewPartyPage extends StatelessWidget {
  const LiveReviewPartyPage({super.key, this.embedded = false});
  final bool embedded;
  @override
  Widget build(BuildContext context) =>
      LiveSessionRegistry.buildPage(type: LiveSessionType.party, embedded: embedded);
}

class LiveBattlePage extends StatelessWidget {
  const LiveBattlePage({super.key, this.embedded = false});
  final bool embedded;
  @override
  Widget build(BuildContext context) =>
      LiveSessionRegistry.buildPage(type: LiveSessionType.videoBattle, embedded: embedded);
}

class LivePreviewWindowPage extends StatelessWidget {
  const LivePreviewWindowPage({super.key, this.embedded = false});
  final bool embedded;
  @override
  Widget build(BuildContext context) =>
      LiveSessionRegistry.buildPage(type: LiveSessionType.previewWindow, embedded: embedded);
}

class LiveDashboardPage extends StatelessWidget {
  const LiveDashboardPage({super.key, this.embedded = false});
  final bool embedded;
  @override
  Widget build(BuildContext context) =>
      LiveSessionRegistry.buildPage(type: LiveSessionType.dashboard, embedded: embedded);
}
