class GiftModel {
  final int? id;
  final String? uuid;
  final String? name;
  final String? description;
  final String? imageUrl;
  final String? animationUrl;
  final int? coinValue;
  final double? realValue;
  final String? category;
  final String? rarity;
  final bool? isActive;
  final bool? isSpecial;
  final int? stockQuantity;
  final int? usageCount;
  final String? createdAt;
  final String? updatedAt;

  // Additional fields for gift transactions
  final int? senderId;
  final int? receiverId;
  final String? senderUsername;
  final String? receiverUsername;
  final String? sentAt;

  GiftModel({
    this.id,
    this.uuid,
    this.name,
    this.description,
    this.imageUrl,
    this.animationUrl,
    this.coinValue,
    this.realValue,
    this.category,
    this.rarity,
    this.isActive,
    this.isSpecial,
    this.stockQuantity,
    this.usageCount,
    this.createdAt,
    this.updatedAt,
    this.senderId,
    this.receiverId,
    this.senderUsername,
    this.receiverUsername,
    this.sentAt,
  });

  // Empty constructor
  factory GiftModel.empty() {
    return GiftModel(
      id: null,
      uuid: null,
      name: null,
      description: null,
      imageUrl: null,
      animationUrl: null,
      coinValue: null,
      realValue: null,
      category: null,
      rarity: null,
      isActive: null,
      isSpecial: null,
      stockQuantity: null,
      usageCount: null,
      createdAt: null,
      updatedAt: null,
      senderId: null,
      receiverId: null,
      senderUsername: null,
      receiverUsername: null,
      sentAt: null,
    );
  }

  // From Map
  factory GiftModel.fromMap(Map<String, dynamic> map) {
    return GiftModel(
      id: map['id'] as int?,
      uuid: map['uuid'] as String?,
      name: map['name'] as String?,
      description: map['description'] as String?,
      imageUrl: map['image_url'] as String?,
      animationUrl: map['animation_url'] as String?,
      coinValue: map['coin_value'] as int?,
      realValue: map['real_value'] != null
          ? (map['real_value'] as num).toDouble()
          : null,
      category: map['category'] as String?,
      rarity: map['rarity'] as String?,
      isActive: map['is_active'] != null
          ? (map['is_active'] == 1 || map['is_active'] == true)
          : null,
      isSpecial: map['is_special'] != null
          ? (map['is_special'] == 1 || map['is_special'] == true)
          : null,
      stockQuantity: map['stock_quantity'] as int?,
      usageCount: map['usage_count'] as int?,
      createdAt: map['created_at'] as String?,
      updatedAt: map['updated_at'] as String?,
      senderId: map['sender_id'] as int?,
      receiverId: map['receiver_id'] as int?,
      senderUsername: map['sender_username'] as String?,
      receiverUsername: map['receiver_username'] as String?,
      sentAt: map['sent_at'] as String?,
    );
  }

  // To Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'uuid': uuid,
      'name': name,
      'description': description,
      'image_url': imageUrl,
      'animation_url': animationUrl,
      'coin_value': coinValue,
      'real_value': realValue,
      'category': category,
      'rarity': rarity,
      'is_active': isActive != null ? (isActive! ? 1 : 0) : null,
      'is_special': isSpecial != null ? (isSpecial! ? 1 : 0) : null,
      'stock_quantity': stockQuantity,
      'usage_count': usageCount,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'sender_id': senderId,
      'receiver_id': receiverId,
      'sender_username': senderUsername,
      'receiver_username': receiverUsername,
      'sent_at': sentAt,
    };
  }

  // CopyWith
  GiftModel copyWith({
    int? id,
    String? uuid,
    String? name,
    String? description,
    String? imageUrl,
    String? animationUrl,
    int? coinValue,
    double? realValue,
    String? category,
    String? rarity,
    bool? isActive,
    bool? isSpecial,
    int? stockQuantity,
    int? usageCount,
    String? createdAt,
    String? updatedAt,
    int? senderId,
    int? receiverId,
    String? senderUsername,
    String? receiverUsername,
    String? sentAt,
  }) {
    return GiftModel(
      id: id ?? this.id,
      uuid: uuid ?? this.uuid,
      name: name ?? this.name,
      description: description ?? this.description,
      imageUrl: imageUrl ?? this.imageUrl,
      animationUrl: animationUrl ?? this.animationUrl,
      coinValue: coinValue ?? this.coinValue,
      realValue: realValue ?? this.realValue,
      category: category ?? this.category,
      rarity: rarity ?? this.rarity,
      isActive: isActive ?? this.isActive,
      isSpecial: isSpecial ?? this.isSpecial,
      stockQuantity: stockQuantity ?? this.stockQuantity,
      usageCount: usageCount ?? this.usageCount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      senderUsername: senderUsername ?? this.senderUsername,
      receiverUsername: receiverUsername ?? this.receiverUsername,
      sentAt: sentAt ?? this.sentAt,
    );
  }

  // ToString
  @override
  String toString() {
    return 'GiftModel(id: $id, uuid: $uuid, name: $name, description: $description, imageUrl: $imageUrl, animationUrl: $animationUrl, coinValue: $coinValue, realValue: $realValue, category: $category, rarity: $rarity, isActive: $isActive, isSpecial: $isSpecial, stockQuantity: $stockQuantity, usageCount: $usageCount, createdAt: $createdAt, updatedAt: $updatedAt, senderId: $senderId, receiverId: $receiverId, senderUsername: $senderUsername, receiverUsername: $receiverUsername, sentAt: $sentAt)';
  }


}