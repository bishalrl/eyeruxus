/// How the interaction overlay composes with the legacy live-room UI.
enum LiveRoomOverlayMode {
  /// Full overlay chrome (viewer bar + bottom action bar).
  full,

  /// Sits on legacy HomeScreen layouts — avoids duplicating app bar / FAB.
  legacy,
}
