import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final String email;
  final String password;

  const AuthLoginRequested({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}

/// Frontend dev / social sign-in — skips credentials, uses mock session.
class AuthDevLoginRequested extends AuthEvent {
  final String? provider;

  const AuthDevLoginRequested({this.provider});

  @override
  List<Object?> get props => [provider];
}

class AuthRegisterRequested extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String role;
  final String? mobile;

  const AuthRegisterRequested({
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

class AuthForgotPasswordRequested extends AuthEvent {
  final String email;

  const AuthForgotPasswordRequested({required this.email});

  @override
  List<Object?> get props => [email];
}

class AuthLogoutRequested extends AuthEvent {
  final String token;
  final int userId;

  const AuthLogoutRequested({required this.token, required this.userId});

  @override
  List<Object?> get props => [token, userId];
}
