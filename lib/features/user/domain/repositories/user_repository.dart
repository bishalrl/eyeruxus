import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/user_profile.dart';

abstract class UserRepository {
  Future<Either<Failure, UserProfile>> getProfile({
    required int userId,
    required String accessToken,
  });

  Future<Either<Failure, UserProfile>> updateProfile({
    required int userId,
    required String accessToken,
    required Map<String, dynamic> data,
  });
}
