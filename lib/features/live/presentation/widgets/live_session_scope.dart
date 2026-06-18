import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/chat_room/presentation/bloc/chat_room_bloc.dart';
import 'package:eye_rex_us/features/live/presentation/bloc/live_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Route-scoped bloc provider — one instance per live/chat screen.
///
/// Avoids global singleton contention when many users open sessions concurrently.
class LiveSessionScope extends StatelessWidget {
  const LiveSessionScope({
    super.key,
    required this.child,
    this.chatRoom = false,
  });

  final Widget child;
  final bool chatRoom;

  @override
  Widget build(BuildContext context) {
    if (chatRoom) {
      return BlocProvider(
        create: (_) => sl<ChatRoomBloc>(),
        child: child,
      );
    }
    return BlocProvider(
      create: (_) => sl<LiveBloc>(),
      child: child,
    );
  }
}
