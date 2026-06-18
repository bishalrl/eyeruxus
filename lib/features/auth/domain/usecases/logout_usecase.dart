import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/auth_repository.dart';

class LogoutUseCase implements UseCase<void, LogoutParams> {
  final AuthRepository repository;

  LogoutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(LogoutParams params) {
    return repository.logout(token: params.token, userId: params.userId);
  }
}

class LogoutParams extends Equatable {
  final String token;
  final int userId;

  const LogoutParams({required this.token, required this.userId});

  @override
  List<Object?> get props => [token, userId];
}
