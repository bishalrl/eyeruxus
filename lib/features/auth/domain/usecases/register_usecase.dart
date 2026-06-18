import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/auth_session.dart';
import '../repositories/auth_repository.dart';

class RegisterUseCase implements UseCase<AuthSession?, RegisterParams> {
  final AuthRepository repository;

  RegisterUseCase(this.repository);

  @override
  Future<Either<Failure, AuthSession?>> call(RegisterParams params) {
    return repository.register(
      username: params.username,
      email: params.email,
      password: params.password,
      passwordConfirmation: params.passwordConfirmation,
      role: params.role,
      mobile: params.mobile,
    );
  }
}

class RegisterParams extends Equatable {
  final String username;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String role;
  final String? mobile;

  const RegisterParams({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.role,
    this.mobile,
  });

  @override
  List<Object?> get props =>
      [username, email, password, passwordConfirmation, role, mobile];
}
