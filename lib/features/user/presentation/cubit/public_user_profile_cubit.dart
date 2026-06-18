import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/public_user_profile.dart';
import '../../domain/repositories/user_repository.dart';

enum PublicUserProfileStatus { initial, loading, ready, error }

class PublicUserProfileState extends Equatable {
  const PublicUserProfileState({
    this.status = PublicUserProfileStatus.initial,
    this.profile,
    this.errorMessage,
  });

  final PublicUserProfileStatus status;
  final PublicUserProfile? profile;
  final String? errorMessage;

  PublicUserProfileState copyWith({
    PublicUserProfileStatus? status,
    PublicUserProfile? profile,
    String? Function()? errorMessage,
  }) {
    return PublicUserProfileState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, profile, errorMessage];
}

class PublicUserProfileQuery {
  const PublicUserProfileQuery({
    required this.userId,
    required this.displayName,
    required this.avatarUrl,
    this.accessToken = 'dev',
  });

  final String userId;
  final String displayName;
  final String avatarUrl;
  final String accessToken;
}

class PublicUserProfileCubit extends Cubit<PublicUserProfileState> {
  PublicUserProfileCubit(this._repository, this._query)
      : super(const PublicUserProfileState());

  final UserRepository _repository;
  final PublicUserProfileQuery _query;

  Future<void> load() async {
    emit(state.copyWith(status: PublicUserProfileStatus.loading));
    final preview = PublicUserProfile.fromPreview(
      userId: _query.userId,
      displayName: _query.displayName,
      avatarUrl: _query.avatarUrl,
    );

    final numericId = _numericUserId(_query.userId);
    if (numericId == null) {
      emit(
        state.copyWith(
          status: PublicUserProfileStatus.ready,
          profile: preview,
        ),
      );
      return;
    }

    final result = await _repository.getProfile(
      userId: numericId,
      accessToken: _query.accessToken,
    );

    result.fold(
      (_) => emit(
        state.copyWith(
          status: PublicUserProfileStatus.ready,
          profile: preview,
        ),
      ),
      (entity) => emit(
        state.copyWith(
          status: PublicUserProfileStatus.ready,
          profile: PublicUserProfile.fromEntity(
            entity,
            fallbackUserId: _query.userId,
            fallbackName: _query.displayName,
            fallbackAvatar: _query.avatarUrl,
          ),
        ),
      ),
    );
  }

  int? _numericUserId(String raw) {
    final direct = int.tryParse(raw);
    if (direct != null) return direct;
    final digits = RegExp(r'\d+').allMatches(raw).map((m) => m.group(0)).join();
    if (digits.isEmpty) return null;
    return int.tryParse(digits);
  }
}
