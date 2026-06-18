import 'package:eye_rex_us/UI/Screens/Settings/HostManagementScreen.dart';
import 'package:eye_rex_us/UI/Screens/Settings/LiveDataScreen.dart';
import 'package:eye_rex_us/UI/Screens/Settings/MyOutFitScreen.dart';
import 'package:eye_rex_us/UI/Screens/Settings/coinsScreen.dart';
import 'package:eye_rex_us/UI/Screens/Settings/hostInvitationScreen.dart';
import 'package:eye_rex_us/UI/Screens/Settings/inviteScreen.dart';
import 'package:eye_rex_us/UI/Screens/Settings/rewards.dart';
import 'package:eye_rex_us/features/wallet/presentation/pages/wallet_operations_pages.dart'
    as wallet_ops;
import 'package:eye_rex_us/shared/widgets/feature_bound_pages.dart';
import 'package:flutter/material.dart';

class MyAgencyPage extends StatelessWidget {
  const MyAgencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const wallet_ops.MyAgencyPage();
  }
}

class HostManagementPage extends StatelessWidget {
  const HostManagementPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: HostManagementScreen());
  }
}

class InviteHostsPage extends StatelessWidget {
  const InviteHostsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: InviteMoreHostsScreen());
  }
}

class IdInvitePage extends StatelessWidget {
  const IdInvitePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: IdInviteScreen());
  }
}

class FriendsPage extends StatelessWidget {
  const FriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const wallet_ops.InviteFriendsPage();
  }
}

class CoinsPage extends StatelessWidget {
  const CoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletBoundPage(child: CoinsScreen());
  }
}

class RewardsPage extends StatelessWidget {
  const RewardsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletBoundPage(child: RewardScreen());
  }
}

class LiveDataPage extends StatelessWidget {
  const LiveDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: LiveDataScreen());
  }
}

class MyOutfitPage extends StatelessWidget {
  const MyOutfitPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: MyOutfitScreen());
  }
}
