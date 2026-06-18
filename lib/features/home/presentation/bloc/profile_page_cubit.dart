import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileViewData extends Equatable {
  const ProfileViewData({
    required this.displayName,
    required this.userId,
    required this.initial,
    required this.age,
    required this.diamonds,
    required this.shieldLevel,
    required this.friends,
    required this.following,
    required this.followers,
    required this.coins,
    required this.points,
    required this.inviteRewardPerPerson,
  });

  final String displayName;
  final String userId;
  final String initial;
  final int age;
  final int diamonds;
  final int shieldLevel;
  final int friends;
  final int following;
  final int followers;
  final int coins;
  final int points;
  final int inviteRewardPerPerson;

  static const mock = ProfileViewData(
    displayName: 'SeemsVerma',
    userId: '64189038',
    initial: 'S',
    age: 18,
    diamonds: 1,
    shieldLevel: 1,
    friends: 0,
    following: 0,
    followers: 0,
    coins: 100,
    points: 0,
    inviteRewardPerPerson: 514,
  );

  @override
  List<Object?> get props => [
        displayName,
        userId,
        initial,
        age,
        diamonds,
        shieldLevel,
        friends,
        following,
        followers,
        coins,
        points,
        inviteRewardPerPerson,
      ];
}

class ProfilePageCubit extends Cubit<ProfileViewData> {
  ProfilePageCubit() : super(ProfileViewData.mock);
}
