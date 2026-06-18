abstract class UserEvent {}

class LoadUserProfileEvent extends UserEvent {
  final int userId;
  final String accessToken;

  LoadUserProfileEvent({required this.userId, required this.accessToken});
}

class UpdateUserProfileEvent extends UserEvent {
  final int userId;
  final String accessToken;
  final Map<String, dynamic> data;

  UpdateUserProfileEvent({
    required this.userId,
    required this.accessToken,
    required this.data,
  });
}
