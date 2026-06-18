import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgotPasswordFormState extends Equatable {
  const ForgotPasswordFormState({this.email = ''});

  final String email;

  bool get canSubmit => email.contains('@') && email.length > 5;

  ForgotPasswordFormState copyWith({String? email}) {
    return ForgotPasswordFormState(email: email ?? this.email);
  }

  @override
  List<Object?> get props => [email];
}

class ForgotPasswordFormCubit extends Cubit<ForgotPasswordFormState> {
  ForgotPasswordFormCubit() : super(const ForgotPasswordFormState());

  void setEmail(String value) {
    emit(state.copyWith(email: value.trim()));
  }
}
