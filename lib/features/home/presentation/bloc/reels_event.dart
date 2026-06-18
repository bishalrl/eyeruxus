import 'package:equatable/equatable.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';

abstract class ReelsEvent extends Equatable {
  const ReelsEvent();

  @override
  List<Object?> get props => [];
}

class ReelsStarted extends ReelsEvent {
  const ReelsStarted({
    required this.initialTab,
    this.initialIndex = 0,
  });

  final ReelsFeedTab initialTab;
  final int initialIndex;

  @override
  List<Object?> get props => [initialTab, initialIndex];
}

class ReelsFeedTabChanged extends ReelsEvent {
  const ReelsFeedTabChanged(this.tab);

  final ReelsFeedTab tab;

  @override
  List<Object?> get props => [tab];
}

class ReelsNearEndReached extends ReelsEvent {
  const ReelsNearEndReached(this.pageIndex);

  final int pageIndex;

  @override
  List<Object?> get props => [pageIndex];
}

class ReelsLikeToggled extends ReelsEvent {
  const ReelsLikeToggled(this.reelId);

  final String reelId;

  @override
  List<Object?> get props => [reelId];
}

class ReelsFollowToggled extends ReelsEvent {
  const ReelsFollowToggled(this.reelId);

  final String reelId;

  @override
  List<Object?> get props => [reelId];
}

class ReelsShareRequested extends ReelsEvent {
  const ReelsShareRequested(this.reelId);

  final String reelId;

  @override
  List<Object?> get props => [reelId];
}

class ReelsCommentsOpened extends ReelsEvent {
  const ReelsCommentsOpened(this.reelId);

  final String reelId;

  @override
  List<Object?> get props => [reelId];
}

class ReelsCommentsClosed extends ReelsEvent {
  const ReelsCommentsClosed();
}

class ReelsCommentSubmitted extends ReelsEvent {
  const ReelsCommentSubmitted({
    required this.reelId,
    required this.text,
  });

  final String reelId;
  final String text;

  @override
  List<Object?> get props => [reelId, text];
}

class ReelsMessageConsumed extends ReelsEvent {
  const ReelsMessageConsumed();
}
