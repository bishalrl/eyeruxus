part of 'live_bloc.dart';

abstract class LiveState extends Equatable {
  const LiveState();

  @override
  List<Object?> get props => [];
}

class LiveInitial extends LiveState {
  const LiveInitial();
}

class LiveLoading extends LiveState {
  const LiveLoading({required this.scopeKey, this.sessionType});

  final String scopeKey;
  final String? sessionType;

  @override
  List<Object?> get props => [scopeKey, sessionType];
}

class LiveLoaded extends LiveState {
  final List<LiveRoom> rooms;
  final String scopeKey;
  final String? sessionType;

  const LiveLoaded(
    this.rooms, {
    required this.scopeKey,
    this.sessionType,
  });

  @override
  List<Object?> get props => [rooms, scopeKey, sessionType];
}

class LiveFailure extends LiveState {
  final String message;

  const LiveFailure(this.message);

  @override
  List<Object?> get props => [message];
}
