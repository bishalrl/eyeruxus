import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';

abstract class WalletRemoteDataSource {
  Future<Map<String, dynamic>> getBalance({
    required int userId,
    required String accessToken,
  });
}

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final Dio dio;

  WalletRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getBalance({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final response = await dio.get(
        '/wallet/$userId',
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }
}
