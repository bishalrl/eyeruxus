import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/app_settings.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingsUseCase implements UseCase<AppSettings, UpdateSettingsParams> {
  final SettingsRepository repository;

  UpdateSettingsUseCase(this.repository);

  @override
  Future<Either<Failure, AppSettings>> call(UpdateSettingsParams params) {
    return repository.updateSettings(params.settings);
  }
}

class UpdateSettingsParams extends Equatable {
  final AppSettings settings;

  const UpdateSettingsParams(this.settings);

  @override
  List<Object?> get props => [settings];
}
