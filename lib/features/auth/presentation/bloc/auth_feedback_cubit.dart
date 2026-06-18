import 'package:eye_rex_us/features/auth/presentation/widgets/auth_feedback.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthFeedbackCubit extends Cubit<AuthFeedbackMessage?> {
  AuthFeedbackCubit() : super(null);

  void show(AuthFeedbackMessage message) => emit(message);

  void clear() => emit(null);
}
