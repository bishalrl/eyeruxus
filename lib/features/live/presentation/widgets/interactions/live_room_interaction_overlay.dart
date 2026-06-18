import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/moderation/live_host_controls_sheet.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_comment_strip.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_gift_panel.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_like_burst_layer.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_bottom_bar.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_overlay_mode.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_sheets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LiveRoomInteractionOverlay extends StatelessWidget {
  const LiveRoomInteractionOverlay({
    super.key,
    required this.roomId,
    this.mode = LiveRoomOverlayMode.legacy,
  });

  final String roomId;
  final LiveRoomOverlayMode mode;

  bool get _legacy => mode == LiveRoomOverlayMode.legacy;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return MultiBlocListener(
      listeners: [
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (prev, curr) =>
              curr.message != null && prev.message != curr.message,
          listener: (context, state) {
            final text = state.message == 'shared'
                ? l10n.liveRoomShared
                : state.message!;
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(text),
                behavior: SnackBarBehavior.floating,
                duration: const Duration(seconds: 2),
              ),
            );
            context.read<LiveRoomInteractionCubit>().clearMessage();
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (prev, curr) =>
              !prev.giftPanelOpen && curr.giftPanelOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (sheetContext) => BlocProvider.value(
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
          listenWhen: (prev, curr) =>
              !prev.commentSheetOpen && curr.commentSheetOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (sheetContext) => BlocProvider.value(
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
          listenWhen: (prev, curr) => !prev.moreMenuOpen && curr.moreMenuOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              backgroundColor: const Color(0xFF2A1010),
              builder: (sheetContext) => BlocProvider.value(
                value: context.read<LiveRoomInteractionCubit>(),
                child: const LiveRoomMoreSheet(),
              ),
            );
            if (context.mounted) {
              context.read<LiveRoomInteractionCubit>().closeMoreMenu();
            }
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (prev, curr) =>
              !prev.hostControlsOpen && curr.hostControlsOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xFF2A1010),
              builder: (sheetContext) => BlocProvider.value(
                value: context.read<LiveRoomInteractionCubit>(),
                child: const LiveHostControlsSheet(),
              ),
            );
            if (context.mounted) {
              context.read<LiveRoomInteractionCubit>().closeHostControls();
            }
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (prev, curr) => !prev.seatSheetOpen && curr.seatSheetOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              backgroundColor: const Color(0xFF2A1010),
              builder: (sheetContext) => BlocProvider.value(
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
          final cubit = context.read<LiveRoomInteractionCubit>();

          return Positioned.fill(
            child: Stack(
              children: [
                IgnorePointer(
                  child: LiveLikeBurstLayer(bursts: state.likeBursts),
                ),
                if (!_legacy)
                  Positioned(
                    top: MediaQuery.paddingOf(context).top + 8,
                    left: 12,
                    right: 12,
                    child: _ViewerBar(
                      viewerCount: state.viewerCount,
                      likeCount: state.likeCount,
                      joinedLabel: l10n.liveRoomJoined,
                    ),
                  ),
                Positioned(
                  left: 8,
                  right: 8,
                  bottom: 72 + bottomInset,
                  child: LiveCommentStrip(
                    comments: state.comments,
                    maxHeight: _legacy ? 88 : 110,
                  ),
                ),
                for (final event in state.giftEvents)
                  _GiftFlyAnimation(
                    key: ValueKey(event.id),
                    event: event,
                    onDone: () => cubit.removeGiftEvent(event.id),
                  ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: bottomInset,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.joinBanner != null)
                        LiveRoomJoinBanner(message: state.joinBanner!),
                      const LiveRoomDividerLine(),
                      LiveRoomBottomBar(
                        onComment: cubit.openCommentSheet,
                        onMic: cubit.toggleMic,
                        onInbox: cubit.openInbox,
                        onMore: cubit.openMoreMenu,
                        onTakeSeat: cubit.openSeatSheet,
                        onGift: cubit.openGiftPanel,
                        inboxBadgeCount: state.unreadInbox,
                        micActive: state.micEnabled,
                      ),
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

class _ViewerBar extends StatelessWidget {
  const _ViewerBar({
    required this.viewerCount,
    required this.likeCount,
    required this.joinedLabel,
  });

  final int viewerCount;
  final int likeCount;
  final String joinedLabel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.visibility, color: Colors.white, size: 14),
              const SizedBox(width: 4),
              Text(
                '$viewerCount',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
        const SizedBox(width: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.black54,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.favorite, color: Colors.redAccent, size: 14),
              const SizedBox(width: 4),
              Text(
                '$likeCount',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ],
          ),
        ),
        const Spacer(),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.green.withValues(alpha: 0.85),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            joinedLabel,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 11,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class _GiftFlyAnimation extends StatefulWidget {
  const _GiftFlyAnimation({
    super.key,
    required this.event,
    required this.onDone,
  });

  final LiveGiftEvent event;
  final VoidCallback onDone;

  @override
  State<_GiftFlyAnimation> createState() => _GiftFlyAnimationState();
}

class _GiftFlyAnimationState extends State<_GiftFlyAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward().whenComplete(widget.onDone);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final t = Curves.easeOut.transform(_controller.value);
        return Positioned(
          right: 16 + t * 40,
          bottom: 120 + t * 180,
          child: Opacity(
            opacity: 1 - _controller.value,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.black54,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(widget.event.gift.emoji, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: 8),
                  Text(
                    widget.event.senderName,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
