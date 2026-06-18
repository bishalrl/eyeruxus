import 'package:eye_rex_us/features/auth/presentation/widgets/auth_gender_selector.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupFormState extends Equatable {
  const SignupFormState({
    this.dateOfBirth,
    this.dobLabel = '',
    this.countryLabel = '🇮🇳  India',
    this.gender = AuthGender.male,
  });

  final DateTime? dateOfBirth;
  final String dobLabel;
  final String countryLabel;
  final AuthGender gender;

  SignupFormState copyWith({
    DateTime? dateOfBirth,
    String? dobLabel,
    String? countryLabel,
    AuthGender? gender,
  }) {
    return SignupFormState(
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dobLabel: dobLabel ?? this.dobLabel,
      countryLabel: countryLabel ?? this.countryLabel,
      gender: gender ?? this.gender,
    );
  }

  @override
  List<Object?> get props => [dateOfBirth, dobLabel, countryLabel, gender];
}

class SignupFormCubit extends Cubit<SignupFormState> {
  SignupFormCubit() : super(const SignupFormState());

  void setDateOfBirth(DateTime date, String label) {
    emit(state.copyWith(dateOfBirth: date, dobLabel: label));
  }

  void setCountry(String label) {
    emit(state.copyWith(countryLabel: label));
  }

  void setGender(AuthGender gender) {
    emit(state.copyWith(gender: gender));
  }
}
