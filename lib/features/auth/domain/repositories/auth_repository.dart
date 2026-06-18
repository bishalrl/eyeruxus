import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/auth_session.dart';

abstract class AuthRepository {
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, AuthSession?>> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
    String? mobile,
  });

  Future<Either<Failure, void>> logout({
    required String token,
    required int userId,
  });

  Future<Either<Failure, void>> requestPasswordReset({required String email});
}
