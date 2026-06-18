import '../../domain/entities/vip_tier.dart';

class VipTierModel extends VipTier {
  const VipTierModel({
    required super.code,
    required super.name,
    required super.priceLabel,
    required super.privileges,
    required super.sortOrder,
  });

  factory VipTierModel.fromJson(Map<String, dynamic> json) {
    return VipTierModel(
      code: json['code'] as String,
      name: json['name'] as String,
      priceLabel: json['price_label'] as String,
      privileges: json['privileges'] as String,
      sortOrder: json['sort_order'] as int,
    );
  }
}
