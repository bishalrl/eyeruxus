import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/store_product.dart';
import '../repositories/store_repository.dart';

class GetStoreProductsUseCase
    implements UseCase<List<StoreProduct>, GetStoreProductsParams> {
  final StoreRepository repository;

  GetStoreProductsUseCase(this.repository);

  @override
  Future<Either<Failure, List<StoreProduct>>> call(
    GetStoreProductsParams params,
  ) {
    return repository.getProducts(category: params.category);
  }
}

class GetStoreProductsParams extends Equatable {
  final String? category;

  const GetStoreProductsParams({this.category});

  @override
  List<Object?> get props => [category];
}
