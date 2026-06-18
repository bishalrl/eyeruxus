import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final int? id;
  final String? username;
  final String? email;
  final String? displayName;
  final String? avatarUrl;
  final String? role;

  const UserProfile({
    this.id,
    this.username,
    this.email,
    this.displayName,
    this.avatarUrl,
    this.role,
  });

  @override
  List<Object?> get props =>
      [id, username, email, displayName, avatarUrl, role];
}
