import 'package:eye_rex_us/features/wallet/data/datasources/wallet_operations_local_datasource.dart';
import 'package:eye_rex_us/features/wallet/domain/entities/wallet_operations_entities.dart';
import 'package:eye_rex_us/features/wallet/domain/repositories/wallet_operations_repository.dart';

class WalletOperationsRepositoryImpl implements WalletOperationsRepository {
  WalletOperationsRepositoryImpl(this._local);

  final WalletOperationsLocalDataSourceImpl _local;

  @override
  Future<List<PointProduct>> getPointProducts() => _local.getPointProducts();

  @override
  Future<WalletActionResult> purchaseWithPoints({
    required String productId,
    required int currentPoints,
  }) async {
    final products = await _local.getPointProducts();
    final product = products.where((p) => p.id == productId).firstOrNull;
    if (product == null) {
      return const WalletActionResult(success: false, message: 'Product not found');
    }
    if (currentPoints < product.pointsCost) {
      return const WalletActionResult(success: false, message: 'Not enough points');
    }
    _local.deductPoints(product.pointsCost);
    return WalletActionResult(
      success: true,
      message: 'Purchased ${product.name}',
    );
  }

  @override
  Future<WalletActionResult> exchangePointsForCoins({
    required int pointsToSpend,
    required int currentPoints,
    required String verificationCode,
    required String verificationInput,
  }) async {
    if (pointsToSpend <= 0) {
      return const WalletActionResult(success: false, message: 'Select exchange quantity');
    }
    if (pointsToSpend > currentPoints) {
      return const WalletActionResult(success: false, message: 'Insufficient points');
    }
    if (verificationInput.trim() != verificationCode) {
      return const WalletActionResult(
        success: false,
        message: 'Invalid verification code',
      );
    }
    final coinsReceived = (pointsToSpend * 0.92).round();
    _local.exchangePointsForCoins(pointsToSpend, coinsReceived);
    return WalletActionResult(
      success: true,
      message: 'Exchanged $pointsToSpend points → $coinsReceived coins',
    );
  }

  @override
  Future<WalletActionResult> transferCoins({
    required String recipientId,
    required int amount,
    required int currentCoins,
  }) async {
    if (recipientId.trim().isEmpty) {
      return const WalletActionResult(success: false, message: 'Enter recipient ID');
    }
    if (amount <= 0) {
      return const WalletActionResult(success: false, message: 'Enter a valid amount');
    }
    if (amount > currentCoins) {
      return const WalletActionResult(success: false, message: 'Insufficient coins');
    }
    _local.deductCoins(amount);
    return WalletActionResult(
      success: true,
      message: 'Sent $amount coins to $recipientId',
    );
  }

  @override
  Future<BankAccountDetails> getBankDetails() => _local.getBankDetails();

  @override
  Future<WalletActionResult> saveBankDetails(BankAccountDetails details) async {
    if ((details.accountHolder ?? '').isEmpty ||
        (details.accountNumber ?? '').isEmpty ||
        (details.ifscCode ?? '').isEmpty ||
        (details.bankName ?? '').isEmpty) {
      return const WalletActionResult(
        success: false,
        message: 'Fill all bank fields',
      );
    }
    await _local.saveBank(details);
    return const WalletActionResult(
      success: true,
      message: 'Bank account connected',
    );
  }

  @override
  Future<List<PaymentMethod>> getPaymentMethods() => _local.getPaymentMethods();

  @override
  Future<WalletActionResult> addPaymentMethod(
    PaymentMethodType type,
    String label,
  ) async {
    if (label.trim().isEmpty) {
      return const WalletActionResult(success: false, message: 'Enter a label');
    }
    final methods = _local.methodsMutable();
    methods.add(
      PaymentMethod(
        id: 'pm_${DateTime.now().millisecondsSinceEpoch}',
        label: label,
        subtitle: type.name,
        type: type,
        isDefault: methods.isEmpty,
      ),
    );
    _local.replaceMethods(methods);
    return const WalletActionResult(success: true, message: 'Payment method added');
  }

  @override
  Future<WalletActionResult> setDefaultPaymentMethod(String id) async {
    final methods = _local.methodsMutable();
    for (var i = 0; i < methods.length; i++) {
      methods[i] = PaymentMethod(
        id: methods[i].id,
        label: methods[i].label,
        subtitle: methods[i].subtitle,
        type: methods[i].type,
        isDefault: methods[i].id == id,
      );
    }
    _local.replaceMethods(methods);
    return const WalletActionResult(success: true, message: 'Default method updated');
  }

  @override
  Future<WalletActionResult> removePaymentMethod(String id) async {
    final methods = _local.methodsMutable()..removeWhere((m) => m.id == id);
    if (methods.isNotEmpty && !methods.any((m) => m.isDefault)) {
      methods[0] = PaymentMethod(
        id: methods[0].id,
        label: methods[0].label,
        subtitle: methods[0].subtitle,
        type: methods[0].type,
        isDefault: true,
      );
    }
    _local.replaceMethods(methods);
    return const WalletActionResult(success: true, message: 'Payment method removed');
  }

  @override
  Future<InviteProfile> getInviteProfile() => _local.getInviteProfile();

  @override
  Future<WalletActionResult> sendIdInvite(String friendId) async {
    if (friendId.trim().isEmpty) {
      return const WalletActionResult(success: false, message: 'Enter friend ID');
    }
    await Future<void>.delayed(const Duration(milliseconds: 400));
    return WalletActionResult(success: true, message: 'Invite sent to $friendId');
  }

  @override
  Future<List<InviteFriend>> getFriends(FriendsTab tab) => _local.getFriends(tab);

  @override
  Future<AgencyDashboard> getAgencyDashboard() => _local.getAgencyDashboard();

  @override
  Future<WalletActionResult> selectAgencyMethod(int methodId) async {
    _local.selectMethod(methodId);
    return WalletActionResult(
      success: true,
      message: 'Method $methodId selected for your agency',
    );
  }
}
