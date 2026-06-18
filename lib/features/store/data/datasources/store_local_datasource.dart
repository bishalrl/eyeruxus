abstract class StoreLocalDataSource {
  Future<List<Map<String, dynamic>>> getCatalog({String? category});
}

class StoreLocalDataSourceImpl implements StoreLocalDataSource {
  static const _catalog = [
    {
      'id': 'featured_1',
      'name': 'Golden Crown',
      'category': 'featured',
      'price': 100,
      'image_url': 'https://picsum.photos/seed/f1/200',
    },
    {
      'id': 'featured_2',
      'name': 'Silver Wings',
      'category': 'featured',
      'price': 200,
      'image_url': 'https://picsum.photos/seed/f2/200',
    },
    {
      'id': 'featured_3',
      'name': 'Neon Aura',
      'category': 'featured',
      'price': 300,
      'image_url': 'https://picsum.photos/seed/f3/200',
    },
    {
      'id': 'hot_1',
      'name': 'Lion King',
      'category': 'hot',
      'price': 50000,
      'image_url': 'https://picsum.photos/seed/h1/400',
    },
    {
      'id': 'hot_2',
      'name': 'Dragon',
      'category': 'hot',
      'price': 50000,
      'image_url': 'https://picsum.photos/seed/h2/400',
    },
    {
      'id': 'hot_3',
      'name': 'Phoenix',
      'category': 'hot',
      'price': 50000,
      'image_url': 'https://picsum.photos/seed/h3/400',
    },
    {
      'id': 'hot_4',
      'name': 'Galaxy',
      'category': 'hot',
      'price': 50000,
      'image_url': 'https://picsum.photos/seed/h4/400',
    },
    {
      'id': 'avatar_1',
      'name': 'Avatar Frame',
      'category': 'avatar',
      'price': 500,
      'image_url': 'https://picsum.photos/seed/avatar/200',
    },
    {
      'id': 'ride_1',
      'name': 'Flame and Thunder',
      'category': 'rides',
      'price': 1000,
      'image_url': 'https://picsum.photos/seed/ride/200',
    },
    {
      'id': 'theme_1',
      'name': 'Party Theme',
      'category': 'theme',
      'price': 800,
      'image_url': 'https://picsum.photos/seed/theme/200',
    },
    {
      'id': 'honor_1',
      'name': 'Honor Badge',
      'category': 'honor',
      'price': 2000,
      'image_url': 'https://picsum.photos/seed/honor/200',
    },
    {
      'id': 'rare_1',
      'name': 'Rare ID #888',
      'category': 'rare_id',
      'price': 99999,
      'image_url': 'https://picsum.photos/seed/rare/200',
    },
    {
      'id': 'profile_1',
      'name': 'Gold Profile Card',
      'category': 'profile',
      'price': 1500,
      'image_url': 'https://picsum.photos/seed/profile/200',
    },
    {
      'id': 'bubble_1',
      'name': 'Star Bubble',
      'category': 'bubble',
      'price': 600,
      'image_url': 'https://picsum.photos/seed/bubble/200',
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> getCatalog({String? category}) async {
    if (category == null) return List.from(_catalog);
    return _catalog.where((item) => item['category'] == category).toList();
  }
}
