import 'package:equatable/equatable.dart';

class ChatRoomConfig extends Equatable {
  final String id;
  final String titleKey;
  final int seatCount;
  final String layoutType;

  const ChatRoomConfig({
    required this.id,
    required this.titleKey,
    required this.seatCount,
    required this.layoutType,
  });

  @override
  List<Object?> get props => [id, titleKey, seatCount, layoutType];
}
