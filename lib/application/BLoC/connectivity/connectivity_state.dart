part of 'connectivity_bloc.dart';

abstract class ConnectivityState extends Equatable {
  final bool willNeedReconnection;
  const ConnectivityState({required this.willNeedReconnection});

  @override
  List<Object> get props => [willNeedReconnection];
}

class ConnectivityInitialState extends ConnectivityState {
  const ConnectivityInitialState() : super(willNeedReconnection: false);
}

class NotConnectedState extends ConnectivityState {
  const NotConnectedState() : super(willNeedReconnection: true);
}

class ConnectedState extends ConnectivityState {
  const ConnectedState({required super.willNeedReconnection});
}
