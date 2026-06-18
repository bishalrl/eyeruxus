import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/host_money/domain/entities/host_money_entities.dart';
import 'package:eye_rex_us/features/host_money/presentation/bloc/make_money_cubit.dart';
import 'package:eye_rex_us/features/host_money/presentation/bloc/make_money_state.dart';
import 'package:eye_rex_us/features/host_money/presentation/navigation/host_money_routes.dart';
import 'package:eye_rex_us/features/host_money/presentation/theme/host_money_theme.dart';
import 'package:eye_rex_us/features/host_money/presentation/widgets/host_money_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MakeMoneyPage extends StatelessWidget {
  const MakeMoneyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MakeMoneyCubit>()..load(),
      child: const _MakeMoneyView(),
    );
  }
}

class _MakeMoneyView extends StatelessWidget {
  const _MakeMoneyView();

  void _onToolTap(BuildContext context, HostMoneyTool tool) {
    switch (tool.type) {
      case HostMoneyToolType.addHost:
        HostMoneyRoutes.openAddHost(context);
      case HostMoneyToolType.inviteAgent:
        HostMoneyRoutes.openInviteAgent(context);
      case HostMoneyToolType.coinsTrading:
        HostMoneyRoutes.openCoinsTrading(context);
      case HostMoneyToolType.ranking:
      case HostMoneyToolType.superRank:
        HostMoneyRoutes.openRanking(context);
      case HostMoneyToolType.rewards:
        HostMoneyRoutes.openHostRewards(context);
      case HostMoneyToolType.superFunds:
        HostMoneyRoutes.openSuperFunds(context);
      case HostMoneyToolType.superSalary:
      case HostMoneyToolType.superParty:
        HostMoneyRoutes.openHostRewards(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HostMoneyTheme.background,
      body: SafeArea(
        child: BlocBuilder<MakeMoneyCubit, MakeMoneyState>(
          builder: (context, state) {
            if (state.isLoading && state.dashboard == null) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state.error != null && state.dashboard == null) {
              return Center(child: Text(state.error!));
            }

            final dashboard = state.dashboard;
            return Column(
              children: [
                _HostMoneyAppBar(notificationCount: dashboard?.notificationCount ?? 0),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () => context.read<MakeMoneyCubit>().load(),
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          if (dashboard != null) _ProfileHeader(dashboard: dashboard),
                          const SizedBox(height: 12),
                          HostMoneyTabBar(
                            selected: state.tab,
                            onSelected: context.read<MakeMoneyCubit>().selectTab,
                          ),
                          const SizedBox(height: 12),
                          if (state.isLoading)
                            const Padding(
                              padding: EdgeInsets.all(24),
                              child: CircularProgressIndicator(),
                            )
                          else
                            switch (state.tab) {
                              MakeMoneyTab.makeMoney => _MakeMoneyTab(
                                  dashboard: dashboard!,
                                  onToolTap: (t) => _onToolTap(context, t),
                                ),
                              MakeMoneyTab.manage => _ManageTab(
                                  data: state.management,
                                  onToolTap: (t) => _onToolTap(context, t),
                                ),
                              MakeMoneyTab.data => _DataTab(data: state.liveData),
                            },
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _HostMoneyAppBar extends StatelessWidget {
  const _HostMoneyAppBar({required this.notificationCount});

  final int notificationCount;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 20),
            onPressed: () => AppRouter.pop(context),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: Colors.pink.shade100,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Row(
              children: [
                Icon(Icons.card_giftcard, size: 14, color: Colors.orange),
                SizedBox(width: 2),
                Text('FREE', style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold, color: Colors.red)),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Stack(
            children: [
              const Icon(Icons.notifications_outlined, size: 24),
              if (notificationCount > 0)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: Text(
                      '$notificationCount',
                      style: const TextStyle(fontSize: 8, color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.dashboard});

  final HostMoneyDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Expanded(
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    dashboard.flagUrl,
                    width: 28,
                    height: 28,
                    fit: BoxFit.cover,
                    errorBuilder: (_, __, ___) => const Icon(Icons.flag, size: 28),
                  ),
                ),
                const SizedBox(width: 6),
                Flexible(
                  child: Text(
                    dashboard.username,
                    style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                if (dashboard.verified) ...[
                  const SizedBox(width: 4),
                  const Icon(Icons.verified, size: 16, color: Colors.blue),
                ],
                const SizedBox(width: 4),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: const Color(0xFF9CCC65),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    dashboard.levelBadge,
                    style: const TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '${dashboard.earningsPercent}',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.blue),
                    ),
                    const Text('%', style: TextStyle(fontSize: 10, color: Colors.blue)),
                    const SizedBox(width: 12),
                    Text('C: ${dashboard.commissionPercent}%', style: const TextStyle(fontSize: 10, color: Colors.black54)),
                  ],
                ),
                const Text('Earnings require 🔥', style: TextStyle(fontSize: 9, color: Colors.black54)),
                Text(dashboard.earningsRequirement, style: const TextStyle(fontSize: 9, color: Colors.black54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MakeMoneyTab extends StatelessWidget {
  const _MakeMoneyTab({required this.dashboard, required this.onToolTap});

  final HostMoneyDashboard dashboard;
  final ValueChanged<HostMoneyTool> onToolTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _EarningsCard(dashboard: dashboard),
        const SizedBox(height: 8),
        _PromoBanner(dashboard: dashboard),
        const SizedBox(height: 12),
        HostMoneyToolGrid(
          title: 'Money-making tools',
          tools: dashboard.tools,
          onToolTap: onToolTap,
        ),
        const SizedBox(height: 12),
        _CoursesSection(courses: dashboard.courses),
      ],
    );
  }
}

class _EarningsCard extends StatelessWidget {
  const _EarningsCard({required this.dashboard});

  final HostMoneyDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(12),
      decoration: HostMoneyTheme.cardDecoration,
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Row(
                      children: [
                        Text('Earned Today', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        SizedBox(width: 4),
                        Icon(Icons.help_outline, size: 14, color: Colors.black54),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${dashboard.earnedToday}',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Container(width: 1, height: 50, color: Colors.grey.shade300),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text('Points', style: TextStyle(fontSize: 12, color: Colors.black54)),
                        const SizedBox(width: 4),
                        const Icon(Icons.token, size: 14, color: Colors.pink),
                        const SizedBox(width: 4),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Text('Withdraw', style: TextStyle(fontSize: 9, color: Colors.white)),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${dashboard.points}',
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: const Color(0xFFF0F4FF),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Text('Accumulated Earnings:', style: TextStyle(fontSize: 11, color: Colors.black54)),
                Text(
                  '${dashboard.accumulatedEarnings}',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PromoBanner extends StatelessWidget {
  const _PromoBanner({required this.dashboard});

  final HostMoneyDashboard dashboard;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 100,
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF9C27B0), Color(0xFFE91E63), Color(0xFFFF9800)],
                ),
                borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
              ),
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  dashboard.promoTitle,
                  style: const TextStyle(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 14),
                ),
              ),
            ),
          ),
          Container(
            width: 100,
            decoration: const BoxDecoration(
              color: Color(0xFFFF5252),
              borderRadius: BorderRadius.horizontal(right: Radius.circular(12)),
            ),
            child: Center(
              child: Text(
                dashboard.promoActionLabel,
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoursesSection extends StatelessWidget {
  const _CoursesSection({required this.courses});

  final List<PromotionCourse> courses;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Earn Money - Learn Promotion', style: HostMoneyTheme.sectionTitle),
          const SizedBox(height: 10),
          for (final course in courses)
            Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(12),
              decoration: HostMoneyTheme.cardDecoration,
              child: Row(
                children: [
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      color: course.thumbnailColor,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.play_circle_fill, color: Colors.white),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(course.title, style: const TextStyle(fontWeight: FontWeight.w600)),
                        Text(course.subtitle, style: const TextStyle(fontSize: 12, color: Colors.black54)),
                      ],
                    ),
                  ),
                  Text(course.durationLabel, style: const TextStyle(fontSize: 11, color: Colors.black45)),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _ManageTab extends StatelessWidget {
  const _ManageTab({required this.data, required this.onToolTap});

  final HostManagementData? data;
  final ValueChanged<HostMoneyTool> onToolTap;

  @override
  Widget build(BuildContext context) {
    if (data == null) return const SizedBox.shrink();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: HostMoneyTheme.cardDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatChip(label: 'Total Hosts', value: '${data!.totalHosts}'),
              _StatChip(label: 'Active', value: '${data!.activeHosts}'),
              _StatChip(label: 'Pending', value: '${data!.pendingInvites}'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        HostMoneyToolGrid(
          title: 'Host incentive tools',
          tools: data!.incentiveTools,
          onToolTap: onToolTap,
        ),
        const SizedBox(height: 12),
        HostMoneyToolGrid(
          title: 'Host management',
          tools: data!.managementTools,
          onToolTap: onToolTap,
        ),
        const SizedBox(height: 12),
        HostMoneyToolGrid(
          title: 'Platform rewards',
          tools: data!.platformRewards,
          onToolTap: onToolTap,
        ),
      ],
    );
  }
}

class _StatChip extends StatelessWidget {
  const _StatChip({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.black54)),
      ],
    );
  }
}

class _DataTab extends StatelessWidget {
  const _DataTab({required this.data});

  final LiveDataMetrics? data;

  @override
  Widget build(BuildContext context) {
    if (data == null) return const SizedBox.shrink();
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 16),
          padding: const EdgeInsets.all(16),
          decoration: HostMoneyTheme.cardDecoration,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatChip(label: 'Live hrs', value: '${data!.liveHours}'),
              _StatChip(label: 'Gifts', value: '${data!.totalGifts}'),
              _StatChip(label: 'PK Wins', value: '${data!.pkWins}'),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Weekly overview', style: HostMoneyTheme.sectionTitle),
              const SizedBox(height: 8),
              for (final day in data!.dailyStats)
                Container(
                  margin: const EdgeInsets.only(bottom: 6),
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                  decoration: HostMoneyTheme.cardDecoration,
                  child: Row(
                    children: [
                      SizedBox(width: 36, child: Text(day.label, style: const TextStyle(fontWeight: FontWeight.w600))),
                      Expanded(child: Text('${day.liveMinutes} min live')),
                      Text('${day.giftCoins} coins'),
                      const SizedBox(width: 8),
                      Text('${day.viewers} viewers', style: const TextStyle(fontSize: 11, color: Colors.black45)),
                    ],
                  ),
                ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        TextButton(
          onPressed: () => HostMoneyRoutes.openLiveData(context),
          child: const Text('View full live data'),
        ),
      ],
    );
  }
}
