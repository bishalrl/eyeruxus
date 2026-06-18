import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';
import 'package:eye_rex_us/features/home/domain/entities/story_entity.dart';

class HomeFeed extends Equatable {
  const HomeFeed({required this.stories, required this.rooms});

  final List<StoryEntity> stories;
  final List<RoomEntity> rooms;

  @override
  List<Object?> get props => [stories, rooms];
}
