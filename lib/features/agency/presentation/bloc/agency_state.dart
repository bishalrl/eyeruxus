part of 'agency_bloc.dart';

abstract class AgencyState extends Equatable {
  const AgencyState();

  @override
  List<Object?> get props => [];
}

class AgencyInitial extends AgencyState {
  const AgencyInitial();
}

class AgencyLoading extends AgencyState {
  const AgencyLoading();
}

class AgencyLoaded extends AgencyState {
  final HostApplication? application;

  const AgencyLoaded(this.application);

  @override
  List<Object?> get props => [application];
}

class AgencyFailure extends AgencyState {
  final String message;

  const AgencyFailure(this.message);

  @override
  List<Object?> get props => [message];
}
