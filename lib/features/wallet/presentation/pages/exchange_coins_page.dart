import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_operations_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

abstract final class ExchangeCoinsTheme {
  static const pink = Color(0xFFEE4D6A);
  static const pinkLight = Color(0xFFFFF0F3);
  static const gold = Color(0xFFFFB300);
  static const verifyBg = Color(0xFF7B6FD6);
  static const linkBlue = Color(0xFF5C9DFF);
}

class ExchangeCoinsPageContent extends StatelessWidget {
  const ExchangeCoinsPageContent({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<ExchangeCoinsCubit>(),
      child: const _ExchangeCoinsView(),
    );
  }
}

class _ExchangeCoinsView extends StatelessWidget {
  const _ExchangeCoinsView();

  static final _numberFormat = NumberFormat('#,###');

  @override
  Widget build(BuildContext context) {
    final points = context.watch<WalletBloc>().state is WalletLoaded
        ? (context.watch<WalletBloc>().state as WalletLoaded).balance.points
        : 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text(
          'Exchange coins',
          style: TextStyle(color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
      ),
      body: BlocConsumer<ExchangeCoinsCubit, ExchangeCoinsState>(
        listener: (context, state) {
          final msg = state.message ?? state.error;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(msg),
                backgroundColor: state.error != null ? Colors.red : ExchangeCoinsTheme.pink,
              ),
            );
          }
        },
        builder: (context, state) {
          final cubit = context.read<ExchangeCoinsCubit>();
          return SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _PointsBalanceCard(
                  availablePoints: points,
                  totalPoints: points,
                  unconfirmed: 0,
                  format: _numberFormat,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Exchange quantity',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: _PackCard(
                        coins: ExchangeCoinsState.pack100kCoins,
                        points: ExchangeCoinsState.pack100kPoints,
                        selected: state.selection == ExchangeCoinsSelection.pack100k,
                        onTap: () => cubit.selectPack(ExchangeCoinsSelection.pack100k),
                        format: _numberFormat,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: _PackCard(
                        coins: ExchangeCoinsState.pack500kCoins,
                        points: ExchangeCoinsState.pack500kPoints,
                        selected: state.selection == ExchangeCoinsSelection.pack500k,
                        onTap: () => cubit.selectPack(ExchangeCoinsSelection.pack500k),
                        format: _numberFormat,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                _CustomizeTile(
                  selected: state.selection == ExchangeCoinsSelection.customize,
                  onTap: () => cubit.selectPack(ExchangeCoinsSelection.customize),
                ),
                const SizedBox(height: 10),
                const Text(
                  'For agent, coins will be redeemed to your agency account by default. >>',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 11, color: ExchangeCoinsTheme.linkBlue),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Exchange quantity',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                _CustomMultiplierField(
                  multiplier: state.customMultiplier,
                  onChanged: cubit.setCustomMultiplier,
                  format: _numberFormat,
                ),
                const SizedBox(height: 20),
                const Text(
                  'Verification Code',
                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: 10),
                _VerificationRow(
                  code: state.verificationCode,
                  input: state.verificationInput,
                  onInputChanged: cubit.setVerificationInput,
                  onRefresh: cubit.refreshVerificationCode,
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 48,
                  child: FilledButton(
                    style: FilledButton.styleFrom(
                      backgroundColor: ExchangeCoinsTheme.pink,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                    ),
                    onPressed: state.isSubmitting
                        ? null
                        : () => cubit.submit(points),
                    child: state.isSubmitting
                        ? const SizedBox(
                            width: 22,
                            height: 22,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(
                            'Exchange ${_numberFormat.format(state.coinsToReceive)} coins',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                            ),
                          ),
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

class _PointsBalanceCard extends StatelessWidget {
  const _PointsBalanceCard({
    required this.availablePoints,
    required this.totalPoints,
    required this.unconfirmed,
    required this.format,
  });

  final int availablePoints;
  final int totalPoints;
  final int unconfirmed;
  final NumberFormat format;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
      decoration: BoxDecoration(
        color: ExchangeCoinsTheme.pink,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text(
                'Available points',
                style: TextStyle(color: Colors.white, fontSize: 13),
              ),
              const SizedBox(width: 4),
              Icon(Icons.info_outline, color: Colors.white.withValues(alpha: 0.9), size: 14),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            format.format(availablePoints),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 36,
              fontWeight: FontWeight.w700,
              height: 1.1,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _BalanceFooterItem(
                  label: 'Total',
                  value: format.format(totalPoints),
                  showInfo: false,
                ),
              ),
              Expanded(
                child: _BalanceFooterItem(
                  label: 'Unconfirmed',
                  value: format.format(unconfirmed),
                  showInfo: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BalanceFooterItem extends StatelessWidget {
  const _BalanceFooterItem({
    required this.label,
    required this.value,
    required this.showInfo,
  });

  final String label;
  final String value;
  final bool showInfo;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(label, style: TextStyle(color: Colors.white.withValues(alpha: 0.85), fontSize: 11)),
            const SizedBox(width: 3),
            Icon(Icons.monetization_on, color: Colors.white.withValues(alpha: 0.85), size: 12),
            if (showInfo) ...[
              const SizedBox(width: 3),
              Icon(Icons.info_outline, color: Colors.white.withValues(alpha: 0.85), size: 11),
            ],
          ],
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _PackCard extends StatelessWidget {
  const _PackCard({
    required this.coins,
    required this.points,
    required this.selected,
    required this.onTap,
    required this.format,
  });

  final int coins;
  final int points;
  final bool selected;
  final VoidCallback onTap;
  final NumberFormat format;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: selected ? ExchangeCoinsTheme.pink : const Color(0xFFE8E8E8),
            width: selected ? 1.5 : 1,
          ),
        ),
        child: Column(
          children: [
            _CoinPointsRow(
              icon: Icons.monetization_on,
              iconColor: ExchangeCoinsTheme.gold,
              value: format.format(coins),
            ),
            const SizedBox(height: 8),
            _CoinPointsRow(
              icon: Icons.diamond,
              iconColor: ExchangeCoinsTheme.pink,
              value: format.format(points),
            ),
          ],
        ),
      ),
    );
  }
}

class _CoinPointsRow extends StatelessWidget {
  const _CoinPointsRow({
    required this.icon,
    required this.iconColor,
    required this.value,
  });

  final IconData icon;
  final Color iconColor;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, color: iconColor, size: 16),
        const SizedBox(width: 4),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
      ],
    );
  }
}

class _CustomizeTile extends StatelessWidget {
  const _CustomizeTile({required this.selected, required this.onTap});

  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: ExchangeCoinsTheme.pink, width: 1.2),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              'customize',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
            ),
            if (selected)
              const Positioned(
                right: 12,
                child: Icon(Icons.check_circle, color: ExchangeCoinsTheme.pink, size: 22),
              ),
          ],
        ),
      ),
    );
  }
}

class _CustomMultiplierField extends StatefulWidget {
  const _CustomMultiplierField({
    required this.multiplier,
    required this.onChanged,
    required this.format,
  });

  final int multiplier;
  final ValueChanged<int> onChanged;
  final NumberFormat format;

  @override
  State<_CustomMultiplierField> createState() => _CustomMultiplierFieldState();
}

class _CustomMultiplierFieldState extends State<_CustomMultiplierField> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: '${widget.multiplier}');
  }

  @override
  void didUpdateWidget(covariant _CustomMultiplierField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.multiplier != widget.multiplier &&
        _controller.text != '${widget.multiplier}') {
      _controller.text = '${widget.multiplier}';
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFF3F3F3),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 48,
            child: TextField(
              controller: _controller,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              decoration: const InputDecoration(
                border: InputBorder.none,
                isDense: true,
              ),
              onChanged: (v) => widget.onChanged(int.tryParse(v) ?? 0),
            ),
          ),
          const Text('×', style: TextStyle(fontSize: 16, color: Colors.black54)),
          const SizedBox(width: 6),
          const Icon(Icons.diamond, color: ExchangeCoinsTheme.pink, size: 18),
          const SizedBox(width: 4),
          Text(
            widget.format.format(ExchangeCoinsState.customUnitPoints),
            style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _VerificationRow extends StatelessWidget {
  const _VerificationRow({
    required this.code,
    required this.input,
    required this.onInputChanged,
    required this.onRefresh,
  });

  final String code;
  final String input;
  final ValueChanged<String> onInputChanged;
  final VoidCallback onRefresh;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            onChanged: onInputChanged,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Enter the verification code',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              filled: true,
              fillColor: const Color(0xFFF3F3F3),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: onRefresh,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            decoration: BoxDecoration(
              color: ExchangeCoinsTheme.verifyBg,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  code.split('').join(' '),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 2,
                  ),
                ),
                const SizedBox(width: 8),
                const Icon(Icons.refresh, color: Colors.white, size: 18),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
