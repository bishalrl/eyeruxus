import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';

abstract class LiveRemoteDataSource {
  Future<List<Map<String, dynamic>>> getRooms({
    required String accessToken,
    String? sessionType,
  });
}

class LiveRemoteDataSourceImpl implements LiveRemoteDataSource {
  final Dio dio;

  LiveRemoteDataSourceImpl(this.dio);

  @override
  Future<List<Map<String, dynamic>>> getRooms({
    required String accessToken,
    String? sessionType,
  }) async {
    try {
      final queryParams = <String, dynamic>{};
      if (sessionType != null) queryParams['session_type'] = sessionType;

      final response = await dio.get(
        '/rooms/',
        queryParameters: queryParams.isEmpty ? null : queryParams,
        options: Options(headers: {'Authorization': 'Bearer $accessToken'}),
      );

      final data = response.data;
      if (data is List) {
        return data.map((e) => Map<String, dynamic>.from(e as Map)).toList();
      }
      if (data is Map && data['data'] is List) {
        return (data['data'] as List)
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }
}
