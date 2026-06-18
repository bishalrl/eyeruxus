import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/domain/repositories/live_session_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

enum LiveDiscoveryStatus { initial, loading, loaded, error }

class LiveDiscoveryState extends Equatable {
  const LiveDiscoveryState({
    this.status = LiveDiscoveryStatus.initial,
    this.rooms = const [],
    this.query = '',
    this.selectedCategory,
    this.languageFilter = 'All',
    this.countryFilter = 'All',
    this.showTrending = false,
    this.showRecommended = false,
    this.errorMessage,
  });

  final LiveDiscoveryStatus status;
  final List<LiveRoomListing> rooms;
  final String query;
  final LiveRoomCategory? selectedCategory;
  final String languageFilter;
  final String countryFilter;
  final bool showTrending;
  final bool showRecommended;
  final String? errorMessage;

  LiveDiscoveryState copyWith({
    LiveDiscoveryStatus? status,
    List<LiveRoomListing>? rooms,
    String? query,
    LiveRoomCategory? Function()? selectedCategory,
    String? languageFilter,
    String? countryFilter,
    bool? showTrending,
    bool? showRecommended,
    String? Function()? errorMessage,
  }) {
    return LiveDiscoveryState(
      status: status ?? this.status,
      rooms: rooms ?? this.rooms,
      query: query ?? this.query,
      selectedCategory:
          selectedCategory != null ? selectedCategory() : this.selectedCategory,
      languageFilter: languageFilter ?? this.languageFilter,
      countryFilter: countryFilter ?? this.countryFilter,
      showTrending: showTrending ?? this.showTrending,
      showRecommended: showRecommended ?? this.showRecommended,
      errorMessage: errorMessage != null ? errorMessage() : this.errorMessage,
    );
  }

  List<LiveRoomListing> get trending =>
      rooms.where((r) => r.isTrending).toList();

  List<LiveRoomListing> get popular =>
      rooms.where((r) => r.isPopular).toList();

  List<LiveRoomListing> get recommended =>
      rooms.where((r) => r.isRecommended).toList();

  List<LiveRoomListing> get following =>
      rooms.where((r) => r.isFollowing).toList();

  List<LiveRoomListing> get nearby =>
      rooms.where((r) => r.isNearby).toList();

  List<LiveRoomListing> get newCreators =>
      rooms.where((r) => r.isNewCreator).toList();

  @override
  List<Object?> get props => [
        status,
        rooms,
        query,
        selectedCategory,
        languageFilter,
        countryFilter,
        showTrending,
        showRecommended,
        errorMessage,
      ];
}

class LiveDiscoveryCubit extends Cubit<LiveDiscoveryState> {
  LiveDiscoveryCubit(this._repository) : super(const LiveDiscoveryState());

  final LiveSessionRepository _repository;

  Future<void> load() => _fetch();

  Future<void> search(String query) async {
    emit(state.copyWith(query: query));
    await _fetch();
  }

  Future<void> selectCategory(LiveRoomCategory? category) async {
    emit(state.copyWith(selectedCategory: () => category));
    await _fetch();
  }

  Future<void> selectLanguageFilter(String value) async {
    emit(state.copyWith(languageFilter: value));
    await _fetch();
  }

  Future<void> selectCountryFilter(String value) async {
    emit(state.copyWith(countryFilter: value));
    await _fetch();
  }

  Future<void> toggleTrending(bool value) async {
    emit(state.copyWith(showTrending: value));
    await _fetch();
  }

  Future<void> toggleRecommended(bool value) async {
    emit(state.copyWith(showRecommended: value));
    await _fetch();
  }

  Future<void> refresh() => _fetch();

  Future<void> _fetch() async {
    emit(state.copyWith(status: LiveDiscoveryStatus.loading));
    try {
      final rooms = await _repository.discoverRooms(
        query: state.query.isEmpty ? null : state.query,
        category: state.selectedCategory,
        trendingOnly: state.showTrending,
        recommendedOnly: state.showRecommended,
      );
      emit(
        state.copyWith(
          status: LiveDiscoveryStatus.loaded,
          rooms: rooms,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LiveDiscoveryStatus.error,
          errorMessage: () => e.toString(),
        ),
      );
    }
  }
}
