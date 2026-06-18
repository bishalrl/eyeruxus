abstract class WalletLocalDataSource {
  Future<Map<String, dynamic>> getBalance();
}

class WalletLocalDataSourceImpl implements WalletLocalDataSource {
  @override
  Future<Map<String, dynamic>> getBalance() async => {
        'coins': 125000,
        'points': 13294,
        'withdrawable_amount': 320.50,
      };
}
