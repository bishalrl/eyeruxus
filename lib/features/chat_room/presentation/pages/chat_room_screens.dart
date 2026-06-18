import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/presentation/host/host_live_studio_page.dart';
import 'package:eye_rex_us/features/live/presentation/viewer/viewer_live_room_page.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/interactions/live_room_interaction_scope.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_session_scope.dart';
import 'package:eye_rex_us/features/live/presentation/widgets/live_session_shell.dart';
import 'package:eye_rex_us/shared/widgets/feature_bound_pages.dart';
import 'package:flutter/material.dart';

/// Routes to host studio or viewer room based on role — never shared UI.
class ChatRoomLayoutPage extends StatelessWidget {
  const ChatRoomLayoutPage({
    super.key,
    required this.roomId,
    this.role = LiveParticipantRole.viewer,
    this.instantJoinSeat = false,
    this.preferredSeatIndex,
    this.partyTitle,
  });

  final String roomId;
  final LiveParticipantRole role;
  final bool instantJoinSeat;
  final int? preferredSeatIndex;
  final String? partyTitle;

  bool get _isHost => role == LiveParticipantRole.host;

  @override
  Widget build(BuildContext context) {
    return LiveSessionScope(
      chatRoom: true,
      child: ChatRoomBoundPage(
        roomId: roomId,
        child: LiveSessionShell(
          child: LiveRoomInteractionScope(
            roomId: roomId,
            role: role,
            instantJoinSeat: instantJoinSeat,
            preferredSeatIndex: preferredSeatIndex,
            partyTitle: partyTitle,
            child: _isHost
                ? HostLiveStudioPage(roomId: roomId)
                : ViewerLiveRoomPage(roomId: roomId),
          ),
        ),
      ),
    );
  }
}

// Stable aliases for routing tables and dev launcher.
class ChatRoomMoviePage extends StatelessWidget {
  const ChatRoomMoviePage({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'movie');
}

class ChatRoomPkPage extends StatelessWidget {
  const ChatRoomPkPage({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'pk');
}

class ChatRoom3Page extends StatelessWidget {
  const ChatRoom3Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_3');
}

class ChatRoom4Page extends StatelessWidget {
  const ChatRoom4Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_4');
}

class ChatRoom8Page extends StatelessWidget {
  const ChatRoom8Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_8');
}

class ChatRoom10Page extends StatelessWidget {
  const ChatRoom10Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_10');
}

class ChatRoom12Page extends StatelessWidget {
  const ChatRoom12Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_12');
}

class ChatRoom16Page extends StatelessWidget {
  const ChatRoom16Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_16');
}

class ChatRoom6Page extends StatelessWidget {
  const ChatRoom6Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_6');
}

class ChatRoom32Page extends StatelessWidget {
  const ChatRoom32Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_32');
}

class ChatRoom18Page extends StatelessWidget {
  const ChatRoom18Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_18');
}

class ChatRoom20Page extends StatelessWidget {
  const ChatRoom20Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_20');
}

class ChatRoom11Page extends StatelessWidget {
  const ChatRoom11Page({super.key});
  @override
  Widget build(BuildContext context) => const ChatRoomLayoutPage(roomId: 'room_ludo');
}
