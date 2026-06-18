abstract class GuardianVipLocalDataSource {
  Future<List<Map<String, dynamic>>> getVipTiers();
}

class GuardianVipLocalDataSourceImpl implements GuardianVipLocalDataSource {
  static const _tiers = [
    {
      'code': 'normal',
      'name': 'Normal VIP',
      'price_label': '95,000/M',
      'privileges': '8/22',
      'sort_order': 0,
    },
    {
      'code': 'super',
      'name': 'Super VIP',
      'price_label': '450,000/M',
      'privileges': '10/22',
      'sort_order': 1,
    },
    {
      'code': 'diamond',
      'name': 'Diamond VIP',
      'price_label': '1,000,000/M',
      'privileges': '20/22',
      'sort_order': 2,
    },
    {
      'code': 'svip',
      'name': 'SVIP',
      'price_label': '12,990,000/Y',
      'privileges': '22/22',
      'sort_order': 3,
    },
  ];

  @override
  Future<List<Map<String, dynamic>>> getVipTiers() async => List.from(_tiers);
}
