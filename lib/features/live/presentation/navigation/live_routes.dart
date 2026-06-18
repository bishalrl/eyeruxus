import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_room.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_type.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_rooms_page.dart';
import 'package:eye_rex_us/features/live/presentation/registry/live_session_registry.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:flutter/material.dart';

/// Navigation registry for live session screens.
abstract final class LiveRoutes {
  static void push(BuildContext context, Widget page) =>
      AppRouter.pushPage(context, page);

  static void openGoLive(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.goLive);
  }

  static void openLiveRoom(BuildContext context, LiveRoom room) {
    final type = LiveSessionRegistry.pageTypeForSessionType(room.sessionType);
    AppRouter.pushNamed(context, AppRouteNames.liveSession, arguments: type);
  }

  static Widget pageForSessionType(String sessionType) {
    final type = LiveSessionRegistry.pageTypeForSessionType(sessionType);
    return LiveSessionRegistry.buildPage(type: type);
  }

  static List<LiveRouteItem> liveScreens() {
    return [
      for (final item in LiveSessionRegistry.discoverItems)
        LiveRouteItem(
          icon: item.icon,
          labelKey: item.labelKey,
          sessionType: item.sessionType,
          page: item.page,
          sessionTypeEnum: item.type,
        ),
      const LiveRouteItem(
        icon: Icons.live_tv,
        labelKey: 'liveRoomsTitle',
        page: LiveRoomsRoute(),
      ),
    ];
  }
}

class LiveRouteItem {
  const LiveRouteItem({
    required this.icon,
    required this.labelKey,
    required this.page,
    this.sessionType,
    this.sessionTypeEnum,
  });

  final IconData icon;
  final String labelKey;
  final Widget page;
  final String? sessionType;
  final LiveSessionType? sessionTypeEnum;

  void open(BuildContext context) {
    if (sessionTypeEnum != null) {
      AppRouter.pushNamed(
        context,
        AppRouteNames.liveSession,
        arguments: sessionTypeEnum,
      );
      return;
    }
    AppRouter.pushPage(context, page);
  }
}
