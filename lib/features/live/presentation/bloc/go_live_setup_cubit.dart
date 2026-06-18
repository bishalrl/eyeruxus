import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum GoLiveMediaMode { video, voice }

enum GoLiveSessionMode { live, party }

class GoLiveSetupState extends Equatable {
  const GoLiveSetupState({
    this.mediaMode = GoLiveMediaMode.video,
    this.sessionMode = GoLiveSessionMode.live,
    this.selectedLayoutRoomId = 'movie',
    this.selectedCategoryIndex = 0,
    this.title = '',
    this.description = '',
    this.language = 'English',
    this.privacy = LiveRoomPrivacy.publicRoom,
    this.password = '',
    this.coverImageUrl,
  });

  final GoLiveMediaMode mediaMode;
  final GoLiveSessionMode sessionMode;
  final String selectedLayoutRoomId;
  final int selectedCategoryIndex;
  final String title;
  final String description;
  final String language;
  final LiveRoomPrivacy privacy;
  final String password;
  final String? coverImageUrl;

  LiveRoomCategory get category => LiveRoomCategory.values[selectedCategoryIndex % 5];

  GoLiveSetupState copyWith({
    GoLiveMediaMode? mediaMode,
    GoLiveSessionMode? sessionMode,
    String? selectedLayoutRoomId,
    int? selectedCategoryIndex,
    String? title,
    String? description,
    String? language,
    LiveRoomPrivacy? privacy,
    String? password,
    String? Function()? coverImageUrl,
  }) {
    return GoLiveSetupState(
      mediaMode: mediaMode ?? this.mediaMode,
      sessionMode: sessionMode ?? this.sessionMode,
      selectedLayoutRoomId: selectedLayoutRoomId ?? this.selectedLayoutRoomId,
      selectedCategoryIndex: selectedCategoryIndex ?? this.selectedCategoryIndex,
      title: title ?? this.title,
      description: description ?? this.description,
      language: language ?? this.language,
      privacy: privacy ?? this.privacy,
      password: password ?? this.password,
      coverImageUrl: coverImageUrl != null ? coverImageUrl() : this.coverImageUrl,
    );
  }

  @override
  List<Object?> get props => [
        mediaMode,
        sessionMode,
        selectedLayoutRoomId,
        selectedCategoryIndex,
        title,
        description,
        language,
        privacy,
        password,
        coverImageUrl,
      ];
}

class GoLiveSetupCubit extends Cubit<GoLiveSetupState> {
  GoLiveSetupCubit() : super(const GoLiveSetupState());

  void selectCategory(int index) {
    emit(state.copyWith(selectedCategoryIndex: index));
  }

  void setSessionMode(GoLiveSessionMode mode) {
    emit(state.copyWith(sessionMode: mode));
  }

  void setMediaMode(GoLiveMediaMode mode) {
    emit(state.copyWith(mediaMode: mode));
  }

  void selectLayout(String roomId) {
    emit(state.copyWith(selectedLayoutRoomId: roomId));
  }

  void setTitle(String value) => emit(state.copyWith(title: value));

  void setDescription(String value) => emit(state.copyWith(description: value));

  void setLanguage(String value) => emit(state.copyWith(language: value));

  void setPrivacy(LiveRoomPrivacy privacy) => emit(state.copyWith(privacy: privacy));

  void setPassword(String value) => emit(state.copyWith(password: value));

  void setCoverImage(String? url) => emit(state.copyWith(coverImageUrl: () => url));
}
