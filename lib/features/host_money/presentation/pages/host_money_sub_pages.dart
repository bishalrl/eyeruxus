import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:eye_rex_us/features/host_money/presentation/bloc/host_money_feature_cubits.dart';
import 'package:eye_rex_us/features/host_money/presentation/bloc/make_money_cubit.dart';
import 'package:eye_rex_us/features/host_money/presentation/bloc/make_money_state.dart';
import 'package:eye_rex_us/features/host_money/presentation/theme/host_money_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CoinsTradingPage extends StatelessWidget {
  const CoinsTradingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<CoinsTradingCubit>()..load(),
      child: const _CoinsTradingView(),
    );
  }
}

class _CoinsTradingView extends StatelessWidget {
  const _CoinsTradingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HostMoneyTheme.background,
      appBar: AppBar(
        backgroundColor: HostMoneyTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text('Coins Trading', style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<CoinsTradingCubit, CoinsTradingState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.offers.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.offers.length,
            itemBuilder: (context, index) {
              final offer = state.offers[index];
              return _OfferCard(offer: offer);
            },
          );
        },
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({required this.offer});

  final CoinsTradingOffer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: HostMoneyTheme.cardDecoration,
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(offer.sellerAvatar),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(offer.sellerName, style: const TextStyle(fontWeight: FontWeight.w600)),
                Text('${offer.coins} coins • ₹${offer.priceInr.toStringAsFixed(0)}'),
                Text('★ ${offer.rating}', style: const TextStyle(fontSize: 12, color: Colors.orange)),
              ],
            ),
          ),
          FilledButton(
            onPressed: () => context.read<CoinsTradingCubit>().buy(offer),
            child: const Text('Buy'),
          ),
        ],
      ),
    );
  }
}

class RankingPage extends StatelessWidget {
  const RankingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RankingCubit>()..load(),
      child: const _RankingView(),
    );
  }
}

class _RankingView extends StatelessWidget {
  const _RankingView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HostMoneyTheme.background,
      appBar: AppBar(
        backgroundColor: HostMoneyTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text('Agent Ranking', style: TextStyle(color: Colors.black)),
      ),
      body: BlocBuilder<RankingCubit, RankingState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: RankingPeriod.values.map((p) {
                    final selected = state.period == p;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(p.name),
                        selected: selected,
                        onSelected: (_) => context.read<RankingCubit>().load(period: p),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (state.isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else
                Expanded(
                  child: ListView.builder(
                    itemCount: state.entries.length,
                    itemBuilder: (context, index) {
                      final entry = state.entries[index];
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: AssetImage(entry.avatarUrl),
                          child: Text('${entry.rank}'),
                        ),
                        title: Text(entry.name),
                        subtitle: entry.isAgent ? const Text('AGENT') : null,
                        trailing: Text('${entry.score}', style: const TextStyle(fontWeight: FontWeight.bold)),
                      );
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class HostRewardsPage extends StatelessWidget {
  const HostRewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RewardsCubit>()..load(),
      child: const _HostRewardsView(),
    );
  }
}

class _HostRewardsView extends StatelessWidget {
  const _HostRewardsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HostMoneyTheme.background,
      appBar: AppBar(
        backgroundColor: HostMoneyTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text('Rewards', style: TextStyle(color: Colors.black)),
      ),
      body: BlocConsumer<RewardsCubit, RewardsState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: RewardCategory.values.map((c) {
                    final selected = state.category == c;
                    return Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: ChoiceChip(
                        label: Text(c.name),
                        selected: selected,
                        onSelected: (_) => context.read<RewardsCubit>().load(category: c),
                      ),
                    );
                  }).toList(),
                ),
              ),
              if (state.isLoading)
                const Expanded(child: Center(child: CircularProgressIndicator()))
              else
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: state.missions.length,
                    itemBuilder: (context, index) {
                      final m = state.missions[index];
                      return _MissionCard(mission: m);
                    },
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MissionCard extends StatelessWidget {
  const _MissionCard({required this.mission});

  final RewardMission mission;

  @override
  Widget build(BuildContext context) {
    final progress = mission.target == 0 ? 0.0 : mission.progress / mission.target;
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: HostMoneyTheme.cardDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(mission.title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(mission.description, style: const TextStyle(fontSize: 12, color: Colors.black54)),
          const SizedBox(height: 8),
          LinearProgressIndicator(value: progress.clamp(0, 1)),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('${mission.progress}/${mission.target}'),
              Text('${mission.rewardCoins} coins'),
              if (mission.isComplete && !mission.claimed)
                TextButton(
                  onPressed: () => context.read<RewardsCubit>().claim(mission.id),
                  child: const Text('Claim'),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class LiveDataDetailPage extends StatelessWidget {
  const LiveDataDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MakeMoneyCubit>()..selectTab(MakeMoneyTab.data),
      child: Scaffold(
        backgroundColor: HostMoneyTheme.background,
        appBar: AppBar(
          backgroundColor: HostMoneyTheme.background,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
            onPressed: () => AppRouter.pop(context),
          ),
          title: const Text('Live Data', style: TextStyle(color: Colors.black)),
        ),
        body: BlocBuilder<MakeMoneyCubit, MakeMoneyState>(
          builder: (context, state) {
            final data = state.liveData;
            if (data == null) {
              return const Center(child: CircularProgressIndicator());
            }
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                _MetricTile('Total live hours', '${data.liveHours}'),
                _MetricTile('Gift coins', '${data.totalGifts}'),
                _MetricTile('PK wins', '${data.pkWins}'),
                _MetricTile('New followers', '${data.newFollowers}'),
                const SizedBox(height: 16),
                const Text('Daily breakdown', style: HostMoneyTheme.sectionTitle),
                for (final day in data.dailyStats)
                  ListTile(
                    title: Text(day.label),
                    subtitle: Text('${day.liveMinutes} min • ${day.viewers} viewers'),
                    trailing: Text('${day.giftCoins}'),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _MetricTile extends StatelessWidget {
  const _MetricTile(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: HostMoneyTheme.cardDecoration,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}

class HostSuperFundsPage extends StatelessWidget {
  const HostSuperFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HostMoneyTheme.background,
      appBar: AppBar(
        backgroundColor: HostMoneyTheme.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text('Super Funds', style: TextStyle(color: Colors.black)),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _MetricTile('Available balance', '₹12,450'),
            _MetricTile('Pending payout', '₹3,200'),
            _MetricTile('This month', '₹28,900'),
            SizedBox(height: 16),
            Text(
              'Fund management with static demo data. API integration coming soon.',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}
