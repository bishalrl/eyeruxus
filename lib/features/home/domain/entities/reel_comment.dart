class ReelComment {
  const ReelComment({
    required this.id,
    required this.authorName,
    required this.avatarAsset,
    required this.text,
    required this.timeLabel,
  });

  final String id;
  final String authorName;
  final String avatarAsset;
  final String text;
  final String timeLabel;
}
