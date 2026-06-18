import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:flutter/material.dart';

abstract final class ProfileRoutes {
  static void openStore(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.store);
  }

  static void openWallet(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.wallet);
  }

  static void openVip(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.guardianVip);
  }

  static void openAccountSecurity(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.accountSecurity);
  }

  static void openMyAgency(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.myAgency);
  }

  static void openFriends(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.friends);
  }

  static void openMakeMoney(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.makeMoney);
  }

  static void openPoints(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.points);
  }

  static void openHostRewards(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.hostRewards);
  }

  static void openRanking(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.ranking);
  }

  static void openInvite(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.friends);
  }

  static void openSettings(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.settings);
  }
}
