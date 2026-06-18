import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/UI/Screens/Gurdian/MainGurdianScree.dart';
import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/guardian_vip/domain/entities/vip_tier.dart';
import 'package:eye_rex_us/features/guardian_vip/presentation/bloc/guardian_vip_bloc.dart';
import 'package:eye_rex_us/features/guardian_vip/presentation/bloc/guardian_vip_tab_cubit.dart';
import 'package:eye_rex_us/shared/widgets/feature_state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GuardianVipPage extends StatelessWidget {
  const GuardianVipPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<GuardianVipTabCubit>(),
      child: const _GuardianVipPageBody(),
    );
  }
}

class _GuardianVipPageBody extends StatefulWidget {
  const _GuardianVipPageBody();

  @override
  State<_GuardianVipPageBody> createState() => _GuardianVipPageBodyState();
}

class _GuardianVipPageBodyState extends State<_GuardianVipPageBody>
    with SingleTickerProviderStateMixin {
  late final TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _tabController.addListener(() {
      if (_tabController.indexIsChanging) {
        context.read<GuardianVipTabCubit>().selectTab(_tabController.index);
      }
    });
    context.read<GuardianVipBloc>().add(const GuardianVipTiersRequested());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showComingSoon() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(context.l10n.vipComingSoon),
        backgroundColor: context.colors.guardianGradientStart,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final tabCubit = context.read<GuardianVipTabCubit>();

    return Scaffold(
      backgroundColor: colors.guardianGradientStart,
      appBar: AppBar(
        backgroundColor: colors.guardianGradientStart,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.onPrimary),
          onPressed: () => AppRouter.pop(context),
        ),
        title: BlocBuilder<GuardianVipTabCubit, int>(
          builder: (context, selectedIndex) {
            return Row(
              children: [
                _TabChip(
                  title: l10n.vipTabGuardian,
                  selected: selectedIndex == 0,
                  onTap: () {
                    tabCubit.selectTab(0);
                    _tabController.animateTo(0);
                  },
                ),
                const Spacer(),
                _TabChip(title: '---', selected: false, onTap: _showComingSoon, muted: true),
                const Spacer(),
                _TabChip(title: '---', selected: false, onTap: _showComingSoon, muted: true),
                const Spacer(),
                _TabChip(
                  title: l10n.vipTabVip,
                  selected: selectedIndex == 1,
                  onTap: () {
                    tabCubit.selectTab(1);
                    _tabController.animateTo(1);
                  },
                ),
              ],
            );
          },
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          GuardianScreen(),
          BlocBuilder<GuardianVipBloc, GuardianVipState>(
            builder: (context, state) {
              if (state is GuardianVipLoading || state is GuardianVipInitial) {
                return const FeatureLoadingView();
              }
              if (state is GuardianVipFailure) {
                return FeatureErrorView(message: state.message);
              }
              final tiers = state is GuardianVipLoaded ? state.tiers : <VipTier>[];
              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: tiers.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) => _VipTierCard(tier: tiers[index]),
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TabChip extends StatelessWidget {
  const _TabChip({
    required this.title,
    required this.selected,
    required this.onTap,
    this.muted = false,
  });

  final String title;
  final bool selected;
  final VoidCallback onTap;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? colors.onPrimary : Colors.transparent,
              width: 2,
            ),
          ),
        ),
        child: Text(
          title,
          style: textTheme.titleSmall?.copyWith(
            color: muted
                ? colors.onPrimary.withValues(alpha: 0.38)
                : (selected ? colors.onPrimary : colors.onPrimary.withValues(alpha: 0.54)),
            fontWeight: selected ? FontWeight.bold : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _VipTierCard extends StatelessWidget {
  const _VipTierCard({required this.tier});

  final VipTier tier;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.vipAccent.withValues(alpha: 0.15),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.vipAccent.withValues(alpha: 0.4)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            tier.name,
            style: textTheme.titleMedium?.copyWith(
              color: colors.onPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            tier.priceLabel,
            style: textTheme.bodyLarge?.copyWith(color: colors.storeGold),
          ),
          const SizedBox(height: 8),
          Text(
            '${l10n.vipPrivileges}: ${tier.privileges}',
            style: textTheme.bodyMedium?.copyWith(color: colors.onPrimary),
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: colors.vipAccent,
                foregroundColor: colors.onPrimary,
              ),
              child: Text(l10n.vipOpenTier(tier.name)),
            ),
          ),
        ],
      ),
    );
  }
}
