import 'package:equatable/equatable.dart';

class HostApplication extends Equatable {
  final String id;
  final String status;
  final String agencyName;
  final DateTime submittedAt;

  const HostApplication({
    required this.id,
    required this.status,
    required this.agencyName,
    required this.submittedAt,
  });

  @override
  List<Object?> get props => [id, status, agencyName, submittedAt];
}
