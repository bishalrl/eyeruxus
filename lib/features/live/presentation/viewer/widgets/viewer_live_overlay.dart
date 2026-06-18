import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/viewer/widgets/viewer_live_bottom_bar.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_comment_strip.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_gift_panel.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_like_burst_layer.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_bottom_bar.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_sheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Viewer-only overlay — social actions, no host/moderation controls.
class ViewerLiveOverlay extends StatelessWidget {
  const ViewerLiveOverlay({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return MultiBlocListener(
      listeners: [
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (p, c) => c.message != null && p.message != c.message,
          listener: (context, state) {
            final text = state.message == 'shared' ? l10n.liveRoomShared : state.message!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(text), behavior: SnackBarBehavior.floating),
            );
            context.read<LiveRoomInteractionCubit>().clearMessage();
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (p, c) => !p.giftPanelOpen && c.giftPanelOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => BlocProvider.value(
                value: context.read<LiveRoomInteractionCubit>(),
                child: const LiveGiftPanel(),
              ),
            );
            if (context.mounted) {
              context.read<LiveRoomInteractionCubit>().closeGiftPanel();
            }
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (p, c) => !p.commentSheetOpen && c.commentSheetOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (_) => BlocProvider.value(
                value: context.read<LiveRoomInteractionCubit>(),
                child: LiveCommentSheet(roomId: roomId),
              ),
            );
            if (context.mounted) {
              context.read<LiveRoomInteractionCubit>().closeCommentSheet();
            }
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (p, c) => !p.moreMenuOpen && c.moreMenuOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              backgroundColor: const Color(0xFF1A1010),
              builder: (_) => BlocProvider.value(
                value: context.read<LiveRoomInteractionCubit>(),
                child: const ViewerMoreSheet(),
              ),
            );
            if (context.mounted) {
              context.read<LiveRoomInteractionCubit>().closeMoreMenu();
            }
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (p, c) => !p.seatSheetOpen && c.seatSheetOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              backgroundColor: const Color(0xFF1A1010),
              builder: (_) => BlocProvider.value(
                value: context.read<LiveRoomInteractionCubit>(),
                child: LiveRoomSeatSheet(seatCount: state.seatCount),
              ),
            );
            if (context.mounted) {
              context.read<LiveRoomInteractionCubit>().closeSeatSheet();
            }
          },
        ),
      ],
      child: BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
        builder: (context, state) {
          return Positioned.fill(
            child: Stack(
              children: [
                IgnorePointer(child: LiveLikeBurstLayer(bursts: state.likeBursts)),
                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 88 + bottomInset,
                  child: LiveCommentStrip(comments: state.comments, maxHeight: 100),
                ),
                for (final event in state.giftEvents)
                  _GiftToast(key: ValueKey(event.id), event: event),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: bottomInset,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.joinBanner != null)
                        LiveRoomJoinBanner(message: state.joinBanner!),
                      const ViewerLiveBottomBar(),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ViewerMoreSheet extends StatelessWidget {
  const ViewerMoreSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveRoomInteractionCubit>();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.share_outlined, color: Colors.white),
              title: const Text('Share room', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                cubit.share();
              },
            ),
            ListTile(
              leading: const Icon(Icons.report_outlined, color: Colors.white),
              title: const Text('Report user', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                cubit.reportUser('host');
              },
            ),
            ListTile(
              leading: const Icon(Icons.block, color: Colors.white),
              title: const Text('Block user', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                cubit.blockUser('host');
              },
            ),
            ListTile(
              leading: const Icon(Icons.exit_to_app, color: Colors.redAccent),
              title: const Text('Leave room', style: TextStyle(color: Colors.redAccent)),
              onTap: () {
                Navigator.pop(context);
                cubit.leaveRoom();
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _GiftToast extends StatelessWidget {
  const _GiftToast({super.key, required this.event});

  final LiveGiftEvent event;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: 12,
      bottom: 200,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.black54,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(event.gift.emoji, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: 8),
            Text(event.senderName, style: const TextStyle(color: Colors.white, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
