import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_state.dart';
import 'package:eye_rex_us/features/live/presentation/layouts/live_seat_grid.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/moderation/live_participant_owner_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Shared video seat stage — double-tap background sends reactions.
class LiveSeatStage extends StatelessWidget {
  const LiveSeatStage({
    super.key,
    required this.session,
    this.allowSeatRequests = true,
    this.emphasizeHostSeat = false,
    this.enableGuestManage = false,
  });

  final LiveRoomSession session;
  final bool allowSeatRequests;
  final bool emphasizeHostSeat;

  /// When true, host/admins see ⋮ on guest seats to open manage menu.
  final bool enableGuestManage;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<LiveRoomInteractionCubit>();

    return BlocBuilder<LiveRoomInteractionCubit, LiveRoomInteractionState>(
      buildWhen: (prev, curr) =>
          prev.session != curr.session || prev.canModerate != curr.canModerate,
      builder: (context, state) {
        final activeSession = state.session ?? session;
        final canManageGuests = enableGuestManage && state.canModerate;

        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onDoubleTapDown: (details) {
            final box = context.findRenderObject() as RenderBox?;
            if (box == null) return;
            final local = box.globalToLocal(details.globalPosition);
            final size = box.size;
            cubit.sendLike(
              dx: (local.dx / size.width).clamp(0.1, 0.9),
              dy: (local.dy / size.height).clamp(0.1, 0.9),
            );
          },
          child: LiveSeatGrid(
            seats: activeSession.seats,
            activeSpeakerId: activeSession.activeSpeakerId,
            emphasizeHostSeat: emphasizeHostSeat,
            onEmptySeatTap: allowSeatRequests
                ? (index) => cubit.requestSeat(index)
                : null,
            onGuestMenuTap: canManageGuests
                ? (index, participant) => showGuestManageMenu(
                      context,
                      participant: participant,
                      seatIndex: index,
                    )
                : null,
          ),
        );
      },
    );
  }
}
