part of 'dev_tools_bloc.dart';

abstract class DevToolsState extends Equatable {
  const DevToolsState();

  @override
  List<Object?> get props => [];
}

class DevToolsInitial extends DevToolsState {
  const DevToolsInitial();
}

class DevToolsLoading extends DevToolsState {
  const DevToolsLoading();
}

class DevToolsLoaded extends DevToolsState {
  final List<DevRoute> routes;

  const DevToolsLoaded(this.routes);

  @override
  List<Object?> get props => [routes];
}

class DevToolsFailure extends DevToolsState {
  final String message;

  const DevToolsFailure(this.message);

  @override
  List<Object?> get props => [message];
}
