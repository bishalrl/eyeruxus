import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class PostService {
  late final Dio _dio;
  final String _baseUrl;

  PostService() : _baseUrl = dotenv.env['BASE_URL'] ?? '' {
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

  // ============ POSTS V1 APIs ============

  /// Get followed posts (latest 20 where is_followed = 1)
  ///
  /// Parameters:
  /// - accessToken: String
  Future<Map<String, dynamic>> getFollowedPosts({
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/posts/followed',
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

  /// Get all posts V1 (latest 20 posts)
  ///
  /// Parameters:
  /// - accessToken: String
  Future<Map<String, dynamic>> getAllPostsV1({
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/posts/all',
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

  /// Get new posts today (created today UTC)
  ///
  /// Parameters:
  /// - accessToken: String
  Future<Map<String, dynamic>> getNewPostsToday({
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/posts/new',
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

  /// Get posts by topic
  ///
  /// Parameters:
  /// - topic: String
  /// - accessToken: String
  Future<Map<String, dynamic>> getPostsByTopic({
    required String topic,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/posts/topic',
        queryParameters: {'topic': topic},
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

  // ============ POSTS V3 APIs ============

  /// Create a new post (V3)
  ///
  /// Required parameters:
  /// - title: String
  /// - content: String
  /// - accessToken: String
  ///
  /// Optional parameters:
  /// - topics: String (comma-separated)
  /// - isFollowed: int (0 or 1)
  Future<Map<String, dynamic>> createPost({
    required String title,
    required String content,
    required String accessToken,
    String? topics,
    int? isFollowed,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'title': title,
        'content': content,
      };

      if (topics != null) data['topics'] = topics;
      if (isFollowed != null) data['is_followed'] = isFollowed;

      final response = await _dio.post(
        '/posts',
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

  /// List 20 latest posts (V3 main endpoint)
  ///
  /// Parameters:
  /// - accessToken: String
  Future<Map<String, dynamic>> listPosts({
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/posts',
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

  /// Get single post details
  ///
  /// Parameters:
  /// - postId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> getPost({
    required int postId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/posts/$postId',
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

  /// Delete post (only if user is owner)
  ///
  /// Parameters:
  /// - postId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> deletePost({
    required int postId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.delete(
        '/posts/$postId',
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

  // ============ INTERACTIONS V3 APIs ============

  /// Add interaction - LIKE (toggles on/off)
  ///
  /// Parameters:
  /// - postId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> likePost({
    required int postId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/posts/$postId/interactions',
        data: {'type': 'like'},
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

  /// Add interaction - COMMENT
  ///
  /// Parameters:
  /// - postId: int
  /// - content: String
  /// - accessToken: String
  Future<Map<String, dynamic>> commentOnPost({
    required int postId,
    required String content,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/posts/$postId/interactions',
        data: {
          'type': 'comment',
          'content': content,
        },
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

  /// Add interaction - SHARE
  ///
  /// Parameters:
  /// - postId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> sharePost({
    required int postId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/posts/$postId/interactions',
        data: {'type': 'share'},
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

  /// Add interaction - SAVE
  ///
  /// Parameters:
  /// - postId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> savePost({
    required int postId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/posts/$postId/interactions',
        data: {'type': 'save'},
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

  /// Add interaction - VIEW
  ///
  /// Parameters:
  /// - postId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> viewPost({
    required int postId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/posts/$postId/interactions',
        data: {'type': 'view'},
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

  /// List all interactions for a post
  ///
  /// Parameters:
  /// - postId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> listInteractions({
    required int postId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/posts/$postId/interactions',
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

  /// Delete interaction (soft delete)
  ///
  /// Parameters:
  /// - interactionId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> deleteInteraction({
    required int interactionId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.delete(
        '/posts/interactions/$interactionId',
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
            errorMessage = 'Unauthorized - Invalid or missing token';
            break;
          case 403:
            errorMessage = 'Forbidden - Access denied';
            break;
          case 404:
            errorMessage = 'Post or resource not found';
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