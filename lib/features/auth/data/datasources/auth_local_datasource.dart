import '../models/auth_session_model.dart';

abstract class AuthLocalDataSource {
  Future<void> requestPasswordReset(String email);

  Future<AuthSessionModel> devLogin({String? email, String? provider});

  Future<AuthSessionModel?> devRegister({required String username, required String email});
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  @override
  Future<void> requestPasswordReset(String email) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
  }

  @override
  Future<AuthSessionModel> devLogin({String? email, String? provider}) async {
    await Future<void>.delayed(const Duration(milliseconds: 450));
    return AuthSessionModel(
      token: 'dev_token_${provider ?? 'email'}',
      userId: 1,
      role: 'user',
    );
  }

  @override
  Future<AuthSessionModel?> devRegister({
    required String username,
    required String email,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));
    return AuthSessionModel(
      token: 'dev_token_register',
      userId: 1,
      role: 'user',
    );
  }
}
