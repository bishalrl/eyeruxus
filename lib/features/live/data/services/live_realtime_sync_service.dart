import 'dart:async';

import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';

/// Broadcasts session updates so all clients viewing the same room stay in sync.
/// Replace with WebSocket/Firestore when backend is ready.
class LiveRealtimeSyncService {
  LiveRealtimeSyncService._();
  static final LiveRealtimeSyncService instance = LiveRealtimeSyncService._();

  final _controllers = <String, StreamController<LiveRoomSession>>{};
  final _latest = <String, LiveRoomSession>{};

  Stream<LiveRoomSession> watch(String sessionKey) {
    _controllers.putIfAbsent(
      sessionKey,
      () => StreamController<LiveRoomSession>.broadcast(),
    );
    final cached = _latest[sessionKey];
    if (cached != null) {
      return _controllers[sessionKey]!.stream.startWith(cached);
    }
    return _controllers[sessionKey]!.stream;
  }

  void publish(String sessionKey, LiveRoomSession session) {
    final bumped = session.copyWith(
      meta: session.meta.copyWith(syncVersion: session.meta.syncVersion + 1),
    );
    _latest[sessionKey] = bumped;
    final controller = _controllers[sessionKey];
    if (controller != null && !controller.isClosed) {
      controller.add(bumped);
    }
  }

  LiveRoomSession? latest(String sessionKey) => _latest[sessionKey];

  void disposeKey(String sessionKey) {
    _controllers.remove(sessionKey)?.close();
    _latest.remove(sessionKey);
  }
}

extension _StartWith<T> on Stream<T> {
  Stream<T> startWith(T value) async* {
    yield value;
    yield* this;
  }
}
