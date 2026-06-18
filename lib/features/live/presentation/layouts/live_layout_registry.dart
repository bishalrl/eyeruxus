/// Unified layout registry for all live room seat counts.
abstract final class LiveLayoutRegistry {
  static const supportedSeatCounts = [1, 2, 3, 4, 6, 8, 16, 32];

  static int seatCountForRoom(String roomId) {
    if (roomId == 'movie') return 1;
    if (roomId == 'pk') return 2;
    if (roomId == 'room_ludo') return 4;
    final match = RegExp(r'^room_(\d+)$').firstMatch(roomId);
    if (match != null) return int.parse(match.group(1)!);
    return 8;
  }

  static String roomIdForSeatCount(int seatCount) {
    return switch (seatCount) {
      1 => 'movie',
      2 => 'pk',
      _ => 'room_$seatCount',
    };
  }

  /// Returns grid dimensions (rows, columns) for dynamic layout.
  static ({int rows, int columns}) gridFor(int seatCount) {
    return switch (seatCount) {
      1 => (rows: 1, columns: 1),
      2 => (rows: 1, columns: 2),
      3 => (rows: 1, columns: 3),
      4 => (rows: 2, columns: 2),
      6 => (rows: 2, columns: 3),
      8 => (rows: 2, columns: 4),
      16 => (rows: 4, columns: 4),
      32 => (rows: 4, columns: 8),
      _ => (rows: 2, columns: (seatCount / 2).ceil()),
    };
  }

  static bool isSupported(int seatCount) =>
      supportedSeatCounts.contains(seatCount);
}
