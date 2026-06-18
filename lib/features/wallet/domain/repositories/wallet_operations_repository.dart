import '../entities/wallet_operations_entities.dart';

abstract class WalletOperationsRepository {
  Future<List<PointProduct>> getPointProducts();
  Future<WalletActionResult> purchaseWithPoints({
    required String productId,
    required int currentPoints,
  });
  Future<WalletActionResult> exchangePointsForCoins({
    required int pointsToSpend,
    required int currentPoints,
    required String verificationCode,
    required String verificationInput,
  });
  Future<WalletActionResult> transferCoins({
    required String recipientId,
    required int amount,
    required int currentCoins,
  });
  Future<BankAccountDetails> getBankDetails();
  Future<WalletActionResult> saveBankDetails(BankAccountDetails details);
  Future<List<PaymentMethod>> getPaymentMethods();
  Future<WalletActionResult> addPaymentMethod(PaymentMethodType type, String label);
  Future<WalletActionResult> setDefaultPaymentMethod(String id);
  Future<WalletActionResult> removePaymentMethod(String id);
  Future<InviteProfile> getInviteProfile();
  Future<WalletActionResult> sendIdInvite(String friendId);
  Future<List<InviteFriend>> getFriends(FriendsTab tab);
  Future<AgencyDashboard> getAgencyDashboard();
  Future<WalletActionResult> selectAgencyMethod(int methodId);
}
