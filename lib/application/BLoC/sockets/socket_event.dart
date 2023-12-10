part of 'socket_bloc.dart';

abstract class SocketEvent {
  const SocketEvent();
}

class SocketConnected extends SocketEvent {}

class SocketDisconnected extends SocketEvent {}

class SocketReceive extends SocketEvent {
  final SocketChunck buffer;
  const SocketReceive(this.buffer);
}

class SocketSend extends SocketEvent {
  final String idSong;
  const SocketSend(this.idSong);
}
