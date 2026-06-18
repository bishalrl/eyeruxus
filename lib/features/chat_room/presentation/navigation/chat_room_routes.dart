import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/features/chat_room/presentation/pages/chat_room_screens.dart';
import 'package:eye_rex_us/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

/// Live room layout screens — legacy `HomeScreen` UIs by seat count.
abstract final class ChatRoomRoutes {
  static void push(BuildContext context, Widget page) {
    AppRouter.pushPage(context, page);
  }

  static void openRoom(BuildContext context, String roomId) {
    AppRouter.pushNamed(
      context,
      AppRouteNames.chatRoom,
      arguments: ChatRoomRouteArgs(roomId: roomId),
    );
  }

  /// Go Live picker — primary seat layouts (scrollable, excludes Ludo).
  static const goLivePickerItems = <ChatRoomRouteItem>[
    ChatRoomRouteItem(
      roomId: 'movie',
      seats: 1,
      labelKey: 'liveLayoutSingle',
      page: ChatRoomMoviePage(),
    ),
    ChatRoomRouteItem(
      roomId: 'pk',
      seats: 2,
      labelKey: 'liveLayout2',
      page: ChatRoomPkPage(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_3',
      seats: 3,
      labelKey: 'liveLayout3',
      page: ChatRoom3Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_4',
      seats: 4,
      labelKey: 'liveLayout4',
      page: ChatRoom4Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_6',
      seats: 6,
      labelKey: 'liveLayout6',
      page: ChatRoom6Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_8',
      seats: 8,
      labelKey: 'liveLayout8',
      page: ChatRoom8Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_16',
      seats: 16,
      labelKey: 'liveLayout16',
      page: ChatRoom16Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_32',
      seats: 32,
      labelKey: 'liveLayout32',
      page: ChatRoom32Page(),
    ),
  ];

  /// Discover tab + Go Live layout picker — ordered by seat count.
  static const liveLayoutItems = <ChatRoomRouteItem>[
    ChatRoomRouteItem(
      roomId: 'movie',
      seats: 1,
      labelKey: 'liveLayoutSingle',
      page: ChatRoomMoviePage(),
    ),
    ChatRoomRouteItem(
      roomId: 'pk',
      seats: 2,
      labelKey: 'liveLayout2',
      page: ChatRoomPkPage(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_3',
      seats: 3,
      labelKey: 'liveLayout3',
      page: ChatRoom3Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_4',
      seats: 4,
      labelKey: 'liveLayout4',
      page: ChatRoom4Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_6',
      seats: 6,
      labelKey: 'liveLayout6',
      page: ChatRoom6Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_8',
      seats: 8,
      labelKey: 'liveLayout8',
      page: ChatRoom8Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_10',
      seats: 10,
      labelKey: 'liveLayout10',
      page: ChatRoom10Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_12',
      seats: 12,
      labelKey: 'liveLayout12',
      page: ChatRoom12Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_16',
      seats: 16,
      labelKey: 'liveLayout16',
      page: ChatRoom16Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_32',
      seats: 32,
      labelKey: 'liveLayout32',
      page: ChatRoom32Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_18',
      seats: 18,
      labelKey: 'liveLayout18',
      page: ChatRoom18Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_20',
      seats: 20,
      labelKey: 'liveLayout20',
      page: ChatRoom20Page(),
    ),
    ChatRoomRouteItem(
      roomId: 'room_ludo',
      seats: 4,
      labelKey: 'liveLayoutLudo',
      page: ChatRoom11Page(),
    ),
  ];

  static const menuItems = liveLayoutItems;

  static String labelFor(AppLocalizations l10n, String labelKey) {
    return switch (labelKey) {
      'liveLayoutSingle' => l10n.liveLayoutSingle,
      'liveLayout2' => l10n.liveLayout2,
      'liveLayout3' => l10n.liveLayout3,
      'liveLayout4' => l10n.liveLayout4,
      'liveLayout6' => '6 seats',
      'liveLayout8' => l10n.liveLayout8,
      'liveLayout10' => l10n.liveLayout10,
      'liveLayout12' => l10n.liveLayout12,
      'liveLayout16' => l10n.liveLayout16,
      'liveLayout32' => '32 seats',
      'liveLayout18' => l10n.liveLayout18,
      'liveLayout20' => l10n.liveLayout20,
      'liveLayoutLudo' => l10n.liveLayoutLudo,
      _ => labelKey,
    };
  }

  static Widget? pageForRoomId(String roomId) {
    for (final item in liveLayoutItems) {
      if (item.roomId == roomId) return item.page;
    }
    return null;
  }

  static ChatRoomRouteItem? itemForSeats(int seats) {
    for (final item in liveLayoutItems) {
      if (item.seats == seats && item.labelKey != 'liveLayoutLudo') {
        return item;
      }
    }
    return null;
  }
}

class ChatRoomRouteItem {
  const ChatRoomRouteItem({
    required this.roomId,
    required this.seats,
    required this.labelKey,
    required this.page,
  });

  final String roomId;
  final int seats;
  final String labelKey;
  final Widget page;

  void open(BuildContext context) => ChatRoomRoutes.openRoom(context, roomId);
}
