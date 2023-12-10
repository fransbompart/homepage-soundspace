import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/application/model/Chunck.dart';

import '../../../infrastructure/services/socket_client/socket_client.dart';

part 'socket_event.dart';
part 'socket_state.dart';

class SocketBloc extends Bloc<SocketEvent, SocketState> {
  SocketClient socketClient;
  List<SocketChunck> buffer = [];

  SocketBloc({required this.socketClient}) : super(const SocketState()) {
    on<SocketSend>(_sendIdSong);
    on<SocketReceive>(_receiveChunck);
    _receiveBackgroundChunck();
  }

  void _sendIdSong(SocketSend event, Emitter<SocketState> emit) {
    socketClient.sendMessage(event.idSong);
  }

  void _receiveChunck(SocketReceive event, Emitter<SocketState> emit) {
    emit(state.copyWith(buffer: [event.buffer, ...state.buffer]));
  }

  void _receiveBackgroundChunck() {
    SocketChunck chunck = SocketChunck(secuence: '', data: 'data');
    socketClient.getSocket().on(
        'chunck',
        (data) => {
              chunck.secuence = data['secuence'],
              chunck.data = data['payload'],
              add(SocketReceive(chunck)),
            });
  }
}
