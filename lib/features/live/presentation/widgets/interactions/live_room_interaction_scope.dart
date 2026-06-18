import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_media_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_room_interaction_cubit.dart';
import 'package:eye_rex_us/features/live/presentation/host/widgets/host_live_overlay.dart';
import 'package:eye_rex_us/features/live/presentation/viewer/widgets/viewer_live_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Per-room BLoC scope: media layer + session/interaction layer.
class LiveRoomInteractionScope extends StatelessWidget {
  const LiveRoomInteractionScope({
    super.key,
    required this.roomId,
    required this.child,
    this.role = LiveParticipantRole.viewer,
    this.instantJoinSeat = false,
    this.preferredSeatIndex,
    this.partyTitle,
  });

  final String roomId;
  final Widget child;
  final LiveParticipantRole role;
  final bool instantJoinSeat;
  final int? preferredSeatIndex;
  final String? partyTitle;

  bool get _isHostExperience => role == LiveParticipantRole.host;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => LiveMediaCubit(sl()),
        ),
        BlocProvider(
          create: (context) => LiveRoomInteractionCubit(
            roomId: roomId,
            sessionRepository: sl(),
            mediaCubit: context.read<LiveMediaCubit>(),
            seatCount: LiveRoomInteractionCubit.seatCountForRoom(roomId),
            role: role,
            instantJoinSeat: instantJoinSeat,
            preferredSeatIndex: preferredSeatIndex,
            partyTitle: partyTitle,
          ),
        ),
      ],
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          if (_isHostExperience)
            HostLiveOverlay(roomId: roomId)
          else
            ViewerLiveOverlay(roomId: roomId),
        ],
      ),
    );
  }
}
