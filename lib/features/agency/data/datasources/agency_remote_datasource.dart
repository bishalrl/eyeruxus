import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';

abstract class AgencyRemoteDataSource {
  Future<Map<String, dynamic>?> getLatestApplication({
    required int userId,
    required String accessToken,
  });
}

class AgencyRemoteDataSourceImpl implements AgencyRemoteDataSource {
  final Dio dio;

  AgencyRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>?> getLatestApplication({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final response = await dio.get(
        '/agency/applications/latest',
        queryParameters: {'user_id': userId},
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );
      if (response.data == null) return null;
      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      throwMappedDioException(e);
    }
  }
}
