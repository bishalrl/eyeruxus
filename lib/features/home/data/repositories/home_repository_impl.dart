import 'package:dartz/dartz.dart';
import 'package:eye_rex_us/core/error/failures.dart';
import 'package:eye_rex_us/features/home/data/datasources/home_local_datasource.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/repositories/home_repository.dart';

class HomeRepositoryImpl implements HomeRepository {
  HomeRepositoryImpl(this._localDataSource);

  final HomeLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, HomeFeed>> getHomeFeed(HomeFeedTab tab) async {
    try {
      final stories = await _localDataSource.getStories(tab: tab);
      final rooms = await _localDataSource.getLiveRooms(tab: tab);
      return Right(HomeFeed(stories: stories, rooms: rooms));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
