import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/infrastructure/services/connectivity_checker.dart';

part 'connectivity_event.dart';
part 'connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final ConnectivityChecker connectivityChecker = ConnectivityChecker();
  ConnectivityBloc() : super(const ConnectivityInitialState()) {
    on<ConnectivityInitialCheckRequested>(checkInitialConnection);
    on<ConnectivityCheckRequested>(checkConnection);
  }

  Future<void> checkConnection(
      ConnectivityCheckRequested event, Emitter<ConnectivityState> emit) async {
    final subscriptionSteam = connectivityChecker.checkConnectionStream();
    await for (final isConnected in subscriptionSteam) {
      isConnected
          ? emit(
              ConnectedState(willNeedReconnection: state.willNeedReconnection))
          : emit(const NotConnectedState());
    }
  }

  Future<void> checkInitialConnection(ConnectivityInitialCheckRequested event,
      Emitter<ConnectivityState> emit) async {
    final bool isConnected = await connectivityChecker.checkInitialConnection();
    isConnected
        ? emit(ConnectedState(willNeedReconnection: state.willNeedReconnection))
        : emit(const NotConnectedState());

    add(ConnectivityCheckRequested());
  }
}
