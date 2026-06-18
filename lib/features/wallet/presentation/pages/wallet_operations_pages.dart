import 'package:eye_rex_us/app/di/injection.dart';
import 'package:eye_rex_us/app/router/app_router.dart';
import 'package:eye_rex_us/core/extensions/context_extensions.dart';
import 'package:eye_rex_us/features/host_money/presentation/navigation/host_money_routes.dart';
import 'package:eye_rex_us/features/home/presentation/theme/profile_theme.dart';
import 'package:eye_rex_us/features/wallet/domain/entities/wallet_operations_entities.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:eye_rex_us/features/wallet/presentation/bloc/wallet_operations_cubits.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PointsShopPage extends StatelessWidget {
  const PointsShopPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PointsShopCubit>()..load(),
      child: const _PointsShopView(),
    );
  }
}

class _PointsShopView extends StatelessWidget {
  const _PointsShopView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context, l10n.devPoints),
      body: BlocConsumer<PointsShopCubit, PointsShopState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          final points = context.watch<WalletBloc>().state is WalletLoaded
              ? (context.watch<WalletBloc>().state as WalletLoaded).balance.points
              : 0;
          if (state.isLoading && state.products.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _balanceCard('${l10n.walletPoints}: $points', Colors.amber),
              const SizedBox(height: 16),
              const Text('Redeem with points', style: TextStyle(fontWeight: FontWeight.w600)),
              const SizedBox(height: 8),
              for (final product in state.products)
                Card(
                  child: ListTile(
                    leading: Text(product.iconEmoji, style: const TextStyle(fontSize: 28)),
                    title: Text(product.name),
                    subtitle: Text('${product.description} • ${product.pointsCost} pts'),
                    trailing: FilledButton(
                      onPressed: () => context.read<PointsShopCubit>().purchase(
                            product.id,
                            points,
                          ),
                      child: const Text('Buy'),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class TransferCoinsPage extends StatelessWidget {
  const TransferCoinsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<TransferCoinsCubit>(),
      child: const _TransferCoinsView(),
    );
  }
}

class _TransferCoinsView extends StatefulWidget {
  const _TransferCoinsView();

  @override
  State<_TransferCoinsView> createState() => _TransferCoinsViewState();
}

class _TransferCoinsViewState extends State<_TransferCoinsView> {
  final _recipientController = TextEditingController();
  final _amountController = TextEditingController();

  @override
  void dispose() {
    _recipientController.dispose();
    _amountController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final coins = context.watch<WalletBloc>().state is WalletLoaded
        ? (context.watch<WalletBloc>().state as WalletLoaded).balance.coins
        : 0;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context, l10n.devTransfer),
      body: BlocConsumer<TransferCoinsCubit, TransferCoinsState>(
        listener: (context, state) {
          final msg = state.message ?? state.error;
          if (msg != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(msg),
                backgroundColor: state.error != null ? Colors.red : null,
              ),
            );
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _balanceCard('${l10n.walletCoins}: $coins', Colors.orange),
                const SizedBox(height: 16),
                TextField(
                  controller: _recipientController,
                  decoration: InputDecoration(
                    labelText: 'Recipient ID',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: _amountController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    labelText: l10n.walletCoins,
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: state.isSubmitting
                      ? null
                      : () {
                          context.read<TransferCoinsCubit>().transfer(
                                recipientId: _recipientController.text,
                                amount: int.tryParse(_amountController.text) ?? 0,
                                currentCoins: coins,
                              );
                        },
                  child: state.isSubmitting
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text('Send coins'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class BankDetailsPage extends StatelessWidget {
  const BankDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<BankDetailsCubit>()..load(),
      child: const _BankDetailsView(),
    );
  }
}

class _BankDetailsView extends StatefulWidget {
  const _BankDetailsView();

  @override
  State<_BankDetailsView> createState() => _BankDetailsViewState();
}

class _BankDetailsViewState extends State<_BankDetailsView> {
  final _holder = TextEditingController();
  final _account = TextEditingController();
  final _ifsc = TextEditingController();
  final _bank = TextEditingController();
  bool _initialized = false;

  @override
  void dispose() {
    _holder.dispose();
    _account.dispose();
    _ifsc.dispose();
    _bank.dispose();
    super.dispose();
  }

  void _fill(BankAccountDetails d) {
    if (_initialized) return;
    _holder.text = d.accountHolder ?? '';
    _account.text = d.accountNumber ?? '';
    _ifsc.text = d.ifscCode ?? '';
    _bank.text = d.bankName ?? '';
    _initialized = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context, l10n.devBankDetails),
      body: BlocConsumer<BankDetailsCubit, BankDetailsState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
          if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!), backgroundColor: Colors.red),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          _fill(state.details);
          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (state.details.isConnected)
                  const Chip(
                    label: Text('✓ Bank connected'),
                    backgroundColor: Color(0xFFE8F5E9),
                  ),
                const SizedBox(height: 12),
                _field(_holder, 'Account holder name'),
                const SizedBox(height: 10),
                _field(_account, 'Account number', keyboard: TextInputType.number),
                const SizedBox(height: 10),
                _field(_ifsc, 'IFSC code'),
                const SizedBox(height: 10),
                _field(_bank, 'Bank name'),
                const SizedBox(height: 20),
                FilledButton(
                  onPressed: state.isSaving
                      ? null
                      : () => context.read<BankDetailsCubit>().save(
                            BankAccountDetails(
                              accountHolder: _holder.text,
                              accountNumber: _account.text,
                              ifscCode: _ifsc.text,
                              bankName: _bank.text,
                            ),
                          ),
                  child: state.isSaving
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(state.details.isConnected ? 'Update bank' : 'Connect bank'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _field(TextEditingController c, String label, {TextInputType? keyboard}) {
    return TextField(
      controller: c,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<PaymentMethodsCubit>()..load(),
      child: const _PaymentMethodsView(),
    );
  }
}

class _PaymentMethodsView extends StatelessWidget {
  const _PaymentMethodsView();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _appBar(context, l10n.devPaymentMethods),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        child: const Icon(Icons.add),
      ),
      body: BlocConsumer<PaymentMethodsCubit, PaymentMethodsState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading && state.methods.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
            itemCount: state.methods.length,
            itemBuilder: (context, index) {
              final method = state.methods[index];
              return ListTile(
                leading: Icon(
                  method.type == PaymentMethodType.bankTransfer
                      ? Icons.account_balance
                      : Icons.payment,
                ),
                title: Text(method.label),
                subtitle: Text(method.subtitle),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (method.isDefault)
                      const Chip(label: Text('Default', style: TextStyle(fontSize: 10))),
                    PopupMenuButton<String>(
                      onSelected: (v) {
                        if (v == 'default') {
                          context.read<PaymentMethodsCubit>().setDefault(method.id);
                        } else if (v == 'remove') {
                          context.read<PaymentMethodsCubit>().remove(method.id);
                        }
                      },
                      itemBuilder: (_) => [
                        if (!method.isDefault)
                          const PopupMenuItem(value: 'default', child: Text('Set default')),
                        const PopupMenuItem(value: 'remove', child: Text('Remove')),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  void _showAddDialog(BuildContext context) {
    final labelController = TextEditingController();
    var type = PaymentMethodType.upi;
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Add payment method'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: labelController,
              decoration: const InputDecoration(labelText: 'Label / UPI ID'),
            ),
            const SizedBox(height: 8),
            DropdownButton<PaymentMethodType>(
              value: type,
              isExpanded: true,
              items: PaymentMethodType.values
                  .map((t) => DropdownMenuItem(value: t, child: Text(t.name)))
                  .toList(),
              onChanged: (v) => type = v ?? type,
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(ctx), child: const Text('Cancel')),
          FilledButton(
            onPressed: () {
              context.read<PaymentMethodsCubit>().add(type, labelController.text);
              Navigator.pop(ctx);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class InviteFriendsPage extends StatelessWidget {
  const InviteFriendsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<InviteCubit>()..load()),
        BlocProvider(create: (_) => sl<FriendsCubit>()..load()),
      ],
      child: const _InviteFriendsView(),
    );
  }
}

class _InviteFriendsView extends StatefulWidget {
  const _InviteFriendsView();

  @override
  State<_InviteFriendsView> createState() => _InviteFriendsViewState();
}

class _InviteFriendsViewState extends State<_InviteFriendsView>
    with SingleTickerProviderStateMixin {
  late final TabController _tabs;
  final _friendIdController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    _friendIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFE8E0F5),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
          onPressed: () => AppRouter.pop(context),
        ),
        title: TabBar(
          controller: _tabs,
          labelColor: Colors.black,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.black,
          tabs: const [
            Tab(text: 'Invite'),
            Tab(text: 'Friends'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabs,
        children: [
          _buildInviteTab(),
          _buildFriendsTab(),
        ],
      ),
    );
  }

  Widget _buildInviteTab() {
    return BlocConsumer<InviteCubit, InviteState>(
      listener: (context, state) {
        final msg = state.message ?? state.error;
        if (msg != null) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(msg),
              backgroundColor: state.error != null ? Colors.red : null,
            ),
          );
        }
      },
      builder: (context, state) {
        final profile = state.profile;
        if (state.isLoading || profile == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFFFF9E6), Color(0xFFFFE8CC)],
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Earn ${profile.rewardPerInvite} coins per invite • ${profile.totalInvited} invited • ${profile.totalEarned} earned',
                  style: const TextStyle(color: Color(0xFFFF6B35), fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Your invite link', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      SelectableText(profile.inviteLink),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: profile.inviteLink));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Link copied')),
                              );
                            },
                            icon: const Icon(Icons.copy, size: 16),
                            label: const Text('Copy link'),
                          ),
                          const SizedBox(width: 8),
                          OutlinedButton.icon(
                            onPressed: () {
                              Clipboard.setData(ClipboardData(text: profile.inviteCode));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Code copied')),
                              );
                            },
                            icon: const Icon(Icons.tag, size: 16),
                            label: Text('ID: ${profile.inviteCode}'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text('ID invite', style: TextStyle(fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _friendIdController,
                        decoration: const InputDecoration(
                          labelText: 'Friend user ID',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 12),
                      FilledButton(
                        onPressed: state.isSubmitting
                            ? null
                            : () => context.read<InviteCubit>().sendInvite(
                                  _friendIdController.text,
                                ),
                        child: state.isSubmitting
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(strokeWidth: 2),
                              )
                            : const Text('Send invite'),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFriendsTab() {
    return BlocBuilder<FriendsCubit, FriendsState>(
      builder: (context, state) {
        return Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: FriendsTab.values.map((tab) {
                  final selected = state.tab == tab;
                  return Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: ChoiceChip(
                      label: Text(tab.name),
                      selected: selected,
                      onSelected: (_) => context.read<FriendsCubit>().load(tab: tab),
                    ),
                  );
                }).toList(),
              ),
            ),
            if (state.isLoading)
              const Expanded(child: Center(child: CircularProgressIndicator()))
            else if (state.friends.isEmpty)
              const Expanded(
                child: Center(child: Text('No users in this list yet')),
              )
            else
              Expanded(
                child: ListView.builder(
                  itemCount: state.friends.length,
                  itemBuilder: (context, index) {
                    final f = state.friends[index];
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(f.avatarUrl),
                      ),
                      title: Text(f.name),
                      subtitle: Text('${f.mutualFriends} mutual friends'),
                      trailing: f.isOnline
                          ? const Icon(Icons.circle, color: Colors.green, size: 10)
                          : null,
                    );
                  },
                ),
              ),
          ],
        );
      },
    );
  }
}

class MyAgencyPage extends StatelessWidget {
  const MyAgencyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MyAgencyCubit>()..load(),
      child: const _MyAgencyView(),
    );
  }
}

class _MyAgencyView extends StatelessWidget {
  const _MyAgencyView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ProfileTheme.background,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, size: 18),
          onPressed: () => AppRouter.pop(context),
        ),
        title: const Text(
          'My Agency',
          style: TextStyle(
            color: ProfileTheme.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.person_add_outlined),
            onPressed: () => HostMoneyRoutes.openAddHost(context),
          ),
        ],
      ),
      body: BlocConsumer<MyAgencyCubit, MyAgencyState>(
        listener: (context, state) {
          if (state.message != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message!)),
            );
          }
        },
        builder: (context, state) {
          if (state.isLoading || state.dashboard == null) {
            return const Center(child: CircularProgressIndicator());
          }
          final d = state.dashboard!;
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(vertical: 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(colors: [ProfileTheme.promoOrange, Color(0xFFFF7043)]),
                  ),
                  child: Column(
                    children: [
                      Text(
                        d.agencyName,
                        style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w800),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '${d.hostCount} hosts • ${d.agentCount} agents • ₹${d.monthlyEarnings} this month',
                        style: const TextStyle(color: Colors.white70, fontSize: 13),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                  child: Text(
                    'Choose your agency growth method',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: ProfileTheme.textPrimary,
                    ),
                  ),
                ),
                for (final method in d.methods)
                  _MethodCard(
                    method: method,
                    onSelect: () => context.read<MyAgencyCubit>().selectMethod(method.id),
                  ),
                const SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FilledButton.icon(
                    onPressed: () => HostMoneyRoutes.openInviteAgent(context),
                    icon: const Icon(Icons.handshake_outlined, size: 18),
                    label: const Text('Invite sub-agent'),
                    style: FilledButton.styleFrom(
                      backgroundColor: ProfileTheme.promoOrange,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({required this.method, required this.onSelect});

  final AgencyMethod method;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final highlightColor = ProfileTheme.promoOrange;
    final isSelected = method.highlight;
    return Container(
      margin: const EdgeInsets.fromLTRB(12, 0, 12, 10),
      decoration: BoxDecoration(
        color: isSelected
            ? highlightColor.withValues(alpha: 0.12)
            : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? highlightColor : ProfileTheme.divider,
        ),
        boxShadow: isSelected ? [ProfileTheme.cardShadow] : null,
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              method.title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isSelected ? highlightColor : ProfileTheme.textPrimary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              method.subtitle,
              style: TextStyle(
                color: isSelected ? highlightColor.withValues(alpha: 0.75) : ProfileTheme.textSecondary,
              ),
            ),
            const SizedBox(height: 8),
            for (final step in method.steps)
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  children: [
                    Icon(
                      Icons.check_circle_outline,
                      color: isSelected ? highlightColor : ProfileTheme.textSecondary,
                      size: 16,
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        step,
                        style: TextStyle(
                          color: isSelected ? ProfileTheme.textPrimary : Colors.black87,
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 8),
            if (!isSelected)
              FilledButton(
                onPressed: onSelect,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: highlightColor,
                  side: BorderSide(color: highlightColor.withValues(alpha: 0.35)),
                  elevation: 0,
                ),
                child: const Text('Select method'),
              )
            else
              Row(
                children: [
                  Icon(Icons.check, color: highlightColor, size: 18),
                  const SizedBox(width: 8),
                  const Text(
                    'Selected method',
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 12),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}

PreferredSizeWidget _appBar(BuildContext context, String title) {
  return AppBar(
    backgroundColor: Colors.white,
    elevation: 0,
    leading: IconButton(
      icon: const Icon(Icons.arrow_back_ios, color: Colors.black, size: 18),
      onPressed: () => AppRouter.pop(context),
    ),
    title: Text(title, style: const TextStyle(color: Colors.black, fontSize: 16)),
    centerTitle: true,
  );
}

Widget _balanceCard(String label, Color color) {
  return Container(
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
      color: color.withValues(alpha: 0.15),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Text(label, style: TextStyle(fontWeight: FontWeight.bold, color: color)),
  );
}
