import 'package:eye_rex_us/UI/Screens/Settings/MessageSettingScreen.dart';
import 'package:eye_rex_us/UI/Screens/Settings/PointDetailsPage.dart' as legacy_points;
import 'package:eye_rex_us/UI/Screens/Settings/SuperFundManagement.dart';
import 'package:eye_rex_us/UI/Screens/Settings/agentAccount.dart';
import 'package:eye_rex_us/features/settings/presentation/views/account_security_view.dart';
import 'package:eye_rex_us/features/settings/presentation/views/settings_subpage_views.dart';
import 'package:eye_rex_us/features/wallet/presentation/pages/exchange_coins_page.dart';
import 'package:eye_rex_us/features/wallet/presentation/pages/wallet_operations_pages.dart'
    as wallet_ops;
import 'package:eye_rex_us/shared/widgets/feature_bound_pages.dart';
import 'package:flutter/material.dart';

class AccountSecurityPage extends StatelessWidget {
  const AccountSecurityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: AccountSecurityView());
  }
}

class PrivilegeSettingsPage extends StatelessWidget {
  const PrivilegeSettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: PrivilegeSettingsView());
  }
}

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(
      child: wallet_ops.PaymentMethodsPage(),
    );
  }
}

class BankDetailsPage extends StatelessWidget {
  const BankDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: wallet_ops.BankDetailsPage());
  }
}

class AgentAccountPage extends StatelessWidget {
  const AgentAccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBoundPage(child: AgentAccountScreen());
  }
}

class SuperFundsPage extends StatelessWidget {
  const SuperFundsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsBoundPage(child: SuperFundsManagementScreen());
  }
}

class ExchangeCoinsPage extends StatelessWidget {
  const ExchangeCoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletBoundPage(child: ExchangeCoinsPageContent());
  }
}

class PointsPage extends StatelessWidget {
  const PointsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletBoundPage(child: wallet_ops.PointsShopPage());
  }
}

class SettingsPointDetailsPage extends StatelessWidget {
  const SettingsPointDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WalletBoundPage(child: legacy_points.PointDetailsPage());
  }
}

class TransferPage extends StatelessWidget {
  const TransferPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const WalletBoundPage(child: wallet_ops.TransferCoinsPage());
  }
}

class NewMessagesNotificationPage extends StatelessWidget {
  const NewMessagesNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SettingsBoundPage(child: NewMessagesNotificationScreen());
  }
}
