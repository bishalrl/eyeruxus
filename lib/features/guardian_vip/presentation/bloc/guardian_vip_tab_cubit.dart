import 'package:flutter_bloc/flutter_bloc.dart';

class GuardianVipTabCubit extends Cubit<int> {
  GuardianVipTabCubit() : super(0);

  void selectTab(int index) => emit(index);
}
