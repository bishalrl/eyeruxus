abstract class AuthEvent {}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent({required this.email, required this.password});
}

class RegisterEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;
  final String passwordConfirmation;
  final String role;
  final String? mobile;

  RegisterEvent({
    required this.username,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.role,
    this.mobile,
  });
}

class LogoutEvent extends AuthEvent {
  final String token;
  final int userId;

  LogoutEvent({required this.token, required this.userId});
}

class CheckAuthStatusEvent extends AuthEvent {}
