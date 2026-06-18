import 'package:eye_rex_us/features/home/domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.name,
    super.imageUrl,
    super.isUserStory,
  });
}
