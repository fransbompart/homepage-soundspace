import 'package:sign_in_bloc/infrastructure/services/socket_client/socket_client.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class SocketClientImpl extends SocketClient {
  late IO.Socket socket;

  @override
  void inicializeSocket() {
    socket = IO.io(
        'http://192.168.1.106:5000',
        IO.OptionBuilder()
            .setTransports(['websocket']) // for Flutter or Dart VM
            .setExtraHeaders({'foo': 'bar'}) // optional
            .build());
    socket.connect();
    socket.onConnect((_) {
      print('connect');
      socket.emit('msg', 'test');
    });
  }

  @override
  IO.Socket getSocket() {
    return socket;
  }
}
