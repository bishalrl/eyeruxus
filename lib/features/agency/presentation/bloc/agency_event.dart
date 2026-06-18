part of 'agency_bloc.dart';

abstract class AgencyEvent extends Equatable {
  const AgencyEvent();

  @override
  List<Object?> get props => [];
}

class AgencyApplicationRequested extends AgencyEvent {
  final int userId;
  final String accessToken;

  const AgencyApplicationRequested({
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userId, accessToken];
}
