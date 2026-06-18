import 'package:dio/dio.dart';

import '../error/exceptions.dart';

String mapDioException(DioException error) {
  switch (error.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
      return 'Connection timeout. Please try again.';
    case DioExceptionType.connectionError:
      return 'No internet connection.';
    case DioExceptionType.badResponse:
      final statusCode = error.response?.statusCode;
      final data = error.response?.data;
      if (data is Map && data['message'] != null) {
        return data['message'].toString();
      }
      return 'Server error (${statusCode ?? 'unknown'})';
    default:
      return error.message ?? 'Unexpected error occurred';
  }
}

Never throwMappedDioException(DioException error) {
  if (error.type == DioExceptionType.connectionError) {
    throw const NetworkException();
  }
  throw ServerException(
    message: mapDioException(error),
    statusCode: error.response?.statusCode,
  );
}
