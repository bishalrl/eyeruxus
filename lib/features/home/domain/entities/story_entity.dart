class StoryEntity {
  final String id;
  final String name;
  final String? imageUrl;
  final bool isUserStory;

  const StoryEntity({
    required this.id,
    required this.name,
    this.imageUrl,
    this.isUserStory = false,
  });
}