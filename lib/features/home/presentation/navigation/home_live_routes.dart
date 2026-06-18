import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/home_feed_room_resolver.dart';
import 'package:eye_rex_us/features/live/presentation/navigation/live_routes.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_rooms_page.dart';
import 'package:eye_rex_us/features/live/presentation/registry/live_session_registry.dart';
import 'package:eye_rex_us/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

export 'package:eye_rex_us/features/live/presentation/navigation/live_routes.dart'
    show LiveRouteItem, LiveRoutes;

/// Home tab navigation for live sessions (delegates to [AppRouter]).
abstract final class HomeLiveRoutes {
  static void push(BuildContext context, Widget page) =>
      LiveRoutes.push(context, page);

  static void openGoLive(BuildContext context) => LiveRoutes.openGoLive(context);

  static void openFeedRoom(BuildContext context, RoomEntity room) {
    openBrowseFeed(context, rooms: [room], initialRoom: room);
  }

  /// Vertical swipe feed — browse lives, request a seat on any room you like.
  static void openBrowseFeed(
    BuildContext context, {
    required List<RoomEntity> rooms,
    required RoomEntity initialRoom,
    int? preferredSeatIndex,
  }) {
    if (rooms.isEmpty) return;

    final initialIndex = rooms.indexWhere((r) => r.id == initialRoom.id);
    final index = initialIndex >= 0 ? initialIndex : 0;

    AppRouter.pushNamed(
      context,
      AppRouteNames.liveBrowse,
      arguments: LiveRoomBrowseRouteArgs(
        initialIndex: index,
        initialSeatRequestIndex: preferredSeatIndex,
        entries: rooms
            .map(
              (room) => LiveRoomBrowseEntry(
                roomId: HomeFeedRoomResolver.layoutRoomIdFor(room),
                title: room.title,
                partyId: room.id,
              ),
            )
            .toList(),
      ),
    );
  }

  /// @deprecated Use [openBrowseFeed].
  static void watchFeedRoom(BuildContext context, RoomEntity room) {
    openBrowseFeed(context, rooms: [room], initialRoom: room);
  }

  /// @deprecated Use [openBrowseFeed].
  static void requestFeedRoomSeat(
    BuildContext context,
    RoomEntity room,
    int seatIndex,
  ) {
    openBrowseFeed(
      context,
      rooms: [room],
      initialRoom: room,
      preferredSeatIndex: seatIndex,
    );
  }

  static List<HomeLiveMenuItem> all(AppLocalizations l10n) {
    return LiveRoutes.liveScreens()
        .where((item) => item.page is! LiveRoomsRoute)
        .map(
          (item) => HomeLiveMenuItem(
            icon: item.icon,
            label: _labelFor(l10n, item.labelKey),
            routeItem: item,
          ),
        )
        .toList();
  }

  static String _labelFor(AppLocalizations l10n, String labelKey) {
    if (labelKey == 'liveRoomsTitle') return l10n.liveRoomsTitle;
    return LiveSessionRegistry.labelFor(l10n, labelKey);
  }
}

class HomeLiveMenuItem {
  const HomeLiveMenuItem({
    required this.icon,
    required this.label,
    required this.routeItem,
  });

  final IconData icon;
  final String label;
  final LiveRouteItem routeItem;

  void open(BuildContext context) => routeItem.open(context);
}
