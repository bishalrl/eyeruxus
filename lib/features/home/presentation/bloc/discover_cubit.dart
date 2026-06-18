import 'package:eye_rex_us/features/home/presentation/widgets/discover/discover_top_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DiscoverCubit extends Cubit<DiscoverFeedTab> {
  DiscoverCubit() : super(DiscoverFeedTab.following);

  void selectTab(DiscoverFeedTab tab) => emit(tab);
}
