import 'package:equatable/equatable.dart';

import 'user_profile.dart';

/// Read-only profile shown when viewing another user (e.g. from a live room).
class PublicUserProfile extends Equatable {
  const PublicUserProfile({
    required this.userId,
    required this.displayName,
    required this.avatarUrl,
    required this.followers,
    required this.following,
    required this.friends,
    this.age = 18,
    this.diamonds = 0,
    this.shieldLevel = 1,
  });

  final String userId;
  final String displayName;
  final String avatarUrl;
  final int followers;
  final int following;
  final int friends;
  final int age;
  final int diamonds;
  final int shieldLevel;

  String get initial =>
      displayName.isNotEmpty ? displayName[0].toUpperCase() : '?';

  factory PublicUserProfile.fromPreview({
    required String userId,
    required String displayName,
    required String avatarUrl,
  }) {
    final seed = userId.hashCode.abs();
    return PublicUserProfile(
      userId: userId,
      displayName: displayName,
      avatarUrl: avatarUrl,
      followers: 120 + seed % 9000,
      following: 40 + seed % 400,
      friends: 10 + seed % 120,
      diamonds: seed % 500,
      shieldLevel: 1 + seed % 5,
    );
  }

  factory PublicUserProfile.fromEntity(
    UserProfile profile, {
    required String fallbackUserId,
    required String fallbackName,
    required String fallbackAvatar,
  }) {
    return PublicUserProfile(
      userId: '${profile.id ?? fallbackUserId}',
      displayName: profile.displayName ?? profile.username ?? fallbackName,
      avatarUrl: profile.avatarUrl ?? fallbackAvatar,
      followers: 0,
      following: 0,
      friends: 0,
    );
  }

  @override
  List<Object?> get props => [userId, displayName, avatarUrl];
}
