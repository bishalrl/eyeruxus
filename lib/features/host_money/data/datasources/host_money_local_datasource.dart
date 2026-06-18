import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:flutter/material.dart';

abstract class HostMoneyLocalDataSource {
  Future<HostMoneyDashboard> getDashboard();
  Future<HostManagementData> getHostManagement();
  Future<LiveDataMetrics> getLiveData();
  Future<List<RankingEntry>> getRanking(RankingPeriod period);
  Future<List<RewardMission>> getRewards(RewardCategory category);
  Future<List<CoinsTradingOffer>> getCoinsTradingOffers();
}

class HostMoneyLocalDataSourceImpl implements HostMoneyLocalDataSource {
  static const _tools = [
    const HostMoneyTool(
      type: HostMoneyToolType.addHost,
      label: 'Add Host',
      icon: Icons.person_add_alt_1,
      color: Color(0xFFE91E63),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.inviteAgent,
      label: 'Invite Agent',
      icon: Icons.person_add,
      color: Color(0xFF2196F3),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.coinsTrading,
      label: 'Coins Trading',
      icon: Icons.monetization_on,
      color: Color(0xFFFF9800),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.ranking,
      label: 'Ranking',
      icon: Icons.emoji_events,
      color: Color(0xFF9C27B0),
      badge: 'AGENT',
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.rewards,
      label: 'Reward',
      icon: Icons.card_giftcard,
      color: Color(0xFF673AB7),
      badge: 'AGENT',
    ),
  ];

  static const _managementTools = [
    const HostMoneyTool(
      type: HostMoneyToolType.addHost,
      label: 'Host List',
      icon: Icons.groups,
      color: Color(0xFF5C6BC0),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.inviteAgent,
      label: 'Invite Agent',
      icon: Icons.handshake_outlined,
      color: Color(0xFF26A69A),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.superFunds,
      label: 'Super Funds',
      icon: Icons.account_balance_wallet,
      color: Color(0xFFFF7043),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.superSalary,
      label: 'Base Salary',
      icon: Icons.payments_outlined,
      color: Color(0xFF42A5F5),
    ),
  ];

  static const _platformRewards = [
    const HostMoneyTool(
      type: HostMoneyToolType.rewards,
      label: 'Platform Rewards',
      icon: Icons.stars,
      color: Color(0xFFFFB300),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.superRank,
      label: 'Super Rank',
      icon: Icons.leaderboard,
      color: Color(0xFFAB47BC),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.superParty,
      label: 'Super Party',
      icon: Icons.celebration,
      color: Color(0xFFEC407A),
    ),
    const HostMoneyTool(
      type: HostMoneyToolType.ranking,
      label: 'Agent Ranking',
      icon: Icons.emoji_events_outlined,
      color: Color(0xFF7E57C2),
    ),
  ];

  @override
  Future<HostMoneyDashboard> getDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return const HostMoneyDashboard(
      username: 'blind_gifter',
      flagUrl: 'https://flagcdn.com/w320/us.png',
      verified: true,
      levelBadge: 'D',
      earningsPercent: 4,
      commissionPercent: 8,
      earningsRequirement: '1,999,973>>',
      earnedToday: 0,
      points: 13294,
      accumulatedEarnings: 72345,
      notificationCount: 3,
      tools: _tools,
      courses: [
        PromotionCourse(
          id: 'c1',
          title: 'How to recruit hosts',
          subtitle: 'Beginner guide',
          durationLabel: '12 min',
          thumbnailColor: Color(0xFF7E57C2),
        ),
        PromotionCourse(
          id: 'c2',
          title: 'Agency growth playbook',
          subtitle: 'Advanced tips',
          durationLabel: '18 min',
          thumbnailColor: Color(0xFF26A69A),
        ),
      ],
      promoTitle: 'Upgrade your agency tier',
      promoActionLabel: 'Upgrade',
    );
  }

  @override
  Future<HostManagementData> getHostManagement() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const HostManagementData(
      totalHosts: 48,
      activeHosts: 31,
      pendingInvites: 5,
      incentiveTools: _tools,
      managementTools: _managementTools,
      platformRewards: _platformRewards,
    );
  }

  @override
  Future<LiveDataMetrics> getLiveData() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return const LiveDataMetrics(
      liveHours: 26.5,
      totalGifts: 18420,
      pkWins: 12,
      newFollowers: 340,
      dailyStats: [
        LiveDataDay(label: 'Mon', liveMinutes: 180, giftCoins: 2400, viewers: 820),
        LiveDataDay(label: 'Tue', liveMinutes: 220, giftCoins: 3100, viewers: 960),
        LiveDataDay(label: 'Wed', liveMinutes: 150, giftCoins: 1900, viewers: 710),
        LiveDataDay(label: 'Thu', liveMinutes: 260, giftCoins: 4200, viewers: 1100),
        LiveDataDay(label: 'Fri', liveMinutes: 300, giftCoins: 5100, viewers: 1280),
        LiveDataDay(label: 'Sat', liveMinutes: 340, giftCoins: 6200, viewers: 1450),
        LiveDataDay(label: 'Sun', liveMinutes: 280, giftCoins: 4800, viewers: 1320),
      ],
    );
  }

  @override
  Future<List<RankingEntry>> getRanking(RankingPeriod period) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    final base = switch (period) {
      RankingPeriod.daily => 1200,
      RankingPeriod.weekly => 8400,
      RankingPeriod.monthly => 32000,
    };
    return List.generate(10, (i) {
      return RankingEntry(
        rank: i + 1,
        name: ['Priya', 'Kabir', 'Vivek', 'Ananya', 'Rohan', 'Sneha', 'Arjun', 'Meera', 'Dev', 'Kavya'][i],
        avatarUrl: [AppAssets.storyS1, AppAssets.storyS2, AppAssets.storyS3, AppAssets.storyS4][i % 4],
        score: base - (i * 420),
        isAgent: i < 3,
      );
    });
  }

  @override
  Future<List<RewardMission>> getRewards(RewardCategory category) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return switch (category) {
      RewardCategory.pkMission => const [
          RewardMission(
            id: 'pk1',
            title: 'Win 3 PK battles',
            description: 'Complete PK wins this week',
            progress: 2,
            target: 3,
            rewardCoins: 500,
            category: RewardCategory.pkMission,
            claimed: false,
          ),
          RewardMission(
            id: 'pk2',
            title: 'PK streak x5',
            description: 'Win 5 PK in a row',
            progress: 5,
            target: 5,
            rewardCoins: 1200,
            category: RewardCategory.pkMission,
            claimed: false,
          ),
        ],
      RewardCategory.activity => const [
          RewardMission(
            id: 'act1',
            title: 'Go live 10 hours',
            description: 'Accumulate live time',
            progress: 7,
            target: 10,
            rewardCoins: 800,
            category: RewardCategory.activity,
            claimed: false,
          ),
        ],
      RewardCategory.fanClub => const [
          RewardMission(
            id: 'fan1',
            title: 'Grow fan club to 100',
            description: 'New fan club members',
            progress: 64,
            target: 100,
            rewardCoins: 600,
            category: RewardCategory.fanClub,
            claimed: false,
          ),
        ],
      RewardCategory.invite => const [
          RewardMission(
            id: 'inv1',
            title: 'Invite 5 new hosts',
            description: 'Hosts joined your agency',
            progress: 3,
            target: 5,
            rewardCoins: 1500,
            category: RewardCategory.invite,
            claimed: false,
          ),
        ],
    };
  }

  @override
  Future<List<CoinsTradingOffer>> getCoinsTradingOffers() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      CoinsTradingOffer(
        id: 'o1',
        sellerName: 'CoinMaster_99',
        sellerAvatar: AppAssets.storyS1,
        coins: 10000,
        priceInr: 799,
        rating: 4.8,
      ),
      CoinsTradingOffer(
        id: 'o2',
        sellerName: 'TradePro',
        sellerAvatar: AppAssets.storyS2,
        coins: 5000,
        priceInr: 420,
        rating: 4.6,
      ),
      CoinsTradingOffer(
        id: 'o3',
        sellerName: 'SafeCoins',
        sellerAvatar: AppAssets.storyS3,
        coins: 25000,
        priceInr: 1899,
        rating: 4.9,
      ),
    ];
  }
}
