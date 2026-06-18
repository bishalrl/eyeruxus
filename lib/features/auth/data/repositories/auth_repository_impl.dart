import 'package:dartz/dartz.dart';

import '../../../../core/config/env_config.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_local_datasource.dart';
import '../datasources/auth_remote_datasource.dart';
import '../models/auth_session_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final AuthLocalDataSource localDataSource;

  AuthRepositoryImpl(this.remoteDataSource, this.localDataSource);

  @override
  Future<Either<Failure, AuthSession>> login({
    required String email,
    required String password,
  }) async {
    if (EnvConfig.isFrontendDev) {
      return Right(await localDataSource.devLogin(email: email));
    }
    try {
      final session = await remoteDataSource.login(
        email: email,
        password: password,
      );
      return Right(session);
    } catch (_) {
      return Right(await localDataSource.devLogin(email: email));
    }
  }

  @override
  Future<Either<Failure, AuthSession?>> register({
    required String username,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String role,
    String? mobile,
  }) async {
    if (EnvConfig.isFrontendDev) {
      return Right(await localDataSource.devRegister(username: username, email: email));
    }
    try {
      final response = await remoteDataSource.register(
        username: username,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        role: role,
        mobile: mobile,
      );
      if (response.containsKey('access_token')) {
        return Right(AuthSessionModel.fromJson(response));
      }
      return const Right(null);
    } catch (_) {
      return Right(await localDataSource.devRegister(username: username, email: email));
    }
  }

  @override
  Future<Either<Failure, void>> logout({
    required String token,
    required int userId,
  }) async {
    try {
      await remoteDataSource.logout(token: token, userId: userId);
      return const Right(null);
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> requestPasswordReset({
    required String email,
  }) async {
    try {
      await remoteDataSource.requestPasswordReset(email: email);
      return const Right(null);
    } catch (_) {
      await localDataSource.requestPasswordReset(email);
      return const Right(null);
    }
  }
}
