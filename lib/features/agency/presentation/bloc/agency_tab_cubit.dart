import 'package:flutter_bloc/flutter_bloc.dart';

class AgencyTabCubit extends Cubit<String> {
  AgencyTabCubit() : super('rejected');

  void selectTab(String tab) => emit(tab);
}
