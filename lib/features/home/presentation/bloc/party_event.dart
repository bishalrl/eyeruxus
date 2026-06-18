import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:equatable/equatable.dart';

sealed class PartyEvent extends Equatable {
  const PartyEvent();

  @override
  List<Object?> get props => [];
}

class PartyFeedRequested extends PartyEvent {
  const PartyFeedRequested({this.tab});

  final PartyFeedTab? tab;
}

class PartyTabChanged extends PartyEvent {
  const PartyTabChanged(this.tab);

  final PartyFeedTab tab;

  @override
  List<Object?> get props => [tab];
}
