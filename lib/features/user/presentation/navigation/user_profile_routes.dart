import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:flutter/material.dart';

abstract final class UserProfileRoutes {
  static void openFromParticipant(
    BuildContext context,
    LiveParticipant participant,
  ) {
    AppRouter.pushNamed(
      context,
      AppRouteNames.userProfile,
      arguments: UserProfileRouteArgs(
        userId: participant.id,
        displayName: participant.name,
        avatarUrl: participant.avatarUrl,
      ),
    );
  }
}
