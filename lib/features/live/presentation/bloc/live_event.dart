part of 'live_bloc.dart';

abstract class LiveEvent extends Equatable {
  const LiveEvent();

  @override
  List<Object?> get props => [];
}

class LiveRoomsRequested extends LiveEvent {
  final String accessToken;
  final String? sessionType;
  final String scopeKey;

  const LiveRoomsRequested({
    required this.accessToken,
    required this.scopeKey,
    this.sessionType,
  });

  @override
  List<Object?> get props => [accessToken, sessionType, scopeKey];
}
