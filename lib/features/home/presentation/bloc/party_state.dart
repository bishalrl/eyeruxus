import 'package:eye_rex_us/features/home/domain/entities/party_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/entities/party_room.dart';
import 'package:equatable/equatable.dart';

sealed class PartyState extends Equatable {
  const PartyState();

  @override
  List<Object?> get props => [];
}

class PartyInitial extends PartyState {
  const PartyInitial();
}

class PartyLoading extends PartyState {
  const PartyLoading({required this.tab});

  final PartyFeedTab tab;

  @override
  List<Object?> get props => [tab];
}

class PartyLoaded extends PartyState {
  const PartyLoaded({
    required this.tab,
    required this.rooms,
    required this.friendsInParty,
  });

  final PartyFeedTab tab;
  final List<PartyRoom> rooms;
  final List<PartyFriendActivity> friendsInParty;

  @override
  List<Object?> get props => [tab, rooms, friendsInParty];
}

class PartyError extends PartyState {
  const PartyError({required this.message, required this.tab});

  final String message;
  final PartyFeedTab tab;

  @override
  List<Object?> get props => [message, tab];
}
