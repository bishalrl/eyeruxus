import 'package:equatable/equatable.dart';

class VipTier extends Equatable {
  final String code;
  final String name;
  final String priceLabel;
  final String privileges;
  final int sortOrder;

  const VipTier({
    required this.code,
    required this.name,
    required this.priceLabel,
    required this.privileges,
    required this.sortOrder,
  });

  @override
  List<Object?> get props => [code, name, priceLabel, privileges, sortOrder];
}
