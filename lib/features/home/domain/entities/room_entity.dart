class RoomEntity {
  final String id;
  final String title;
  final String tag;
  final String views;
  final String countryFlag;
  final bool isPk;
  final String? coverUrl;

  /// Host + guests currently on stage (used for feed seat previews).
  final int stageMemberCount;

  const RoomEntity({
    required this.id,
    required this.title,
    required this.tag,
    required this.views,
    required this.countryFlag,
    required this.isPk,
    this.coverUrl,
    this.stageMemberCount = 2,
  });
}