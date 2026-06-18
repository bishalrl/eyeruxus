import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/chat_room/presentation/navigation/chat_room_routes.dart';
import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/home_live_routes.dart';
import 'package:flutter/material.dart';

/// Maps home feed items and menus to feature screens via [AppRouter].
abstract final class HomeLegacyRoutes {
  static void push(BuildContext context, Widget page) {
    AppRouter.pushPage(context, page);
  }

  static void pushNamed(BuildContext context, String routeName) {
    AppRouter.pushNamed(context, routeName);
  }

  static void openFeedRoom(BuildContext context, RoomEntity room) {
    HomeLiveRoutes.openFeedRoom(context, room);
  }

  static void openGoLive(BuildContext context) {
    HomeLiveRoutes.openGoLive(context);
  }

  static List<HomeLegacyMenuItem> liveScreens(BuildContext context) {
    final l10n = context.l10n;
    return HomeLiveRoutes.all(l10n)
        .map(
          (item) => HomeLegacyMenuItem(
            icon: item.icon,
            label: item.label,
            onTap: (ctx) => item.open(ctx),
          ),
        )
        .toList();
  }

  static List<HomeLegacyMenuItem> chatRooms(BuildContext context) {
    final l10n = context.l10n;
    return ChatRoomRoutes.liveLayoutItems
        .map(
          (item) => HomeLegacyMenuItem(
            icon: Icons.live_tv,
            label: ChatRoomRoutes.labelFor(l10n, item.labelKey),
            onTap: (ctx) => item.open(ctx),
          ),
        )
        .toList();
  }

  static List<HomeLegacyMenuItem> accountAndTools() => [
        HomeLegacyMenuItem(
          icon: Icons.settings,
          label: 'Settings',
          routeName: AppRouteNames.settings,
        ),
        HomeLegacyMenuItem(
          icon: Icons.storefront,
          label: 'Store',
          routeName: AppRouteNames.store,
        ),
        HomeLegacyMenuItem(
          icon: Icons.account_balance_wallet,
          label: 'Wallet',
          routeName: AppRouteNames.wallet,
        ),
        HomeLegacyMenuItem(
          icon: Icons.diamond,
          label: 'VIP & Guardian',
          routeName: AppRouteNames.guardianVip,
        ),
        HomeLegacyMenuItem(
          icon: Icons.security,
          label: 'Account Security',
          routeName: AppRouteNames.accountSecurity,
        ),
        HomeLegacyMenuItem(
          icon: Icons.workspace_premium,
          label: 'Privilege Settings',
          routeName: AppRouteNames.privilegeSettings,
        ),
        HomeLegacyMenuItem(
          icon: Icons.payment,
          label: 'Payment Methods',
          routeName: AppRouteNames.paymentMethods,
        ),
        HomeLegacyMenuItem(
          icon: Icons.account_balance,
          label: 'Bank Details',
          routeName: AppRouteNames.bankDetails,
        ),
        HomeLegacyMenuItem(
          icon: Icons.swap_horiz,
          label: 'Transfer',
          routeName: AppRouteNames.transfer,
        ),
        HomeLegacyMenuItem(
          icon: Icons.monetization_on,
          label: 'Exchange Coins',
          routeName: AppRouteNames.exchangeCoins,
        ),
        HomeLegacyMenuItem(
          icon: Icons.stars,
          label: 'Points',
          routeName: AppRouteNames.points,
        ),
        HomeLegacyMenuItem(
          icon: Icons.business,
          label: 'Host Application',
          routeName: AppRouteNames.agency,
        ),
        HomeLegacyMenuItem(
          icon: Icons.groups_3,
          label: 'My Agency',
          routeName: AppRouteNames.myAgency,
        ),
        HomeLegacyMenuItem(
          icon: Icons.person_add,
          label: 'Make Money / Host',
          routeName: AppRouteNames.makeMoney,
        ),
        HomeLegacyMenuItem(
          icon: Icons.people,
          label: 'Friends',
          routeName: AppRouteNames.friends,
        ),
        HomeLegacyMenuItem(
          icon: Icons.apps,
          label: 'All Screens',
          routeName: AppRouteNames.devLauncher,
        ),
      ];
}

class HomeLegacyMenuItem {
  const HomeLegacyMenuItem({
    required this.icon,
    required this.label,
    this.routeName,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? routeName;
  final void Function(BuildContext context)? onTap;

  void open(BuildContext context) {
    if (onTap != null) {
      onTap!(context);
      return;
    }
    if (routeName != null) {
      AppRouter.pushNamed(context, routeName!);
    }
  }
}
