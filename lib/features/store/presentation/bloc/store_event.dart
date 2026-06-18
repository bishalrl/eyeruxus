part of 'store_bloc.dart';

abstract class StoreEvent extends Equatable {
  const StoreEvent();

  @override
  List<Object?> get props => [];
}

class StoreProductsRequested extends StoreEvent {
  final String? category;

  const StoreProductsRequested({this.category});

  @override
  List<Object?> get props => [category];
}
