import 'package:dartz/dartz.dart';
import 'package:eye_rex_us/core/error/failures.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';

abstract class PartyRepository {
  Future<Either<Failure, PartyFeed>> getPartyFeed(PartyFeedTab tab);
}
