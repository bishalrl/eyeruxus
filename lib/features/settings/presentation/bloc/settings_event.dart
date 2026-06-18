part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object?> get props => [];
}

class SettingsLoadRequested extends SettingsEvent {
  const SettingsLoadRequested();
}

class SettingsUpdateRequested extends SettingsEvent {
  final AppSettings settings;

  const SettingsUpdateRequested(this.settings);

  @override
  List<Object?> get props => [settings];
}
