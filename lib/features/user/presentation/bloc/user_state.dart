part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object?> get props => [];
}

class UserInitial extends UserState {
  const UserInitial();
}

class UserLoading extends UserState {
  const UserLoading();
}

class UserLoaded extends UserState {
  final UserProfile profile;

  const UserLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class UserFailure extends UserState {
  final String message;

  const UserFailure(this.message);

  @override
  List<Object?> get props => [message];
}
