import 'package:eye_rex_us/features/home/data/datasources/reels_local_datasource.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_comment.dart';
import 'package:eye_rex_us/features/home/domain/entities/reel_post.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'reels_event.dart';
import 'reels_state.dart';

class ReelsBloc extends Bloc<ReelsEvent, ReelsState> {
  ReelsBloc() : super(_initialState(ReelsFeedTab.forYou)) {
    on<ReelsStarted>(_onStarted);
    on<ReelsFeedTabChanged>(_onFeedTabChanged);
    on<ReelsNearEndReached>(_onNearEndReached);
    on<ReelsLikeToggled>(_onLikeToggled);
    on<ReelsFollowToggled>(_onFollowToggled);
    on<ReelsShareRequested>(_onShareRequested);
    on<ReelsCommentsOpened>(_onCommentsOpened);
    on<ReelsCommentsClosed>(_onCommentsClosed);
    on<ReelsCommentSubmitted>(_onCommentSubmitted);
    on<ReelsMessageConsumed>(_onMessageConsumed);
  }

  static ReelsState _initialState(ReelsFeedTab tab) {
    return ReelsState(
      feedTab: tab,
      reels: ReelsLocalDataSource.initialFeed(tab),
      initialPageIndex: 0,
      pagerKey: 0,
    );
  }

  void _onStarted(ReelsStarted event, Emitter<ReelsState> emit) {
    emit(
      ReelsState(
        feedTab: event.initialTab,
        reels: ReelsLocalDataSource.initialFeed(event.initialTab),
        initialPageIndex: event.initialIndex,
        pagerKey: 0,
      ),
    );
  }

  void _onFeedTabChanged(ReelsFeedTabChanged event, Emitter<ReelsState> emit) {
    if (event.tab == state.feedTab) return;
    emit(
      ReelsState(
        feedTab: event.tab,
        reels: ReelsLocalDataSource.initialFeed(event.tab),
        initialPageIndex: 0,
        pagerKey: state.pagerKey + 1,
        likedReelIds: state.likedReelIds,
        followingOverrides: state.followingOverrides,
        commentsByReelId: state.commentsByReelId,
      ),
    );
  }

  void _onNearEndReached(ReelsNearEndReached event, Emitter<ReelsState> emit) {
    if (event.pageIndex < state.reels.length - 2) return;
    emit(
      state.copyWith(
        reels: [
          ...state.reels,
          ...ReelsLocalDataSource.loadMore(state.feedTab, state.reels.length),
        ],
      ),
    );
  }

  void _onLikeToggled(ReelsLikeToggled event, Emitter<ReelsState> emit) {
    final liked = Set<String>.from(state.likedReelIds);
    final reelIndex = state.reels.indexWhere((r) => r.id == event.reelId);
    if (reelIndex < 0) return;

    final reel = state.reels[reelIndex];
    final wasLiked = liked.contains(event.reelId);
    if (wasLiked) {
      liked.remove(event.reelId);
    } else {
      liked.add(event.reelId);
    }

    final reels = List<ReelPost>.from(state.reels);
    reels[reelIndex] = reel.copyWith(
      likeCount: reel.likeCount + (wasLiked ? -1 : 1),
    );

    emit(state.copyWith(reels: reels, likedReelIds: liked));
  }

  void _onFollowToggled(ReelsFollowToggled event, Emitter<ReelsState> emit) {
    final reel = state.reels.cast<ReelPost?>().firstWhere(
          (r) => r?.id == event.reelId,
          orElse: () => null,
        );
    if (reel == null) return;

    final overrides = Map<String, bool>.from(state.followingOverrides);
    final current = overrides[event.reelId] ?? reel.isFollowing;
    overrides[event.reelId] = !current;
    emit(state.copyWith(followingOverrides: overrides));
  }

  void _onShareRequested(ReelsShareRequested event, Emitter<ReelsState> emit) {
    emit(state.copyWith(message: () => 'shared'));
  }

  void _onCommentsOpened(ReelsCommentsOpened event, Emitter<ReelsState> emit) {
    final comments = Map<String, List<ReelComment>>.from(state.commentsByReelId);
    comments.putIfAbsent(
      event.reelId,
      () => ReelsLocalDataSource.commentsFor(event.reelId),
    );
    emit(
      state.copyWith(
        commentsByReelId: comments,
        activeCommentsReelId: () => event.reelId,
      ),
    );
  }

  void _onCommentsClosed(ReelsCommentsClosed event, Emitter<ReelsState> emit) {
    emit(state.copyWith(activeCommentsReelId: () => null));
  }

  void _onCommentSubmitted(
    ReelsCommentSubmitted event,
    Emitter<ReelsState> emit,
  ) {
    final text = event.text.trim();
    if (text.isEmpty) return;

    final comments = Map<String, List<ReelComment>>.from(state.commentsByReelId);
    final existing = List<ReelComment>.from(
      comments[event.reelId] ??
          ReelsLocalDataSource.commentsFor(event.reelId),
    );
    existing.insert(0, ReelsLocalDataSource.newComment(text));

    final reelIndex = state.reels.indexWhere((r) => r.id == event.reelId);
    final reels = List<ReelPost>.from(state.reels);
    if (reelIndex >= 0) {
      final reel = reels[reelIndex];
      reels[reelIndex] = reel.copyWith(commentCount: reel.commentCount + 1);
    }

    comments[event.reelId] = existing;
    emit(state.copyWith(reels: reels, commentsByReelId: comments));
  }

  void _onMessageConsumed(
    ReelsMessageConsumed event,
    Emitter<ReelsState> emit,
  ) {
    emit(state.copyWith(message: () => null));
  }
}
