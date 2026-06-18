import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';
import 'package:eye_rex_us/features/home/domain/entities/room_entity.dart';
import 'package:eye_rex_us/features/home/domain/entities/story_entity.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object?> get props => [];
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

class HomeLoadingState extends HomeState {
  const HomeLoadingState({this.tab = HomeFeedTab.explore});

  final HomeFeedTab tab;

  @override
  List<Object?> get props => [tab];
}

class HomeLoadedState extends HomeState {
  const HomeLoadedState({
    required this.stories,
    required this.rooms,
    required this.selectedTab,
  });

  final List<StoryEntity> stories;
  final List<RoomEntity> rooms;
  final HomeFeedTab selectedTab;

  @override
  List<Object?> get props => [stories, rooms, selectedTab];
}

class HomeErrorState extends HomeState {
  const HomeErrorState({required this.errorMessage});

  final String errorMessage;

  @override
  List<Object?> get props => [errorMessage];
}
