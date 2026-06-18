import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PrivilegeSettingsView extends StatelessWidget {
  const PrivilegeSettingsView({super.key});

  @override
  Widget build(BuildContext context) => _SettingsScaffold(
        title: context.l10n.settingsPrivilege,
        child: BlocBuilder<SettingsBloc, SettingsState>(
          builder: (context, state) {
            final enabled = state is SettingsLoaded && state.settings.privacyModeEnabled;
            return SwitchListTile(
              title: Text(context.l10n.settingsPrivacy),
              value: enabled,
              onChanged: (_) {},
            );
          },
        ),
      );
}

class PaymentMethodsView extends StatelessWidget {
  const PaymentMethodsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: context.l10n.devPaymentMethods,
      child: ListTile(
        leading: Icon(Icons.account_balance, color: context.colors.primary),
        title: Text('Bank transfer', style: TextStyle(color: context.colors.textPrimary)),
        subtitle: Text('Default method', style: TextStyle(color: context.colors.textMuted)),
      ),
    );
  }
}

class BankDetailsView extends StatelessWidget {
  const BankDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: context.l10n.devBankDetails,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: TextField(
          decoration: InputDecoration(
            labelText: 'Account number',
            labelStyle: TextStyle(color: context.colors.textMuted),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
          ),
        ),
      ),
    );
  }
}

class SuperFundsView extends StatelessWidget {
  const SuperFundsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: context.l10n.devSuperFunds,
      child: Center(
        child: Text(
          context.l10n.devSuperFunds,
          style: context.textTheme.titleMedium?.copyWith(color: context.colors.textPrimary),
        ),
      ),
    );
  }
}

class ExchangeCoinsView extends StatelessWidget {
  const ExchangeCoinsView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return _SettingsScaffold(
      title: l10n.devExchangeCoins,
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          final coins = state is WalletLoaded ? state.balance.coins : 0;
          return Padding(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${l10n.walletCoins}: $coins', style: TextStyle(color: context.colors.textPrimary)),
                SizedBox(height: 16.h),
                TextField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.devExchangeCoins,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class PointsView extends StatelessWidget {
  const PointsView({super.key});

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: context.l10n.devPoints,
      child: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          final points = state is WalletLoaded ? state.balance.points : 0;
          return Center(
            child: Text(
              '${context.l10n.walletPoints}: $points',
              style: context.textTheme.headlineSmall?.copyWith(color: context.colors.storeGold),
            ),
          );
        },
      ),
    );
  }
}

class TransferView extends StatelessWidget {
  const TransferView({super.key});

  @override
  Widget build(BuildContext context) {
    return _SettingsScaffold(
      title: context.l10n.devTransfer,
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                labelText: 'Recipient ID',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
            SizedBox(height: 12.h),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: context.l10n.walletCoins,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsScaffold extends StatelessWidget {
  const _SettingsScaffold({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Scaffold(
      backgroundColor: colors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: colors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary, size: 18.sp),
          onPressed: () => AppRouter.pop(context),
        ),
        title: Text(title, style: TextStyle(color: colors.textPrimary, fontSize: 16.sp)),
        centerTitle: true,
      ),
      body: SafeArea(child: child),
    );
  }
}
