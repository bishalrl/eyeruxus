import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../entities/store_product.dart';

abstract class StoreRepository {
  Future<Either<Failure, List<StoreProduct>>> getProducts({String? category});
}
