import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/usecases/forgot_password_usecase.dart';
import '../../domain/usecases/login_usecase.dart';
import '../../domain/usecases/logout_usecase.dart';
import '../../domain/usecases/register_usecase.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final RegisterUseCase registerUseCase;
  final LogoutUseCase logoutUseCase;
  final ForgotPasswordUseCase forgotPasswordUseCase;

  AuthBloc({
    required this.loginUseCase,
    required this.registerUseCase,
    required this.logoutUseCase,
    required this.forgotPasswordUseCase,
  }) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLogin);
    on<AuthDevLoginRequested>(_onDevLogin);
    on<AuthRegisterRequested>(_onRegister);
    on<AuthForgotPasswordRequested>(_onForgotPassword);
    on<AuthLogoutRequested>(_onLogout);
  }

  Future<void> _onLogin(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await loginUseCase(
      LoginParams(email: event.email, password: event.password),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (session) => emit(AuthAuthenticated(session)),
    );
  }

  Future<void> _onDevLogin(
    AuthDevLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await loginUseCase(
      const LoginParams(email: 'dev@erupai.local', password: 'dev'),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (session) => emit(AuthAuthenticated(session)),
    );
  }

  Future<void> _onRegister(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await registerUseCase(
      RegisterParams(
        username: event.username,
        email: event.email,
        password: event.password,
        passwordConfirmation: event.passwordConfirmation,
        role: event.role,
        mobile: event.mobile,
      ),
    );
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (session) => session == null
          ? emit(const AuthUnauthenticated())
          : emit(AuthAuthenticated(session)),
    );
  }

  Future<void> _onForgotPassword(
    AuthForgotPasswordRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await forgotPasswordUseCase(ForgotPasswordParams(event.email));
    result.fold(
      (failure) => emit(AuthFailure(failure.message)),
      (_) => emit(AuthPasswordResetSent(event.email)),
    );
  }

  Future<void> _onLogout(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(const AuthLoading());
    final result = await logoutUseCase(
      LogoutParams(token: event.token, userId: event.userId),
    );
    result.fold(
      (_) => emit(const AuthUnauthenticated()),
      (_) => emit(const AuthUnauthenticated()),
    );
  }
}
