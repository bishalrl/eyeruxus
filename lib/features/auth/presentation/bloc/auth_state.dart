import 'package:equatable/equatable.dart';

import '../../domain/entities/auth_session.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final AuthSession session;

  const AuthAuthenticated(this.session);

  @override
  List<Object?> get props => [session];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthPasswordResetSent extends AuthState {
  final String email;

  const AuthPasswordResetSent(this.email);

  @override
  List<Object?> get props => [email];
}

class AuthFailure extends AuthState {
  final String message;

  const AuthFailure(this.message);

  @override
  List<Object?> get props => [message];
}
