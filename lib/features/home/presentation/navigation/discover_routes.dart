import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/app/router/app_route_names.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:flutter/material.dart';

abstract final class DiscoverRoutes {
  static void openReelsFeed(
    BuildContext context, {
    int initialIndex = 0,
    ReelsFeedTab feedTab = ReelsFeedTab.forYou,
  }) {
    AppRouter.pushNamed(
      context,
      AppRouteNames.reelsFeed,
      arguments: ReelsFeedRouteArgs(
        initialIndex: initialIndex,
        feedTab: feedTab,
      ),
    );
  }
}
