import 'package:flutter_bloc/flutter_bloc.dart';

class MainDashboardCubit extends Cubit<int> {
  MainDashboardCubit() : super(0);

  void selectTab(int index) => emit(index);
}
