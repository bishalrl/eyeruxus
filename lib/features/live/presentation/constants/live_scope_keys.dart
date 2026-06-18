/// Unique bloc scope keys — prevents state collisions on list vs. screen loads.
abstract final class LiveScopeKeys {
  static const list = 'live_list';
  static const previewWindow = 'preview_window';
  static const dashboard = 'dashboard';

  static String session(String sessionType) => 'session_$sessionType';
}
