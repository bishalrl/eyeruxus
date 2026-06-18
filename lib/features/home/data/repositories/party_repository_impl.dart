import 'package:dartz/dartz.dart';
import 'package:eye_rex_us/core/error/failures.dart';
import 'package:eye_rex_us/features/home/data/datasources/party_local_datasource.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:eye_rex_us/features/home/domain/repositories/party_repository.dart';

class PartyRepositoryImpl implements PartyRepository {
  PartyRepositoryImpl(this._localDataSource);

  final PartyLocalDataSource _localDataSource;

  @override
  Future<Either<Failure, PartyFeed>> getPartyFeed(PartyFeedTab tab) async {
    try {
      final feed = await _localDataSource.getPartyFeed(tab: tab);
      return Right(feed);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
