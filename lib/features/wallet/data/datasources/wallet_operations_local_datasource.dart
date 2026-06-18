import 'package:eye_rex_us/core/constants/app_assets.dart';
import 'package:eye_rex_us/features/wallet/domain/entities/wallet_operations_entities.dart';

abstract class WalletOperationsLocalDataSource {
  Future<List<PointProduct>> getPointProducts();
  Future<BankAccountDetails> getBankDetails();
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<InviteProfile> getInviteProfile();
  Future<List<InviteFriend>> getFriends(FriendsTab tab);
  Future<AgencyDashboard> getAgencyDashboard();
}

class WalletOperationsLocalDataSourceImpl
    implements WalletOperationsLocalDataSource {
  BankAccountDetails _bank = const BankAccountDetails();
  final List<PaymentMethod> _methods = [
    const PaymentMethod(
      id: 'pm1',
      label: 'Bank transfer',
      subtitle: 'HDFC •••• 4521',
      type: PaymentMethodType.bankTransfer,
      isDefault: true,
    ),
    const PaymentMethod(
      id: 'pm2',
      label: 'UPI',
      subtitle: 'user@upi',
      type: PaymentMethodType.upi,
      isDefault: false,
    ),
  ];

  int _selectedAgencyMethod = 1;
  int _pointsBalance = 4800;
  int _coinsBalance = 125000;

  @override
  Future<List<PointProduct>> getPointProducts() async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    return const [
      PointProduct(
        id: 'p1',
        name: 'Avatar Frame',
        description: '7-day premium frame',
        pointsCost: 500,
        iconEmoji: '🖼️',
      ),
      PointProduct(
        id: 'p2',
        name: 'Room Boost',
        description: 'Boost room visibility 24h',
        pointsCost: 800,
        iconEmoji: '🚀',
      ),
      PointProduct(
        id: 'p3',
        name: 'Gift Pack',
        description: '10 animated gifts',
        pointsCost: 1200,
        iconEmoji: '🎁',
      ),
      PointProduct(
        id: 'p4',
        name: 'VIP Trial',
        description: '3-day VIP access',
        pointsCost: 2000,
        iconEmoji: '👑',
      ),
    ];
  }

  int get pointsBalance => _pointsBalance;
  int get coinsBalance => _coinsBalance;

  void deductPoints(int amount) => _pointsBalance -= amount;
  void deductCoins(int amount) => _coinsBalance -= amount;
  void addCoins(int amount) => _coinsBalance += amount;

  void exchangePointsForCoins(int points, int coins) {
    _pointsBalance -= points;
    _coinsBalance += coins;
  }

  @override
  Future<BankAccountDetails> getBankDetails() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return _bank;
  }

  Future<void> saveBank(BankAccountDetails details) async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    _bank = details.copyWith(isConnected: true);
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return List.of(_methods);
  }

  List<PaymentMethod> methodsMutable() => List.of(_methods);

  void replaceMethods(List<PaymentMethod> methods) {
    _methods
      ..clear()
      ..addAll(methods);
  }

  @override
  Future<InviteProfile> getInviteProfile() async {
    await Future<void>.delayed(const Duration(milliseconds: 150));
    return const InviteProfile(
      inviteCode: 'ERX92841',
      inviteLink: 'https://eyerex.us/invite/ERX92841',
      rewardPerInvite: 100,
      totalInvited: 12,
      totalEarned: 1200,
    );
  }

  @override
  Future<List<InviteFriend>> getFriends(FriendsTab tab) async {
    await Future<void>.delayed(const Duration(milliseconds: 200));
    if (tab == FriendsTab.visitors) return const [];
    return const [
      InviteFriend(
        id: 'u1',
        name: 'Priya Sharma',
        avatarUrl: AppAssets.storyS1,
        isOnline: true,
        mutualFriends: 3,
      ),
      InviteFriend(
        id: 'u2',
        name: 'Kabir Singh',
        avatarUrl: AppAssets.storyS2,
        isOnline: false,
        mutualFriends: 1,
      ),
      InviteFriend(
        id: 'u3',
        name: 'Ananya Roy',
        avatarUrl: AppAssets.storyS3,
        isOnline: true,
        mutualFriends: 5,
      ),
    ];
  }

  @override
  Future<AgencyDashboard> getAgencyDashboard() async {
    await Future<void>.delayed(const Duration(milliseconds: 250));
    return AgencyDashboard(
      agencyName: 'Star Agency',
      hostCount: 48,
      agentCount: 6,
      monthlyEarnings: 72345,
      methods: [
        AgencyMethod(
          id: 1,
          title: 'Method 1',
          subtitle: 'Recruit hosts directly under your agency',
          steps: const [
            'Share your agency invite link',
            'Host completes onboarding',
            'Start earning commission',
          ],
          highlight: _selectedAgencyMethod == 1,
        ),
        AgencyMethod(
          id: 2,
          title: 'Method 2',
          subtitle: 'Build a sub-agent network',
          steps: const [
            'Invite sub-agents',
            'Agents recruit hosts for you',
            'Earn from the full network',
          ],
          highlight: _selectedAgencyMethod == 2,
        ),
      ],
    );
  }

  void selectMethod(int id) => _selectedAgencyMethod = id;
}
