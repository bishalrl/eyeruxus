import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/user_profile.dart';
import '../../domain/repositories/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository repository;

  UserBloc(this.repository) : super(const UserInitial()) {
    on<UserProfileLoadRequested>(_onLoadProfile);
    on<UserProfileUpdateRequested>(_onUpdateProfile);
  }

  Future<void> _onLoadProfile(
    UserProfileLoadRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await repository.getProfile(
      userId: event.userId,
      accessToken: event.accessToken,
    );
    result.fold(
      (failure) => emit(UserFailure(failure.message)),
      (profile) => emit(UserLoaded(profile)),
    );
  }

  Future<void> _onUpdateProfile(
    UserProfileUpdateRequested event,
    Emitter<UserState> emit,
  ) async {
    emit(const UserLoading());
    final result = await repository.updateProfile(
      userId: event.userId,
      accessToken: event.accessToken,
      data: event.data,
    );
    result.fold(
      (failure) => emit(UserFailure(failure.message)),
      (profile) => emit(UserLoaded(profile)),
    );
  }
}
