import '../../domain/entities/store_product.dart';

class StoreProductModel extends StoreProduct {
  const StoreProductModel({
    required super.id,
    required super.name,
    required super.category,
    required super.price,
    required super.imageUrl,
  });

  factory StoreProductModel.fromJson(Map<String, dynamic> json) {
    return StoreProductModel(
      id: json['id'] as String,
      name: json['name'] as String,
      category: json['category'] as String,
      price: json['price'] as int,
      imageUrl: json['image_url'] as String,
    );
  }
}
