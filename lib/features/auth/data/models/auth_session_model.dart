import '../../domain/entities/auth_session.dart';

class AuthSessionModel extends AuthSession {
  const AuthSessionModel({
    required super.token,
    required super.userId,
    required super.role,
  });

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) {
    return AuthSessionModel(
      token: json['access_token'] as String,
      userId: json['user_id'] as int,
      role: (json['role'] as String?) ?? 'User',
    );
  }
}
