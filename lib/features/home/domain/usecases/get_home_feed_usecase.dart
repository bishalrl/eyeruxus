import 'package:dartz/dartz.dart';
import 'package:eye_rex_us/core/error/failures.dart';
import 'package:eye_rex_us/core/usecases/usecase.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/repositories/home_repository.dart';

class GetHomeFeedParams {
  const GetHomeFeedParams({required this.tab});

  final HomeFeedTab tab;
}

class GetHomeFeedUseCase implements UseCase<HomeFeed, GetHomeFeedParams> {
  GetHomeFeedUseCase(this._repository);

  final HomeRepository _repository;

  @override
  Future<Either<Failure, HomeFeed>> call(GetHomeFeedParams params) {
    return _repository.getHomeFeed(params.tab);
  }
}
