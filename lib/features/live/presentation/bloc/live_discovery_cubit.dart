import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/live/domain/entities/live_session_entities.dart';
import 'package:eye_rex_us/features/live/domain/repositories/live_platform_repository.dart';
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
    this.showFollowing = false,
    this.showFriends = false,
    this.page = 1,
    this.hasMore = true,
    this.isLoadingMore = false,
    this.totalCount = 0,
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
  final bool showFollowing;
  final bool showFriends;
  final int page;
  final bool hasMore;
  final bool isLoadingMore;
  final int totalCount;
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
    bool? showFollowing,
    bool? showFriends,
    int? page,
    bool? hasMore,
    bool? isLoadingMore,
    int? totalCount,
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
      showFollowing: showFollowing ?? this.showFollowing,
      showFriends: showFriends ?? this.showFriends,
      page: page ?? this.page,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      totalCount: totalCount ?? this.totalCount,
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
        showFollowing,
        showFriends,
        page,
        hasMore,
        isLoadingMore,
        totalCount,
        errorMessage,
      ];
}

class LiveDiscoveryCubit extends Cubit<LiveDiscoveryState> {
  LiveDiscoveryCubit(this._platform) : super(const LiveDiscoveryState());

  final LivePlatformRepository _platform;

  Future<void> load() => _fetch(reset: true);

  Future<void> search(String query) async {
    emit(state.copyWith(query: query));
    await _fetch(reset: true);
  }

  Future<void> selectCategory(LiveRoomCategory? category) async {
    emit(state.copyWith(selectedCategory: () => category));
    await _fetch(reset: true);
  }

  Future<void> selectLanguageFilter(String value) async {
    emit(state.copyWith(languageFilter: value));
    await _fetch(reset: true);
  }

  Future<void> selectCountryFilter(String value) async {
    emit(state.copyWith(countryFilter: value));
    await _fetch(reset: true);
  }

  Future<void> toggleTrending(bool value) async {
    emit(state.copyWith(showTrending: value));
    await _fetch(reset: true);
  }

  Future<void> toggleRecommended(bool value) async {
    emit(state.copyWith(showRecommended: value));
    await _fetch(reset: true);
  }

  Future<void> toggleFollowing(bool value) async {
    emit(state.copyWith(showFollowing: value));
    await _fetch(reset: true);
  }

  Future<void> toggleFriends(bool value) async {
    emit(state.copyWith(showFriends: value));
    await _fetch(reset: true);
  }

  Future<void> refresh() => _fetch(reset: true);

  Future<void> loadMore() async {
    if (!state.hasMore || state.isLoadingMore) return;
    emit(state.copyWith(isLoadingMore: true));
    await _fetch(reset: false);
  }

  Future<void> _fetch({required bool reset}) async {
    final nextPage = reset ? 1 : state.page + 1;
    if (reset) {
      emit(state.copyWith(status: LiveDiscoveryStatus.loading, page: 1));
    }
    try {
      final result = await _platform.discoverRoomsPage(
        page: nextPage,
        query: state.query.isEmpty ? null : state.query,
        category: state.selectedCategory,
        countryCode: state.countryFilter == 'All' ? null : state.countryFilter,
        languageCode: state.languageFilter == 'All' ? null : state.languageFilter,
        trendingOnly: state.showTrending,
        promotedOnly: state.showRecommended,
        followingOnly: state.showFollowing,
        friendsOnly: state.showFriends,
      );
      final merged = reset ? result.rooms : [...state.rooms, ...result.rooms];
      emit(
        state.copyWith(
          status: LiveDiscoveryStatus.loaded,
          rooms: merged,
          page: nextPage,
          hasMore: result.hasMore,
          isLoadingMore: false,
          totalCount: result.totalCount,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: LiveDiscoveryStatus.error,
          isLoadingMore: false,
          errorMessage: () => e.toString(),
        ),
      );
    }
  }
}
