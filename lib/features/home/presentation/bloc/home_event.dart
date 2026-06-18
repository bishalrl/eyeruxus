import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/home/domain/entities/home_feed_tab.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class LoadHomeDataEvent extends HomeEvent {
  const LoadHomeDataEvent({this.tab = HomeFeedTab.explore});

  final HomeFeedTab tab;

  @override
  List<Object?> get props => [tab];
}

class ChangeHomeFeedTabEvent extends HomeEvent {
  const ChangeHomeFeedTabEvent(this.tab);

  final HomeFeedTab tab;

  @override
  List<Object?> get props => [tab];
}
