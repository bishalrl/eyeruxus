import 'package:equatable/equatable.dart';

class AuthSession extends Equatable {
  final String token;
  final int userId;
  final String role;

  const AuthSession({
    required this.token,
    required this.userId,
    required this.role,
  });

  @override
  List<Object?> get props => [token, userId, role];
}
