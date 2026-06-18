import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

enum MakeMoneyTab { makeMoney, manage, data }

enum HostMoneyToolType {
  addHost,
  inviteAgent,
  coinsTrading,
  ranking,
  rewards,
  superFunds,
  superSalary,
  superRank,
  superParty,
}

enum RewardCategory { pkMission, activity, fanClub, invite }

enum RankingPeriod { daily, weekly, monthly }

class HostMoneyTool extends Equatable {
  const HostMoneyTool({
    required this.type,
    required this.label,
    required this.icon,
    required this.color,
    this.badge,
  });

  final HostMoneyToolType type;
  final String label;
  final IconData icon;
  final Color color;
  final String? badge;

  @override
  List<Object?> get props => [type, label, badge];
}

class PromotionCourse extends Equatable {
  const PromotionCourse({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.durationLabel,
    required this.thumbnailColor,
  });

  final String id;
  final String title;
  final String subtitle;
  final String durationLabel;
  final Color thumbnailColor;

  @override
  List<Object?> get props => [id, title];
}

class HostMoneyDashboard extends Equatable {
  const HostMoneyDashboard({
    required this.username,
    required this.flagUrl,
    required this.verified,
    required this.levelBadge,
    required this.earningsPercent,
    required this.commissionPercent,
    required this.earningsRequirement,
    required this.earnedToday,
    required this.points,
    required this.accumulatedEarnings,
    required this.notificationCount,
    required this.tools,
    required this.courses,
    required this.promoTitle,
    required this.promoActionLabel,
  });

  final String username;
  final String flagUrl;
  final bool verified;
  final String levelBadge;
  final int earningsPercent;
  final int commissionPercent;
  final String earningsRequirement;
  final int earnedToday;
  final int points;
  final int accumulatedEarnings;
  final int notificationCount;
  final List<HostMoneyTool> tools;
  final List<PromotionCourse> courses;
  final String promoTitle;
  final String promoActionLabel;

  @override
  List<Object?> get props => [username, earnedToday, points];
}

class HostManagementData extends Equatable {
  const HostManagementData({
    required this.totalHosts,
    required this.activeHosts,
    required this.pendingInvites,
    required this.incentiveTools,
    required this.managementTools,
    required this.platformRewards,
  });

  final int totalHosts;
  final int activeHosts;
  final int pendingInvites;
  final List<HostMoneyTool> incentiveTools;
  final List<HostMoneyTool> managementTools;
  final List<HostMoneyTool> platformRewards;

  @override
  List<Object?> get props => [totalHosts, activeHosts];
}

class LiveDataDay extends Equatable {
  const LiveDataDay({
    required this.label,
    required this.liveMinutes,
    required this.giftCoins,
    required this.viewers,
  });

  final String label;
  final int liveMinutes;
  final int giftCoins;
  final int viewers;

  @override
  List<Object?> get props => [label, liveMinutes];
}

class LiveDataMetrics extends Equatable {
  const LiveDataMetrics({
    required this.liveHours,
    required this.totalGifts,
    required this.pkWins,
    required this.newFollowers,
    required this.dailyStats,
  });

  final double liveHours;
  final int totalGifts;
  final int pkWins;
  final int newFollowers;
  final List<LiveDataDay> dailyStats;

  @override
  List<Object?> get props => [liveHours, totalGifts, pkWins];
}

class RankingEntry extends Equatable {
  const RankingEntry({
    required this.rank,
    required this.name,
    required this.avatarUrl,
    required this.score,
    required this.isAgent,
  });

  final int rank;
  final String name;
  final String avatarUrl;
  final int score;
  final bool isAgent;

  @override
  List<Object?> get props => [rank, name, score];
}

class RewardMission extends Equatable {
  const RewardMission({
    required this.id,
    required this.title,
    required this.description,
    required this.progress,
    required this.target,
    required this.rewardCoins,
    required this.category,
    required this.claimed,
  });

  final String id;
  final String title;
  final String description;
  final int progress;
  final int target;
  final int rewardCoins;
  final RewardCategory category;
  final bool claimed;

  bool get isComplete => progress >= target;

  @override
  List<Object?> get props => [id, progress, claimed];
}

class CoinsTradingOffer extends Equatable {
  const CoinsTradingOffer({
    required this.id,
    required this.sellerName,
    required this.sellerAvatar,
    required this.coins,
    required this.priceInr,
    required this.rating,
  });

  final String id;
  final String sellerName;
  final String sellerAvatar;
  final int coins;
  final double priceInr;
  final double rating;

  @override
  List<Object?> get props => [id, coins, priceInr];
}

class InviteHostResult extends Equatable {
  const InviteHostResult({required this.success, required this.message});

  final bool success;
  final String message;

  @override
  List<Object?> get props => [success, message];
}
