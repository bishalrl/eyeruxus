import '../../domain/entities/host_application.dart';

class HostApplicationModel extends HostApplication {
  const HostApplicationModel({
    required super.id,
    required super.status,
    required super.agencyName,
    required super.submittedAt,
  });

  factory HostApplicationModel.fromJson(Map<String, dynamic> json) {
    return HostApplicationModel(
      id: json['id'] as String,
      status: json['status'] as String,
      agencyName: json['agency_name'] as String,
      submittedAt: DateTime.parse(json['submitted_at'] as String),
    );
  }
}
