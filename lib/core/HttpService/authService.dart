import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AuthService {
  late final Dio _dio;
  final String _baseUrl;

  AuthService() : _baseUrl = dotenv.env['BASE_URL'] ?? '' {
    _dio = Dio(
      BaseOptions(
        baseUrl: _baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
        },
      ),
    );

    // Add interceptors for logging (optional)
    _dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        error: true,
      ),
    );
  }

  /// Register a new user
  ///
  /// Required parameters:
  /// - username: String
  /// - email: String
  /// - password: String
  /// - passwordConfirmation: String
  /// - role: String (SuperAdmin, SubAdmin, CountryHead, CoinAgency, HostAgency, Agent, Host, User)
  ///
  /// Optional parameters:
  /// - mobile: String
  Future<Map<String, dynamic>> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
    String? mobile,
  }) async {
    try {
      final data = {
        'username': username,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
        'role': role,
        if (mobile != null) 'mobile': mobile,
      };

      final response = await _dio.post(
        '/api/user/register',
        data: data,
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Login user
  ///
  /// Parameters:
  /// - email: String
  /// - password: String
  ///
  /// Returns access_token, token_type, role, and user_id
  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _dio.post(
        '/api/user/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Logout user
  ///
  /// Parameters:
  /// - token: String (JWT token)
  /// - userId: int
  Future<Map<String, dynamic>> logout({
    required String token,
    required int userId,
  }) async {
    try {
      final response = await _dio.post(
        '/sessions/logout',
        data: {
          'token': token,
          'user_id': userId,
        },
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get active sessions for a user
  ///
  /// Parameters:
  /// - userId: int
  /// - accessToken: String (JWT token for authorization)
  Future<Map<String, dynamic>> getActiveSessions({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/sessions/active/$userId',
        options: Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Handle Dio errors and throw custom exceptions
  Exception _handleError(DioException error) {
    String errorMessage = 'An unexpected error occurred';

    if (error.response != null) {
      // Server responded with an error
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;

      if (data is Map && data.containsKey('message')) {
        errorMessage = data['message'];
      } else if (data is Map && data.containsKey('error')) {
        errorMessage = data['error'];
      } else {
        switch (statusCode) {
          case 400:
            errorMessage = 'Bad request';
            break;
          case 401:
            errorMessage = 'Unauthorized - Invalid credentials';
            break;
          case 403:
            errorMessage = 'Forbidden - Access denied';
            break;
          case 404:
            errorMessage = 'Resource not found';
            break;
          case 500:
            errorMessage = 'Internal server error';
            break;
        }
      }
    } else if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout) {
      errorMessage = 'Connection timeout - Please check your internet connection';
    } else if (error.type == DioExceptionType.connectionError) {
      errorMessage = 'No internet connection';
    }

    return Exception(errorMessage);
  }
}