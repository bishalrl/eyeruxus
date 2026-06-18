import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/features/agency/presentation/pages/agency_page.dart';
import 'package:eye_rex_us/features/auth/presentation/pages/auth_gate_page.dart';
import 'package:eye_rex_us/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:eye_rex_us/features/auth/presentation/pages/login_page.dart';
import 'package:eye_rex_us/features/auth/presentation/pages/otp_page.dart';
import 'package:eye_rex_us/features/auth/presentation/pages/signup_page.dart';
import 'package:eye_rex_us/features/chat_room/presentation/pages/chat_room_screens.dart';
import 'package:eye_rex_us/features/dev_tools/presentation/pages/app_launcher_page.dart';
import 'package:eye_rex_us/features/guardian_vip/presentation/pages/guardian_vip_page.dart';
import 'package:eye_rex_us/features/home/presentation/pages/reels_feed_page.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/reels/reels_scope.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_type.dart';
import 'package:eye_rex_us/features/live/presentation/pages/go_live_setup_page.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_room_browse_feed_page.dart';
import 'package:eye_rex_us/features/live/presentation/pages/live_rooms_page.dart';
import 'package:eye_rex_us/features/live/presentation/registry/live_session_registry.dart';
import 'package:eye_rex_us/features/host_money/presentation/pages/host_invite_pages.dart';
import 'package:eye_rex_us/features/host_money/presentation/pages/host_money_sub_pages.dart';
import 'package:eye_rex_us/features/host_money/presentation/pages/make_money_page.dart';
import 'package:eye_rex_us/features/settings/presentation/pages/settings_extra_screens.dart';
import 'package:eye_rex_us/features/settings/presentation/pages/settings_page.dart';
import 'package:eye_rex_us/features/settings/presentation/pages/settings_screens.dart';
import 'package:eye_rex_us/features/store/presentation/pages/store_page.dart';
import 'package:eye_rex_us/features/store/presentation/pages/store_screens.dart';
import 'package:eye_rex_us/features/wallet/presentation/pages/wallet_page.dart';
import 'package:eye_rex_us/shared/widgets/feature_bound_pages.dart';
import 'package:flutter/material.dart';

/// Single app router — all navigation goes through here.
abstract final class AppRouter {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static Future<T?>? navigateTo<T>(
    String routeName, {
    Object? arguments,
  }) {
    return navigatorKey.currentState?.pushNamed<T>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T>(
    BuildContext context,
    String routeName, {
    Object? arguments,
  }) {
    return Navigator.of(context).pushReplacementNamed<T, void>(
      routeName,
      arguments: arguments,
    );
  }

  static Future<T?> pushPage<T>(
    BuildContext context,
    Widget page, {
    bool fullscreen = false,
    String? routeName,
  }) {
    return Navigator.of(context).push<T>(
      MaterialPageRoute(
        fullscreenDialog: fullscreen,
        settings: RouteSettings(name: routeName),
        builder: (_) => page,
      ),
    );
  }

  static void pop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).pop(result);
  }

  static void maybePop<T>(BuildContext context, [T? result]) {
    Navigator.of(context).maybePop(result);
  }

  static Route<dynamic> _route(Widget page, RouteSettings settings) {
    return MaterialPageRoute(
      settings: settings,
      builder: (_) => page,
    );
  }

  static Route<dynamic>? onGenerateRoute(RouteSettings settings) {
    final name = settings.name ?? AppRouteNames.authGate;

    switch (name) {
      case AppRouteNames.authGate:
        return _route(const AuthGatePage(), settings);
      case AppRouteNames.login:
        return _route(const LoginPage(), settings);
      case AppRouteNames.signup:
        return _route(const SignupPage(), settings);
      case AppRouteNames.forgotPassword:
        return _route(const ForgotPasswordPage(), settings);
      case AppRouteNames.otp:
        final args = settings.arguments as OtpRouteArgs?;
        return _route(OtpPage(phoneNumber: args?.phoneNumber), settings);
      case AppRouteNames.goLive:
        return _route(const GoLiveSetupPage(), settings);
      case AppRouteNames.reelsFeed:
        final args = settings.arguments as ReelsFeedRouteArgs? ??
            const ReelsFeedRouteArgs();
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (_) => ReelsScope(
            initialTab: args.feedTab,
            initialIndex: args.initialIndex,
            child: const ReelsFeedPage(),
          ),
        );
      case AppRouteNames.chatRoom:
        final args = settings.arguments! as ChatRoomRouteArgs;
        return _route(
          ChatRoomLayoutPage(
            roomId: args.roomId,
            role: args.role,
            instantJoinSeat: args.instantJoinSeat,
            preferredSeatIndex: args.preferredSeatIndex,
            partyTitle: args.partyTitle,
          ),
          settings,
        );
      case AppRouteNames.liveBrowse:
        final args = settings.arguments! as LiveRoomBrowseRouteArgs;
        return MaterialPageRoute(
          fullscreenDialog: true,
          settings: settings,
          builder: (_) => LiveRoomBrowseFeedPage(args: args),
        );
      case AppRouteNames.liveSession:
        final type = settings.arguments! as LiveSessionType;
        return _route(LiveSessionRegistry.buildPage(type: type), settings);
      case AppRouteNames.liveRooms:
        return _route(const LiveRoomsRoute(), settings);
      case AppRouteNames.settings:
        return _route(const SettingsBoundPage(child: SettingsPage()), settings);
      case AppRouteNames.store:
        return _route(const StoreBoundPage(child: StorePage()), settings);
      case AppRouteNames.wallet:
      case AppRouteNames.withdraw:
        return _route(const WalletBoundPage(child: WalletPage()), settings);
      case AppRouteNames.agency:
        return _route(const AgencyPage(), settings);
      case AppRouteNames.guardianVip:
        return _route(const GuardianVipPage(), settings);
      case AppRouteNames.devLauncher:
        return _route(const AppLauncherPage(), settings);
      case AppRouteNames.privilegeSettings:
        return _route(const PrivilegeSettingsPage(), settings);
      case AppRouteNames.newMessagesNotification:
        return _route(const NewMessagesNotificationPage(), settings);
      case AppRouteNames.pointDetails:
        return _route(const SettingsPointDetailsPage(), settings);
      case AppRouteNames.exchangeCoins:
        return _route(const ExchangeCoinsPage(), settings);
      case AppRouteNames.accountSecurity:
        return _route(const AccountSecurityPage(), settings);
      case AppRouteNames.paymentMethods:
        return _route(const PaymentMethodsPage(), settings);
      case AppRouteNames.bankDetails:
        return _route(const BankDetailsPage(), settings);
      case AppRouteNames.transfer:
        return _route(const TransferPage(), settings);
      case AppRouteNames.points:
        return _route(const PointsPage(), settings);
      case AppRouteNames.myAgency:
        return _route(const MyAgencyPage(), settings);
      case AppRouteNames.makeMoney:
        return _route(const MakeMoneyPage(), settings);
      case AppRouteNames.addHost:
        return _route(const AddHostPage(), settings);
      case AppRouteNames.inviteAgent:
        return _route(const InviteAgentPage(), settings);
      case AppRouteNames.coinsTrading:
        return _route(const CoinsTradingPage(), settings);
      case AppRouteNames.ranking:
        return _route(const RankingPage(), settings);
      case AppRouteNames.hostRewards:
        return _route(const HostRewardsPage(), settings);
      case AppRouteNames.liveData:
        return _route(const LiveDataDetailPage(), settings);
      case AppRouteNames.superFunds:
        return _route(const HostSuperFundsPage(), settings);
      case AppRouteNames.friends:
        return _route(const FriendsPage(), settings);
      case AppRouteNames.storeHonorMall:
        return _route(const StoreHonorMallPage(), settings);
      case AppRouteNames.storeRareId:
        return _route(const StoreRareIdPage(), settings);
      case AppRouteNames.storeRides:
        return _route(const StoreRidesPage(), settings);
      case AppRouteNames.storeProfileCard:
        return _route(const StoreProfileCardPage(), settings);
      case AppRouteNames.storeAvatarFrame:
        return _route(const StoreAvatarFramePage(), settings);
      case AppRouteNames.storePartyTheme:
        return _route(const StorePartyThemePage(), settings);
      case AppRouteNames.storeRoomBubble:
        return _route(const StoreRoomBubblePage(), settings);
      default:
        return _route(const AuthGatePage(), settings);
    }
  }
}
