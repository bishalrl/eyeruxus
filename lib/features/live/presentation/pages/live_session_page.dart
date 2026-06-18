import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_interaction_scope.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_session_scope.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_session_shell.dart';
import 'package:eye_rex_us/shared/widgets/feature_bound_pages.dart';
import 'package:flutter/material.dart';

/// Unified live session page — scoped bloc + shell + legacy child.
class LiveSessionPage extends StatelessWidget {
  const LiveSessionPage({
    super.key,
    required this.scopeKey,
    required this.child,
    this.sessionType,
    this.embedded = false,
    this.roomId,
  });

  final String scopeKey;
  final String? sessionType;
  final Widget child;
  final bool embedded;
  final String? roomId;

  @override
  Widget build(BuildContext context) {
    return LiveSessionScope(
      child: LiveBoundPage(
        scopeKey: scopeKey,
        sessionType: sessionType,
        child: LiveSessionShell(
          embedded: embedded,
          child: embedded
              ? child
              : LiveRoomInteractionScope(
                  roomId: roomId ?? scopeKey,
                  child: child,
                ),
        ),
      ),
    );
  }
}
