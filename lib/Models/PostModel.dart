class PostModel {
  final int? id;
  final String? uuid;
  final int? userId;
  final String? title;
  final String? content;
  final String? topics;
  final bool? isFollowed;
  final int? likesCount;
  final int? commentsCount;
  final int? sharesCount;
  final int? viewsCount;
  final int? savesCount;
  final String? status;
  final String? createdAt;
  final String? updatedAt;
  final String? deletedAt;

  // Additional user info (if included in response)
  final String? authorUsername;
  final String? authorAvatarUrl;

  PostModel({
    this.id,
    this.uuid,
    this.userId,
    this.title,
    this.content,
    this.topics,
    this.isFollowed,
    this.likesCount,
    this.commentsCount,
    this.sharesCount,
    this.viewsCount,
    this.savesCount,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.authorUsername,
    this.authorAvatarUrl,
  });

  // Empty constructor
  factory PostModel.empty() {
    return PostModel(
      id: null,
      uuid: null,
      userId: null,
      title: null,
      content: null,
      topics: null,
      isFollowed: null,
      likesCount: null,
      commentsCount: null,
      sharesCount: null,
      viewsCount: null,
      savesCount: null,
      status: null,
      createdAt: null,
      updatedAt: null,
      deletedAt: null,
      authorUsername: null,
      authorAvatarUrl: null,
    );
  }

  // From Map
  factory PostModel.fromMap(Map<String, dynamic> map) {
    return PostModel(
      id: map['id'] as int?,
      uuid: map['uuid'] as String?,
      userId: map['user_id'] as int?,
      title: map['title'] as String?,
      content: map['content'] as String?,
      topics: map['topics'] as String?,
      isFollowed: map['is_followed'] != null
          ? (map['is_followed'] == 1 || map['is_followed'] == true)
          : null,
      likesCount: map['likes_count'] as int?,
      commentsCount: map['comments_count'] as int?,
      sharesCount: map['shares_count'] as int?,
      viewsCount: map['views_count'] as int?,
      savesCount: map['saves_count'] as int?,
      status: map['status'] as String?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      deletedAt: map['deleted_at'] as String?,
      authorUsername: map['author_username'] as String?,
      authorAvatarUrl: map['author_avatar_url'] as String?,
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'user_id': userId,
      'title': title,
      'content': content,
      'topics': topics,
      'is_followed': isFollowed != null ? (isFollowed! ? 1 : 0) : null,
      'likes_count': likesCount,
      'comments_count': commentsCount,
      'shares_count': sharesCount,
      'views_count': viewsCount,
      'saves_count': savesCount,
      'status': status,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'deleted_at': deletedAt,
      'author_username': authorUsername,
      'author_avatar_url': authorAvatarUrl,
    };
  }

  // CopyWith
  PostModel copyWith({
    int? id,
    String? uuid,
    int? userId,
    String? title,
    String? content,
    String? topics,
    bool? isFollowed,
    int? likesCount,
    int? commentsCount,
    int? sharesCount,
    int? viewsCount,
    int? savesCount,
    String? status,
    String? createdAt,
    String? updatedAt,
    String? deletedAt,
    String? authorUsername,
    String? authorAvatarUrl,
  }) {
    return PostModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      content: content ?? this.content,
      topics: topics ?? this.topics,
      isFollowed: isFollowed ?? this.isFollowed,
      likesCount: likesCount ?? this.likesCount,
      commentsCount: commentsCount ?? this.commentsCount,
      sharesCount: sharesCount ?? this.sharesCount,
      viewsCount: viewsCount ?? this.viewsCount,
      savesCount: savesCount ?? this.savesCount,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      authorUsername: authorUsername ?? this.authorUsername,
      authorAvatarUrl: authorAvatarUrl ?? this.authorAvatarUrl,
    );
  }

  // ToString
  @override
  String toString() {
    return 'PostModel(id: $id, uuid: $uuid, userId: $userId, title: $title, content: $content, topics: $topics, isFollowed: $isFollowed, likesCount: $likesCount, commentsCount: $commentsCount, sharesCount: $sharesCount, viewsCount: $viewsCount, savesCount: $savesCount, status: $status, createdAt: $createdAt, updatedAt: $updatedAt, deletedAt: $deletedAt, authorUsername: $authorUsername, authorAvatarUrl: $authorAvatarUrl)';
  }

}