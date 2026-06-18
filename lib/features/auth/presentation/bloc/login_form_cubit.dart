import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LoginMethod { none, email }

class LoginFormState extends Equatable {
  const LoginFormState({
    this.method = LoginMethod.none,
    this.obscurePassword = true,
    this.acceptedTerms = false,
  });

  final LoginMethod method;
  final bool obscurePassword;
  final bool acceptedTerms;

  LoginFormState copyWith({
    LoginMethod? method,
    bool? obscurePassword,
    bool? acceptedTerms,
  }) {
    return LoginFormState(
      method: method ?? this.method,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      acceptedTerms: acceptedTerms ?? this.acceptedTerms,
    );
  }

  @override
  List<Object?> get props => [method, obscurePassword, acceptedTerms];
}

class LoginFormCubit extends Cubit<LoginFormState> {
  LoginFormCubit() : super(const LoginFormState());

  void showEmailLogin() => emit(state.copyWith(method: LoginMethod.email));

  void togglePasswordVisibility() {
    emit(state.copyWith(obscurePassword: !state.obscurePassword));
  }

  void setAcceptedTerms(bool? value) {
    emit(state.copyWith(acceptedTerms: value ?? false));
  }
}
