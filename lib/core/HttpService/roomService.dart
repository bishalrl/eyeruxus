import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class RoomService {
  late final Dio _dio;
  final String _baseUrl;

  RoomService() : _baseUrl = dotenv.env['BASE_URL'] ?? '' {
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

  /// Create a new room
  ///
  /// Required parameters:
  /// - sessionType: String (audio_room, streaming_room, watch_party, game_session)
  /// - title: String
  /// - isPrivate: int (0 or 1)
  /// - accessToken: String
  ///
  /// Optional parameters:
  /// - description: String
  /// - roomCode: String
  /// - password: String
  /// - maxParticipants: int
  Future<Map<String, dynamic>> createRoom({
    required String sessionType,
    required String title,
    required int isPrivate,
    required String accessToken,
    String? description,
    String? roomCode,
    String? password,
    int? maxParticipants,
  }) async {
    try {
      final Map<String, dynamic> data = {
        'session_type': sessionType,
        'title': title,
        'is_private': isPrivate,
      };

      if (description != null) data['description'] = description;
      if (roomCode != null) data['room_code'] = roomCode;
      if (password != null) data['password'] = password;
      if (maxParticipants != null) data['max_participants'] = maxParticipants;

      final response = await _dio.post(
        '/rooms/',
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

  /// List all rooms
  ///
  /// Optional parameters:
  /// - sessionType: String (filter by session type)
  /// - accessToken: String
  Future<Map<String, dynamic>> listRooms({
    required String accessToken,
    String? sessionType,
  }) async {
    try {
      final Map<String, dynamic> queryParams = {};
      if (sessionType != null) {
        queryParams['session_type'] = sessionType;
      }

      final response = await _dio.get(
        '/rooms/',
        queryParameters: queryParams.isNotEmpty ? queryParams : null,
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

  /// Get room details
  ///
  /// Parameters:
  /// - roomId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> getRoomDetails({
    required int roomId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/rooms/$roomId',
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

  /// Update room status
  ///
  /// Parameters:
  /// - roomId: int
  /// - status: String (preparing, waiting, live, in_progress, ended, etc.)
  /// - accessToken: String
  Future<Map<String, dynamic>> updateRoomStatus({
    required int roomId,
    required String status,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.put(
        '/rooms/$roomId/status',
        queryParameters: {'status': status},
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

  /// Delete room
  ///
  /// Parameters:
  /// - roomId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> deleteRoom({
    required int roomId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/rooms/$roomId/delete',
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

  /// Join room
  ///
  /// Parameters:
  /// - roomId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> joinRoom({
    required int roomId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/rooms/$roomId/participants',
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

  /// Leave room
  ///
  /// Parameters:
  /// - roomId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> leaveRoom({
    required int roomId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.post(
        '/rooms/$roomId/participants/leave',
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

  /// List participants in a room
  ///
  /// Parameters:
  /// - roomId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> listParticipants({
    required int roomId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.get(
        '/rooms/$roomId/participants',
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

  /// Change participant role
  ///
  /// Parameters:
  /// - roomId: int
  /// - participantId: int
  /// - newRole: String (host, co-host, moderator, viewer)
  /// - accessToken: String
  Future<Map<String, dynamic>> changeParticipantRole({
    required int roomId,
    required int participantId,
    required String newRole,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.put(
        '/rooms/$roomId/participants/$participantId/role',
        queryParameters: {'new_role': newRole},
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

  /// Transfer host to another user
  ///
  /// Parameters:
  /// - roomId: int
  /// - newHostUserId: int
  /// - accessToken: String
  Future<Map<String, dynamic>> transferHost({
    required int roomId,
    required int newHostUserId,
    required String accessToken,
  }) async {
    try {
      final response = await _dio.put(
        '/rooms/$roomId/transfer_host/$newHostUserId',
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
            errorMessage = 'Room not found';
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