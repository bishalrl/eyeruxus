import 'package:eye_rex_us/features/live/domain/entities/live_gift.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_room_comment.dart';

abstract final class LiveGiftLocalDataSource {
  static const categories = ['Popular', 'Lucky', 'Luxury', 'Fun', 'Love'];

  static List<LiveGift> allGifts() {
    return const [
      LiveGift(id: 'rose', name: 'Rose', emoji: '🌹', coinCost: 10, category: 'Popular'),
      LiveGift(id: 'heart', name: 'Heart', emoji: '❤️', coinCost: 20, category: 'Popular'),
      LiveGift(id: 'star', name: 'Star', emoji: '⭐', coinCost: 50, category: 'Popular'),
      LiveGift(id: 'crown', name: 'Crown', emoji: '👑', coinCost: 500, category: 'Luxury'),
      LiveGift(id: 'diamond', name: 'Diamond', emoji: '💎', coinCost: 1000, category: 'Luxury'),
      LiveGift(id: 'rocket', name: 'Rocket', emoji: '🚀', coinCost: 2000, category: 'Luxury'),
      LiveGift(id: 'lucky', name: 'Lucky Bag', emoji: '🎁', coinCost: 99, category: 'Lucky'),
      LiveGift(id: 'clover', name: 'Clover', emoji: '🍀', coinCost: 77, category: 'Lucky'),
      LiveGift(id: 'coin', name: 'Coin Rain', emoji: '🪙', coinCost: 150, category: 'Lucky'),
      LiveGift(id: 'fire', name: 'Fire', emoji: '🔥', coinCost: 30, category: 'Fun'),
      LiveGift(id: 'party', name: 'Party', emoji: '🎉', coinCost: 80, category: 'Fun'),
      LiveGift(id: 'mic', name: 'Mic Drop', emoji: '🎤', coinCost: 120, category: 'Fun'),
      LiveGift(id: 'bear', name: 'Teddy', emoji: '🧸', coinCost: 200, category: 'Love'),
      LiveGift(id: 'ring', name: 'Ring', emoji: '💍', coinCost: 999, category: 'Love'),
      LiveGift(id: 'kiss', name: 'Kiss', emoji: '💋', coinCost: 66, category: 'Love'),
      LiveGift(id: 'car', name: 'Sports Car', emoji: '🏎️', coinCost: 5000, category: 'Luxury'),
    ];
  }

  static LiveGift? giftById(String id) {
    for (final gift in allGifts()) {
      if (gift.id == id) return gift;
    }
    return null;
  }

  static List<LiveRoomComment> initialComments(String roomId) {
    return [
      LiveRoomComment(
        id: '${roomId}_sys',
        authorName: 'System',
        text: 'Welcome to the live room!',
        timeLabel: 'now',
      ),
      LiveRoomComment(
        id: '${roomId}_g1',
        authorName: 'MusicFan',
        text: 'Hello everyone 👋',
        timeLabel: '1m',
      ),
    ];
  }
}
