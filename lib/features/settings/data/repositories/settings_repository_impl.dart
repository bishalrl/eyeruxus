import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/app_settings.dart';
import '../../domain/repositories/settings_repository.dart';
import '../datasources/settings_local_datasource.dart';
import '../models/app_settings_model.dart';

class SettingsRepositoryImpl implements SettingsRepository {
  final SettingsLocalDataSource localDataSource;

  SettingsRepositoryImpl(this.localDataSource);

  @override
  Future<Either<Failure, AppSettings>> getSettings() async {
    try {
      return Right(await localDataSource.getSettings());
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AppSettings>> updateSettings(
    AppSettings settings,
  ) async {
    try {
      final model = AppSettingsModel(
        languageCode: settings.languageCode,
        pushNotificationsEnabled: settings.pushNotificationsEnabled,
        privacyModeEnabled: settings.privacyModeEnabled,
        securityLevel: settings.securityLevel,
      );
      return Right(await localDataSource.saveSettings(model));
    } catch (e) {
      return Left(CacheFailure(e.toString()));
    }
  }
}
