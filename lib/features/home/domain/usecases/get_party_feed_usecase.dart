import 'package:dartz/dartz.dart';
import 'package:eye_rex_us/core/error/failures.dart';
import 'package:eye_rex_us/core/usecases/usecase.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:eye_rex_us/features/home/domain/repositories/party_repository.dart';

class GetPartyFeedParams {
  const GetPartyFeedParams({required this.tab});

  final PartyFeedTab tab;
}

class GetPartyFeedUseCase implements UseCase<PartyFeed, GetPartyFeedParams> {
  GetPartyFeedUseCase(this._repository);

  final PartyRepository _repository;

  @override
  Future<Either<Failure, PartyFeed>> call(GetPartyFeedParams params) {
    return _repository.getPartyFeed(params.tab);
  }
}
