/// Canonical live session kinds — maps to API `sessionType` and routing.
enum LiveSessionType {
  videoRoom('video_room'),
  audioRoom('audio_room'),
  party('party'),
  videoBattle('video_battle'),
  previewWindow('preview_window'),
  dashboard('dashboard');

  const LiveSessionType(this.apiValue);

  final String apiValue;

  static LiveSessionType? fromApiValue(String? value) {
    if (value == null) return null;
    for (final type in LiveSessionType.values) {
      if (type.apiValue == value) return type;
    }
    return null;
  }
}
