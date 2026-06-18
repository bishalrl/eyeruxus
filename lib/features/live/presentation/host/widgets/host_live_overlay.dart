import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_media_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/host/widgets/host_analytics_sheet.dart';
import 'package:eye_rex_us/features/live/presentation/host/widgets/host_studio_bottom_bar.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_comment_strip.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_gift_panel.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_like_burst_layer.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_bottom_bar.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/moderation/live_host_controls_sheet.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/platform/live_connection_banner.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/platform/live_pk_battle_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Host-only overlay — studio controls, moderation, analytics.
class HostLiveOverlay extends StatelessWidget {
  const HostLiveOverlay({super.key, required this.roomId});

  final String roomId;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final bottomInset = MediaQuery.paddingOf(context).bottom;

    return MultiBlocListener(
      listeners: [
        BlocListener<LiveMediaCubit, LiveMediaState>(
          listenWhen: (p, c) =>
              p.status != LiveMediaStatus.error &&
              c.status == LiveMediaStatus.error &&
              c.errorMessage != null,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                behavior: SnackBarBehavior.floating,
                action: SnackBarAction(
                  label: 'Retry',
                  onPressed: () =>
                      context.read<LiveMediaCubit>().startCameraPreview(),
                ),
              ),
            );
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (p, c) =>
              p.status != LiveRoomLoadStatus.ended &&
              c.status == LiveRoomLoadStatus.ended,
          listener: (context, state) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Live session ended'),
                behavior: SnackBarBehavior.floating,
              ),
            );
          },
        ),
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
          listenWhen: (p, c) =>
              (!p.giftPanelOpen && c.giftPanelOpen) ||
              (!p.giftDashboardOpen && c.giftDashboardOpen),
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
              final c = context.read<LiveRoomInteractionCubit>();
              c.closeGiftPanel();
              c.closeGiftDashboard();
            }
          },
        ),
        BlocListener<LiveRoomInteractionCubit, LiveRoomInteractionState>(
          listenWhen: (p, c) => !p.hostControlsOpen && c.hostControlsOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xFF1A1010),
              builder: (_) => BlocProvider.value(
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
          listenWhen: (p, c) => !p.analyticsOpen && c.analyticsOpen,
          listener: (context, state) async {
            await showModalBottomSheet<void>(
              context: context,
              isScrollControlled: true,
              backgroundColor: const Color(0xFF1A1010),
              builder: (ctx) => BlocProvider.value(
                value: context.read<LiveRoomInteractionCubit>(),
                child: BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
                  builder: (_, s) => HostAnalyticsSheet(state: s),
                ),
              ),
            );
            if (context.mounted) {
              context.read<LiveRoomInteractionCubit>().closeAnalytics();
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
      ],
      child: BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
        builder: (context, state) {
          if (state.status == LiveRoomLoadStatus.ended) {
            return const SizedBox.shrink();
          }

          final cubit = context.read<LiveRoomInteractionCubit>();

          return Positioned.fill(
            child: Stack(
              children: [
                if (state.session?.meta.pkBattle != null)
                  LivePkBattleOverlay(
                    pk: state.session!.meta.pkBattle!,
                    hostName: state.session!.host.name,
                  ),
                LiveConnectionBanner(
                  quality: state.connectionQuality,
                  onRetry: cubit.rejoin,
                ),
                IgnorePointer(child: LiveLikeBurstLayer(bursts: state.likeBursts)),
                if (state.seatRequests.isNotEmpty)
                  Positioned(
                    top: MediaQuery.paddingOf(context).top + 100,
                    left: 12,
                    right: 12,
                    child: _SeatRequestBanner(
                      request: state.seatRequests.first,
                      onApprove: cubit.approveSeatRequest,
                      onReject: cubit.rejectSeatRequest,
                    ),
                  ),
                Positioned(
                  left: 8,
                  right: 72,
                  bottom: 100 + bottomInset,
                  child: LiveCommentStrip(comments: state.comments, maxHeight: 72),
                ),
                const HostFloatingControls(),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: bottomInset,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (state.joinBanner != null)
                        LiveRoomJoinBanner(message: state.joinBanner!),
                      const HostStudioBottomBar(),
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

class _SeatRequestBanner extends StatelessWidget {
  const _SeatRequestBanner({
    required this.request,
    required this.onApprove,
    required this.onReject,
  });

  final LiveSeatRequest request;
  final Future<void> Function(String) onApprove;
  final Future<void> Function(String) onReject;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.75),
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: Colors.amber.withValues(alpha: 0.5)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              '${request.userName} requested seat ${request.seatIndex + 1}',
              style: const TextStyle(color: Colors.white, fontSize: 13),
            ),
          ),
          TextButton(
            onPressed: () => onReject(request.id),
            child: const Text('Reject'),
          ),
          FilledButton(
            onPressed: () => onApprove(request.id),
            child: const Text('Accept'),
          ),
        ],
      ),
    );
  }
}
