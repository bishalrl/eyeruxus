import 'package:equatable/equatable.dart';

class DevRoute extends Equatable {
  final String labelKey;
  final int index;

  const DevRoute({required this.labelKey, required this.index});

  @override
  List<Object?> get props => [labelKey, index];
}
