import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/socket/socket_event.dart';
import 'package:sign_in_bloc/application/BLoC/socket/socket_state.dart';
import 'package:sign_in_bloc/infrastructure/services/socket_client/socket_client.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketClient socketClient;
  SocketBloc({required this.socketClient}) : super(InitialState()) {}
}
