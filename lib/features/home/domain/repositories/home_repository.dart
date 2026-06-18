import 'package:dartz/dartz.dart';
import 'package:eye_rex_us/core/error/failures.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';

abstract class HomeRepository {
  Future<Either<Failure, HomeFeed>> getHomeFeed(HomeFeedTab tab);
}
