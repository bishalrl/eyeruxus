import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class UserService {
  late final Dio _dio;
  final String _baseUrl;

  UserService() : _baseUrl = dotenv.env['BASE_URL'] ?? '' {
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

  /// Get user profile
  ///
  /// Parameters:
  /// - userId: int
  /// - accessToken: String (JWT token for authorization)
  Future<Map<String, dynamic>> getProfile({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/profile/$userId',
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

  /// Update user profile
  ///
  /// Parameters:
  /// - userId: int
  /// - accessToken: String (JWT token for authorization)
  /// - profileData: `Map<String, dynamic>` containing fields to update
  ///
  /// Allowed fields:
  /// - display_name: String
  /// - bio: String
  /// - avatar_url: String
  /// - cover_image_url: String
  /// - location: String
  /// - latitude: double
  /// - longitude: double
  /// - dob: String (format: YYYY-MM-DD)
  /// - gender: String
  /// - languages: `List<String>`
  /// - interests: `List<String>`
  /// - is_private: bool
  Future<Map<String, dynamic>> updateProfile({
    required int userId,
    required String accessToken,
    String? displayName,
    String? bio,
    String? avatarUrl,
    String? coverImageUrl,
    String? location,
    double? latitude,
    double? longitude,
    String? dob,
    String? gender,
    List<String>? languages,
    List<String>? interests,
    bool? isPrivate,
  }) async {
    try {
      // Build the data map with only non-null values
      final Map<String, dynamic> data = {};

      if (displayName != null) data['display_name'] = displayName;
      if (bio != null) data['bio'] = bio;
      if (avatarUrl != null) data['avatar_url'] = avatarUrl;
      if (coverImageUrl != null) data['cover_image_url'] = coverImageUrl;
      if (location != null) data['location'] = location;
      if (latitude != null) data['latitude'] = latitude;
      if (longitude != null) data['longitude'] = longitude;
      if (dob != null) data['dob'] = dob;
      if (gender != null) data['gender'] = gender;
      if (languages != null) data['languages'] = languages;
      if (interests != null) data['interests'] = interests;
      if (isPrivate != null) data['is_private'] = isPrivate;

      if (data.isEmpty) {
        throw Exception('No fields provided for update');
      }

      final response = await _dio.put(
        '/profile/$userId',
        data: data,
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

  /// Alternative method: Update profile with a map
  /// This allows more flexibility for dynamic updates
  Future<Map<String, dynamic>> updateProfileWithMap({
    required int userId,
    required String accessToken,
    required Map<String, dynamic> profileData,
  }) async {
    try {
      if (profileData.isEmpty) {
        throw Exception('No fields provided for update');
      }

      final response = await _dio.put(
        '/profile/$userId',
        data: profileData,
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
            errorMessage = 'Bad request - No valid fields provided';
            break;
          case 401:
            errorMessage = 'Unauthorized - Invalid or missing token';
            break;
          case 403:
            errorMessage = 'Forbidden - Access denied';
            break;
          case 404:
            errorMessage = 'Profile not found';
            break;
          case 500:
            errorMessage = 'Internal server error - Update failed';
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