import '../../domain/entities/user_profile.dart';

class UserProfileModel extends UserProfile {
  const UserProfileModel({
    super.id,
    super.username,
    super.email,
    super.displayName,
    super.avatarUrl,
    super.role,
  });

  factory UserProfileModel.fromJson(Map<String, dynamic> json) {
    return UserProfileModel(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      displayName: json['display_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String?,
    );
  }
}
