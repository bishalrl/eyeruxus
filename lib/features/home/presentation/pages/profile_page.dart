import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_event.dart';
import 'package:eye_rex_us/features/auth/presentation/bloc/auth_state.dart';
import 'package:eye_rex_us/features/home/presentation/bloc/profile_page_cubit.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/home_legacy_routes.dart';
import 'package:eye_rex_us/features/home/presentation/navigation/profile_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/profile_theme.dart';
import 'package:eye_rex_us/features/home/presentation/widgets/profile/profile_sections.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// Profile tab — light peach layout matching the design mockup.
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ProfilePageCubit>(),
      child: const _ProfilePageView(),
    );
  }
}

class _ProfilePageView extends StatelessWidget {
  const _ProfilePageView();

  List<ProfileLegacyMenuItem> _legacyMenuItems(BuildContext context) {
    return HomeLegacyRoutes.accountAndTools()
        .map(
          (item) => ProfileLegacyMenuItem(
            icon: item.icon,
            label: item.label,
            onTap: () => item.open(context),
          ),
        )
        .toList();
  }

  void _logout(BuildContext context) {
    final state = context.read<AuthBloc>().state;
    if (state is AuthAuthenticated) {
      context.read<AuthBloc>().add(
            AuthLogoutRequested(
              token: state.session.token,
              userId: state.session.userId,
            ),
          );
    } else {
      context.read<AuthBloc>().add(
            const AuthLogoutRequested(token: 'dev', userId: 1),
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileTheme.background,
      body: SafeArea(
        bottom: false,
        child: BlocBuilder<ProfilePageCubit, ProfileViewData>(
          builder: (context, data) {
            return ListView(
              padding: const EdgeInsets.only(bottom: 100),
              children: [
                ProfileHeaderSection(data: data),
                ProfileStatsRow(data: data),
                ProfileWalletCards(
                  coins: data.coins,
                  points: data.points,
                  onTopUp: () => ProfileRoutes.openStore(context),
                  onWithdraw: () => ProfileRoutes.openWallet(context),
                ),
                ProfileVipBanner(
                  onTap: () => ProfileRoutes.openVip(context),
                ),
                ProfileQuickActionsGrid(
                  onItemTap: (action) => _onQuickAction(context, action),
                ),
                ProfileHostRewardsBanner(
                  onTap: () => ProfileRoutes.openMakeMoney(context),
                ),
                ProfileMenuList(
                  inviteReward: data.inviteRewardPerPerson,
                  onInvite: () => ProfileRoutes.openInvite(context),
                  onMyAgency: () => ProfileRoutes.openMyAgency(context),
                  onActivityCentre: () => ProfileRoutes.openSettings(context),
                  legacyItems: _legacyMenuItems(context),
                  onLogout: () => _logout(context),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _onQuickAction(BuildContext context, ProfileQuickAction action) {
    switch (action) {
      case ProfileQuickAction.reward:
        ProfileRoutes.openHostRewards(context);
      case ProfileQuickAction.rank:
        ProfileRoutes.openRanking(context);
      case ProfileQuickAction.store:
        ProfileRoutes.openStore(context);
      case ProfileQuickAction.auth:
        ProfileRoutes.openAccountSecurity(context);
      case ProfileQuickAction.vip:
        ProfileRoutes.openVip(context);
    }
  }
}
