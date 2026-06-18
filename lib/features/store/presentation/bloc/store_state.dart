part of 'store_bloc.dart';

abstract class StoreState extends Equatable {
  const StoreState();

  @override
  List<Object?> get props => [];
}

class StoreInitial extends StoreState {
  const StoreInitial();
}

class StoreLoading extends StoreState {
  const StoreLoading();
}

class StoreLoaded extends StoreState {
  final List<StoreProduct> products;

  const StoreLoaded(this.products);

  @override
  List<Object?> get props => [products];
}

class StoreFailure extends StoreState {
  final String message;

  const StoreFailure(this.message);

  @override
  List<Object?> get props => [message];
}
