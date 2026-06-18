import 'package:dio/dio.dart';

import '../config/env_config.dart';

class DioClient {
  DioClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: EnvConfig.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: const {'Content-Type': 'application/json'},
      ),
    );
  }

  late final Dio _dio;

  Dio get dio => _dio;
}
