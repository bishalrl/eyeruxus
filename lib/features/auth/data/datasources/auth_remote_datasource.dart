import 'package:dio/dio.dart';

import '../../../../core/network/api_error_mapper.dart';
import '../models/auth_session_model.dart';

abstract class AuthRemoteDataSource {
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  });

  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
    String? mobile,
  });

  Future<void> logout({required String token, required int userId});

  Future<void> requestPasswordReset({required String email});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;

  AuthRemoteDataSourceImpl(this.dio);

  @override
  Future<AuthSessionModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        '/api/user/login',
        data: {'email': email, 'password': password},
      );
      return AuthSessionModel.fromJson(
        Map<String, dynamic>.from(response.data as Map),
      );
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }

  @override
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
    String? mobile,
  }) async {
    try {
      final response = await dio.post(
        '/api/user/register',
        data: {
          'username': username,
          'email': email,
          'password': password,
          'password_confirmation': passwordConfirmation,
          'role': role,
          if (mobile != null) 'mobile': mobile,
        },
      );
      return Map<String, dynamic>.from(response.data as Map);
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }

  @override
  Future<void> logout({required String token, required int userId}) async {
    try {
      await dio.post(
        '/api/user/logout',
        data: {'user_id': userId},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }

  @override
  Future<void> requestPasswordReset({required String email}) async {
    try {
      await dio.post(
        '/api/user/forgot-password',
        data: {'email': email},
      );
    } on DioException catch (e) {
      throwMappedDioException(e);
    }
  }
}
