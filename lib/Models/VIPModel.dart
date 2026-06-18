// models/vip_plan_model.dart

class VipPlan {
  final String? planCode;
  final String? name;
  final double? price;
  final String? duration;
  final List<String>? perks;
  final bool? isActive;

  VipPlan({
    this.planCode,
    this.name,
    this.price,
    this.duration,
    this.perks,
    this.isActive,
  });

  // CopyWith method
  VipPlan copyWith({
    String? planCode,
    String? name,
    double? price,
    String? duration,
    List<String>? perks,
    bool? isActive,
  }) {
    return VipPlan(
      planCode: planCode ?? this.planCode,
      name: name ?? this.name,
      price: price ?? this.price,
      duration: duration ?? this.duration,
      perks: perks ?? this.perks,
      isActive: isActive ?? this.isActive,
    );
  }

  // FromMap method
  factory VipPlan.fromMap(Map<String, dynamic> map) {
    return VipPlan(
      planCode: map['plan_code'] as String?,
      name: map['name'] as String?,
      price: map['price'] != null
          ? (map['price'] is int ? (map['price'] as int).toDouble() : map['price'] as double?)
          : null,
      duration: map['duration'] as String?,
      perks: map['perks'] != null
          ? List<String>.from(map['perks'] as List)
          : null,
      isActive: map['is_active'] as bool?,
    );
  }

  // ToMap method
  Map<String, dynamic> toMap() {
    return {
      'plan_code': planCode,
      'name': name,
      'price': price,
      'duration': duration,
      'perks': perks,
      'is_active': isActive,
    };
  }

  // ToString method
  @override
  String toString() {
    return 'VipPlan(planCode: $planCode, name: $name, price: $price, duration: $duration, perks: $perks, isActive: $isActive)';
  }

  // ToEmpty method
  factory VipPlan.toEmpty() {
    return VipPlan(
      planCode: null,
      name: null,
      price: null,
      duration: null,
      perks: null,
      isActive: null,
    );
  }

  // FromJson method (alternative to fromMap)
  factory VipPlan.fromJson(Map<String, dynamic> json) => VipPlan.fromMap(json);

  // ToJson method (alternative to toMap)
  Map<String, dynamic> toJson() => toMap();
}

// VIP Status Model
class VipStatus {
  final String? membershipType;
  final String? expiryDate;
  final List<String>? enabledPerks;
  final bool? isActive;

  VipStatus({
    this.membershipType,
    this.expiryDate,
    this.enabledPerks,
    this.isActive,
  });

  VipStatus copyWith({
    String? membershipType,
    String? expiryDate,
    List<String>? enabledPerks,
    bool? isActive,
  }) {
    return VipStatus(
      membershipType: membershipType ?? this.membershipType,
      expiryDate: expiryDate ?? this.expiryDate,
      enabledPerks: enabledPerks ?? this.enabledPerks,
      isActive: isActive ?? this.isActive,
    );
  }

  factory VipStatus.fromMap(Map<String, dynamic> map) {
    return VipStatus(
      membershipType: map['membership_type'] as String?,
      expiryDate: map['expiry_date'] as String?,
      enabledPerks: map['enabled_perks'] != null
          ? List<String>.from(map['enabled_perks'] as List)
          : null,
      isActive: map['is_active'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'membership_type': membershipType,
      'expiry_date': expiryDate,
      'enabled_perks': enabledPerks,
      'is_active': isActive,
    };
  }

  @override
  String toString() {
    return 'VipStatus(membershipType: $membershipType, expiryDate: $expiryDate, enabledPerks: $enabledPerks, isActive: $isActive)';
  }

  factory VipStatus.toEmpty() {
    return VipStatus(
      membershipType: null,
      expiryDate: null,
      enabledPerks: null,
      isActive: null,
    );
  }
}

// VIP Settings Model
class VipSettings {
  final bool? invisibleMode;
  final bool? dynamicIdentity;
  final bool? kickProtection;
  final bool? hideIdentity;

  VipSettings({
    this.invisibleMode,
    this.dynamicIdentity,
    this.kickProtection,
    this.hideIdentity,
  });

  VipSettings copyWith({
    bool? invisibleMode,
    bool? dynamicIdentity,
    bool? kickProtection,
    bool? hideIdentity,
  }) {
    return VipSettings(
      invisibleMode: invisibleMode ?? this.invisibleMode,
      dynamicIdentity: dynamicIdentity ?? this.dynamicIdentity,
      kickProtection: kickProtection ?? this.kickProtection,
      hideIdentity: hideIdentity ?? this.hideIdentity,
    );
  }

  factory VipSettings.fromMap(Map<String, dynamic> map) {
    return VipSettings(
      invisibleMode: map['invisible_mode'] as bool?,
      dynamicIdentity: map['dynamic_identity'] as bool?,
      kickProtection: map['kick_protection'] as bool?,
      hideIdentity: map['hide_identity'] as bool?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'invisible_mode': invisibleMode,
      'dynamic_identity': dynamicIdentity,
      'kick_protection': kickProtection,
      'hide_identity': hideIdentity,
    };
  }

  @override
  String toString() {
    return 'VipSettings(invisibleMode: $invisibleMode, dynamicIdentity: $dynamicIdentity, kickProtection: $kickProtection, hideIdentity: $hideIdentity)';
  }

  factory VipSettings.toEmpty() {
    return VipSettings(
      invisibleMode: null,
      dynamicIdentity: null,
      kickProtection: null,
      hideIdentity: null,
    );
  }
}