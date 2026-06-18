import 'package:dartz/dartz.dart';

import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/user_remote_datasource.dart';
import '../models/user_profile_model.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;

  UserRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, UserProfile>> getProfile({
    required int userId,
    required String accessToken,
  }) async {
    try {
      final json = await remoteDataSource.getProfile(
        userId: userId,
        accessToken: accessToken,
      );
      return Right(UserProfileModel.fromJson(json));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, UserProfile>> updateProfile({
    required int userId,
    required String accessToken,
    required Map<String, dynamic> data,
  }) async {
    try {
      final json = await remoteDataSource.updateProfile(
        userId: userId,
        accessToken: accessToken,
        data: data,
      );
      return Right(UserProfileModel.fromJson(json));
    } on NetworkException catch (e) {
      return Left(NetworkFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
