import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';

abstract class UserRemoteDataSource {
  Future<Map<String, dynamic>> getProfile({
    required int userId,
    required String accessToken,
  });

  Future<Map<String, dynamic>> updateProfile({
    required int userId,
    required String accessToken,
    required Map<String, dynamic> data,
  });
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final Dio dio;

  UserRemoteDataSourceImpl(this.dio);

  @override
  Future<Map<String, dynamic>> getProfile({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final response = await dio.get(
        '/profile/$userId',
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> updateProfile({
    required int userId,
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      final response = await dio.put(
        '/profile/$userId',
        data: data,
        options: Options(
          headers: {'Authorization': 'Bearer $accessToken'},
        ),
      );
      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }
}
