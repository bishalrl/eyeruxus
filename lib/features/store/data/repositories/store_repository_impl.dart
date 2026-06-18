import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/store_product.dart';
import '../../domain/repositories/store_repository.dart';
import '../datasources/store_local_datasource.dart';
import '../models/store_product_model.dart';

class StoreRepositoryImpl implements StoreRepository {
  final StoreLocalDataSource localDataSource;

  StoreRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, List<StoreProduct>>> getProducts({
    String? category,
  }) async {
    try {
      final rows = await localDataSource.getCatalog(category: category);
      return Right(rows.map(StoreProductModel.fromJson).toList());
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
