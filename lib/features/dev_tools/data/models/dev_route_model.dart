import '../../domain/entities/dev_route.dart';

class DevRouteModel extends DevRoute {
  const DevRouteModel({required super.labelKey, required super.index});

  factory DevRouteModel.fromConfig({required String labelKey, required int index}) {
    return DevRouteModel(labelKey: labelKey, index: index);
  }
}
