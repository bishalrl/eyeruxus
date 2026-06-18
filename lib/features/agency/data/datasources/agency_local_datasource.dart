abstract class AgencyLocalDataSource {
  Future<Map<String, dynamic>?> getLatestApplication();
}

class AgencyLocalDataSourceImpl implements AgencyLocalDataSource {
  @override
  Future<Map<String, dynamic>?> getLatestApplication() async => {
        'id': 'app_local_001',
        'status': 'rejected',
        'agency_name': 'Star Agency',
        'submitted_at': DateTime(2025, 11, 3).toIso8601String(),
      };
}
