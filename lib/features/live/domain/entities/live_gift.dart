/// Virtual gift sent in a live room.
class LiveGift {
  const LiveGift({
    required this.id,
    required this.name,
    required this.emoji,
    required this.coinCost,
    required this.category,
  });

  final String id;
  final String name;
  final String emoji;
  final int coinCost;
  final String category;
}
