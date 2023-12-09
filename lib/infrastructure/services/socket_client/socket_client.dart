import 'package:socket_io_client/socket_io_client.dart' as IO;

abstract class SocketClient {
  void inicializeSocket();
  IO.Socket getSocket();
}
