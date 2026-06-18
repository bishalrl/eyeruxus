class UserModel {
  final int? id;
  final String? uuid;
  final String? username;
  final String? email;
  final String? mobile;
  final String? role;
  final String? displayName;
  final String? bio;
  final String? avatarUrl;
  final String? coverImageUrl;
  final String? location;
  final double? latitude;
  final double? longitude;
  final String? dob;
  final String? gender;
  final List<String>? languages;
  final List<String>? interests;
  final String? verificationStatus;
  final int? profileViews;
  final double? rating;
  final bool? isPrivate;
  final int? retinaCapturePermission;
  final List<int>? subscriptionPlanIds;
  final int? activeSubscriptionCount;
  final String? createdAt;
  final String? updatedAt;

  UserModel({
    this.id,
    this.uuid,
    this.username,
    this.email,
    this.mobile,
    this.role,
    this.displayName,
    this.bio,
    this.avatarUrl,
    this.coverImageUrl,
    this.location,
    this.latitude,
    this.longitude,
    this.dob,
    this.gender,
    this.languages,
    this.interests,
    this.verificationStatus,
    this.profileViews,
    this.rating,
    this.isPrivate,
    this.retinaCapturePermission,
    this.subscriptionPlanIds,
    this.activeSubscriptionCount,
    this.createdAt,
    this.updatedAt,
  });

  // Empty constructor
  factory UserModel.empty() {
    return UserModel(
      id: null,
      uuid: null,
      username: null,
      email: null,
      mobile: null,
      role: null,
      displayName: null,
      bio: null,
      avatarUrl: null,
      coverImageUrl: null,
      location: null,
      latitude: null,
      longitude: null,
      dob: null,
      gender: null,
      languages: null,
      interests: null,
      verificationStatus: null,
      profileViews: null,
      rating: null,
      isPrivate: null,
      retinaCapturePermission: null,
      subscriptionPlanIds: null,
      activeSubscriptionCount: null,
      createdAt: null,
      updatedAt: null,
    );
  }

  // From Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      uuid: map['uuid'] as String?,
      username: map['username'] as String?,
      email: map['email'] as String?,
      mobile: map['mobile'] as String?,
      role: map['role'] as String?,
      displayName: map['display_name'] as String?,
      bio: map['bio'] as String?,
      avatarUrl: map['avatar_url'] as String?,
      coverImageUrl: map['cover_image_url'] as String?,
      location: map['location'] as String?,
      latitude: map['latitude'] != null ? (map['latitude'] as num).toDouble() : null,
      longitude: map['longitude'] != null ? (map['longitude'] as num).toDouble() : null,
      dob: map['dob'] as String?,
      gender: map['gender'] as String?,
      languages: map['languages'] != null
          ? List<String>.from(map['languages'] as List)
          : null,
      interests: map['interests'] != null
          ? List<String>.from(map['interests'] as List)
          : null,
      verificationStatus: map['verification_status'] as String?,
      profileViews: map['profile_views'] as int?,
      rating: map['rating'] != null ? (map['rating'] as num).toDouble() : null,
      isPrivate: map['is_private'] != null
          ? (map['is_private'] == 1 || map['is_private'] == true)
          : null,
      retinaCapturePermission: map['retina_capture_permission'] as int?,
      subscriptionPlanIds: map['subscription_plan_ids'] != null
          ? List<int>.from(map['subscription_plan_ids'] as List)
          : null,
      activeSubscriptionCount: map['active_subscription_count'] as int?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'username': username,
      'email': email,
      'mobile': mobile,
      'role': role,
      'display_name': displayName,
      'bio': bio,
      'avatar_url': avatarUrl,
      'cover_image_url': coverImageUrl,
      'location': location,
      'latitude': latitude,
      'longitude': longitude,
      'dob': dob,
      'gender': gender,
      'languages': languages,
      'interests': interests,
      'verification_status': verificationStatus,
      'profile_views': profileViews,
      'rating': rating,
      'is_private': isPrivate != null ? (isPrivate! ? 1 : 0) : null,
      'retina_capture_permission': retinaCapturePermission,
      'subscription_plan_ids': subscriptionPlanIds,
      'active_subscription_count': activeSubscriptionCount,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }

  // CopyWith
  UserModel copyWith({
    int? id,
    String? uuid,
    String? username,
    String? email,
    String? mobile,
    String? role,
    String? displayName,
    String? bio,
    String? avatarUrl,
    String? coverImageUrl,
    String? location,
    double? latitude,
    double? longitude,
    String? dob,
    String? gender,
    List<String>? languages,
    List<String>? interests,
    String? verificationStatus,
    int? profileViews,
    double? rating,
    bool? isPrivate,
    int? retinaCapturePermission,
    List<int>? subscriptionPlanIds,
    int? activeSubscriptionCount,
    String? createdAt,
    String? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      username: username ?? this.username,
      email: email ?? this.email,
      mobile: mobile ?? this.mobile,
      role: role ?? this.role,
      displayName: displayName ?? this.displayName,
      bio: bio ?? this.bio,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      coverImageUrl: coverImageUrl ?? this.coverImageUrl,
      location: location ?? this.location,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      dob: dob ?? this.dob,
      gender: gender ?? this.gender,
      languages: languages ?? this.languages,
      interests: interests ?? this.interests,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      profileViews: profileViews ?? this.profileViews,
      rating: rating ?? this.rating,
      isPrivate: isPrivate ?? this.isPrivate,
      retinaCapturePermission: retinaCapturePermission ?? this.retinaCapturePermission,
      subscriptionPlanIds: subscriptionPlanIds ?? this.subscriptionPlanIds,
      activeSubscriptionCount: activeSubscriptionCount ?? this.activeSubscriptionCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  // ToString
  @override
  String toString() {
    return 'UserModel(id: $id, uuid: $uuid, username: $username, email: $email, mobile: $mobile, role: $role, displayName: $displayName, bio: $bio, avatarUrl: $avatarUrl, coverImageUrl: $coverImageUrl, location: $location, latitude: $latitude, longitude: $longitude, dob: $dob, gender: $gender, languages: $languages, interests: $interests, verificationStatus: $verificationStatus, profileViews: $profileViews, rating: $rating, isPrivate: $isPrivate, retinaCapturePermission: $retinaCapturePermission, subscriptionPlanIds: $subscriptionPlanIds, activeSubscriptionCount: $activeSubscriptionCount, createdAt: $createdAt, updatedAt: $updatedAt)';
  }


}