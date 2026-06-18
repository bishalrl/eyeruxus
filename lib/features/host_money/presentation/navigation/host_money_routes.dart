import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:flutter/material.dart';

abstract final class HostMoneyRoutes {
  static void openMakeMoney(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.makeMoney);
  }

  static void openAddHost(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.addHost);
  }

  static void openInviteAgent(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.inviteAgent);
  }

  static void openCoinsTrading(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.coinsTrading);
  }

  static void openRanking(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.ranking);
  }

  static void openHostRewards(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.hostRewards);
  }

  static void openLiveData(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.liveData);
  }

  static void openMyAgency(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.myAgency);
  }

  static void openSuperFunds(BuildContext context) {
    AppRouter.pushNamed(context, AppRouteNames.superFunds);
  }
}
