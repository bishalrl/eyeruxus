part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class UserProfileLoadRequested extends UserEvent {
  final int userId;
  final String accessToken;

  const UserProfileLoadRequested({
    required this.userId,
    required this.accessToken,
  });

  @override
  List<Object?> get props => [userId, accessToken];
}

class UserProfileUpdateRequested extends UserEvent {
  final int userId;
  final String accessToken;
  final Map<String, dynamic> data;

  const UserProfileUpdateRequested({
    required this.userId,
    required this.accessToken,
    required this.data,
  });

  @override
  List<Object?> get props => [userId, accessToken, data];
}
