import 'package:equatable/equatable.dart';

class StoreProduct extends Equatable {
  final String id;
  final String name;
  final String category;
  final int price;
  final String imageUrl;

  const StoreProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.imageUrl,
  });

  @override
  List<Object?> get props => [id, name, category, price, imageUrl];
}
