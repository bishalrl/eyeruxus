import 'package:flutter/material.dart';
import '../../domain/entities/story_entity.dart';

class StoriesSection extends StatelessWidget {
  final List<StoryEntity> stories;
  const StoriesSection({super.key, required this.stories});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 108,
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 32,
                      backgroundColor: Colors.white24,
                      backgroundImage: story.imageUrl != null && !story.isUserStory
                          ? AssetImage(story.imageUrl!)
                          : story.isUserStory && story.imageUrl != null
                              ? AssetImage(story.imageUrl!)
                              : null,
                      child: story.isUserStory
                          ? null
                          : story.imageUrl == null
                              ? Icon(Icons.person, color: Colors.grey.shade400)
                              : null,
                    ),
                    if (story.isUserStory)
                      Positioned(
                        right: 0,
                        bottom: 0,
                        child: Container(
                          width: 22,
                          height: 22,
                          decoration: const BoxDecoration(
                            color: Color(0xFF2196F3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.add, color: Colors.white, size: 16),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: 68,
                  child: Text(
                    story.name,
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(color: Colors.white, fontSize: 12),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
