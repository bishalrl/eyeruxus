import 'package:eye_rex_us/app/router/app_route_args.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/live/presentation/viewer/viewer_live_room_page.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_interaction_scope.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_session_scope.dart';
import 'package:eye_rex_us/shared/widgets/feature_bound_pages.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Full-screen vertical feed of live rooms — swipe to browse, tap + to request a seat.
class LiveRoomBrowseFeedPage extends StatefulWidget {
  const LiveRoomBrowseFeedPage({super.key, required this.args});

  final LiveRoomBrowseRouteArgs args;

  @override
  State<LiveRoomBrowseFeedPage> createState() => _LiveRoomBrowseFeedPageState();
}

class _LiveRoomBrowseFeedPageState extends State<LiveRoomBrowseFeedPage> {
  late final PageController _pageController;

  LiveRoomBrowseRouteArgs get args => widget.args;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: args.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.paddingOf(context).top;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          fit: StackFit.expand,
          children: [
            PageView.builder(
              controller: _pageController,
              scrollDirection: Axis.vertical,
              itemCount: args.entries.length,
              itemBuilder: (context, index) {
                final entry = args.entries[index];
                final isInitial = index == args.initialIndex;

                return LiveSessionScope(
                  key: ValueKey('live_browse_${entry.roomId}_$index'),
                  chatRoom: true,
                  child: ChatRoomBoundPage(
                    roomId: entry.roomId,
                    child: LiveRoomInteractionScope(
                      roomId: entry.roomId,
                      partyTitle: entry.title,
                      instantJoinSeat: args.instantJoinSeat && isInitial,
                      preferredSeatIndex:
                          isInitial ? args.initialSeatRequestIndex : null,
                      child: ViewerLiveRoomPage(roomId: entry.roomId),
                    ),
                  ),
                );
              },
            ),
            Positioned(
              top: topPadding + 4,
              left: 4,
              child: IconButton(
                onPressed: () => AppRouter.maybePop(context),
                icon: const Icon(Icons.close, color: Colors.white),
              ),
            ),
            if (args.entries.length > 1)
              Positioned(
                right: 12,
                bottom: 140,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.swipe_vertical, color: Colors.white70, size: 16),
                      SizedBox(width: 6),
                      Text(
                        'Swipe for next live',
                        style: TextStyle(color: Colors.white70, fontSize: 11),
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
