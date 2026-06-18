import 'package:eye_rex_us/features/wallet/domain/entities/wallet_operations_entities.dart';
import 'package:eye_rex_us/features/wallet/domain/repositories/wallet_operations_repository.dart';

class WalletOperationsUseCases {
  const WalletOperationsUseCases(this._repo);

  final WalletOperationsRepository _repo;

  Future<List<PointProduct>> getPointProducts() => _repo.getPointProducts();

  Future<WalletActionResult> purchaseWithPoints({
    required String productId,
    required int currentPoints,
  }) =>
      _repo.purchaseWithPoints(productId: productId, currentPoints: currentPoints);

  Future<WalletActionResult> exchangePointsForCoins({
    required int pointsToSpend,
    required int currentPoints,
    required String verificationCode,
    required String verificationInput,
  }) =>
      _repo.exchangePointsForCoins(
        pointsToSpend: pointsToSpend,
        currentPoints: currentPoints,
        verificationCode: verificationCode,
        verificationInput: verificationInput,
      );

  Future<WalletActionResult> transferCoins({
    required String recipientId,
    required int amount,
    required int currentCoins,
  }) =>
      _repo.transferCoins(
        recipientId: recipientId,
        amount: amount,
        currentCoins: currentCoins,
      );

  Future<BankAccountDetails> getBankDetails() => _repo.getBankDetails();

  Future<WalletActionResult> saveBankDetails(BankAccountDetails details) =>
      _repo.saveBankDetails(details);

  Future<List<PaymentMethod>> getPaymentMethods() => _repo.getPaymentMethods();

  Future<WalletActionResult> addPaymentMethod(PaymentMethodType type, String label) =>
      _repo.addPaymentMethod(type, label);

  Future<WalletActionResult> setDefaultPaymentMethod(String id) =>
      _repo.setDefaultPaymentMethod(id);

  Future<WalletActionResult> removePaymentMethod(String id) =>
      _repo.removePaymentMethod(id);

  Future<InviteProfile> getInviteProfile() => _repo.getInviteProfile();

  Future<WalletActionResult> sendIdInvite(String friendId) =>
      _repo.sendIdInvite(friendId);

  Future<List<InviteFriend>> getFriends(FriendsTab tab) => _repo.getFriends(tab);

  Future<AgencyDashboard> getAgencyDashboard() => _repo.getAgencyDashboard();

  Future<WalletActionResult> selectAgencyMethod(int methodId) =>
      _repo.selectAgencyMethod(methodId);
}
