part of 'dev_tools_bloc.dart';

abstract class DevToolsEvent extends Equatable {
  const DevToolsEvent();

  @override
  List<Object?> get props => [];
}

class DevRoutesRequested extends DevToolsEvent {
  const DevRoutesRequested();
}
