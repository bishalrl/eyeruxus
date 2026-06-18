import 'package:eye_rex_us/features/home/presentation/theme/home_colors.dart';
import 'package:eye_rex_us/shared/widgets/app_asset_image.dart';
import 'package:flutter/material.dart';

class DiscoverTopic {
  const DiscoverTopic({
    required this.imageAsset,
    required this.tag,
  });

  final String imageAsset;
  final String tag;
}

class DiscoverTopicCarousel extends StatelessWidget {
  const DiscoverTopicCarousel({
    super.key,
    required this.title,
    required this.topics,
  });

  final String title;
  final List<DiscoverTopic> topics;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
          child: Text(
            title,
            style: const TextStyle(
              color: HomeColors.textWhite,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SizedBox(
          height: 118,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: topics.length,
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final topic = topics[index];
              return _TopicCard(topic: topic);
            },
          ),
        ),
      ],
    );
  }
}

class _TopicCard extends StatelessWidget {
  const _TopicCard({required this.topic});

  final DiscoverTopic topic;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 88,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: AppAssetImage(
                asset: topic.imageAsset,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            topic.tag,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: HomeColors.textWhite,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
