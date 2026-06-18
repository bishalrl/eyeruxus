import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/constants/dev_session.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:eye_rex_us/shared/widgets/feature_state_views.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WalletPage extends StatefulWidget {
  const WalletPage({super.key});

  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  @override
  void initState() {
    super.initState();
    context.read<WalletBloc>().add(
          const WalletBalanceRequested(
            userId: DevSession.userId,
            accessToken: DevSession.accessToken,
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Scaffold(
      backgroundColor: colors.scaffoldBackground,
      appBar: AppBar(
        backgroundColor: colors.scaffoldBackground,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios, color: colors.textPrimary, size: 16.sp),
          onPressed: () => AppRouter.pop(context),
        ),
        title: Text(
          l10n.walletWithdrawTitle,
          style: textTheme.titleMedium?.copyWith(color: colors.textPrimary),
        ),
        centerTitle: true,
        actions: [
          Padding(
            padding: EdgeInsets.only(right: 12.w),
            child: Text(
              l10n.walletRecord,
              style: textTheme.bodyMedium?.copyWith(color: colors.textPrimary),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
        builder: (context, state) {
          if (state is WalletLoading || state is WalletInitial) {
            return const FeatureLoadingView();
          }
          if (state is WalletFailure) {
            return FeatureErrorView(message: state.message);
          }
          if (state is! WalletLoaded) return const SizedBox.shrink();

          final balance = state.balance;

          return SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12.w),
                    decoration: BoxDecoration(
                      color: colors.warning.withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.warning, color: colors.warning, size: 16.sp),
                        SizedBox(width: 8.w),
                        Expanded(
                          child: Text(
                            l10n.walletScamAlert,
                            style: textTheme.bodySmall?.copyWith(color: colors.warning),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    l10n.walletAvailableBalance,
                    style: textTheme.titleSmall?.copyWith(color: colors.textMuted),
                  ),
                  SizedBox(height: 16.h),
                  _BalanceTile(
                    label: l10n.walletCoins,
                    value: '${balance.coins}',
                    icon: Icons.monetization_on,
                  ),
                  SizedBox(height: 12.h),
                  _BalanceTile(
                    label: l10n.walletPoints,
                    value: '${balance.points}',
                    icon: Icons.stars,
                  ),
                  SizedBox(height: 12.h),
                  _BalanceTile(
                    label: l10n.walletWithdrawable,
                    value: '\$${balance.withdrawableAmount.toStringAsFixed(2)}',
                    icon: Icons.account_balance_wallet,
                  ),
                  SizedBox(height: 32.h),
                  SizedBox(
                    width: double.infinity,
                    height: 44.h,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colors.settingsAccent,
                        foregroundColor: colors.onPrimary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(22.r),
                        ),
                      ),
                      child: Text(l10n.walletWithdrawNow),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _BalanceTile extends StatelessWidget {
  const _BalanceTile({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final textTheme = context.textTheme;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: colors.border),
      ),
      child: Row(
        children: [
          Icon(icon, color: colors.storeGold),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: textTheme.bodyMedium?.copyWith(color: colors.textMuted)),
          ),
          Text(
            value,
            style: textTheme.titleMedium?.copyWith(
              color: colors.textPrimary,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
