import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/store_product.dart';
import '../../domain/usecases/get_store_products_usecase.dart';

part 'store_event.dart';
part 'store_state.dart';

class StoreBloc extends Bloc<StoreEvent, StoreState> {
  final GetStoreProductsUseCase getStoreProductsUseCase;

  StoreBloc({required this.getStoreProductsUseCase}) : super(const StoreInitial()) {
    on<StoreProductsRequested>(_onProductsRequested);
  }

  Future<void> _onProductsRequested(
    StoreProductsRequested event,
    Emitter<StoreState> emit,
  ) async {
    emit(const StoreLoading());
    final result = await getStoreProductsUseCase(
      GetStoreProductsParams(category: event.category),
    );
    result.fold(
      (failure) => emit(StoreFailure(failure.message)),
      (products) => emit(StoreLoaded(products)),
    );
  }
}
