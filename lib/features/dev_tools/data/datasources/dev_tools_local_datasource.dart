import '../../presentation/config/dev_launcher_config.dart';

abstract class DevToolsLocalDataSource {
  Future<List<Map<String, dynamic>>> getRoutes();
}

class DevToolsLocalDataSourceImpl implements DevToolsLocalDataSource {
  @override
  Future<List<Map<String, dynamic>>> getRoutes() async {
    return DevLauncherConfig.entries
        .asMap()
        .entries
        .map(
          (entry) => {
            'label_key': entry.value.labelKey,
            'index': entry.key,
          },
        )
        .toList();
  }
}
