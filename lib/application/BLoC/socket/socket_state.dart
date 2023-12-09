// Define the states
abstract class SocketState {}

class InitialState extends SocketState {}

class ConnectedState extends SocketState {}

class DisconnectedState extends SocketState {}

class MessageReceivedState extends SocketState {
  final String message;

  MessageReceivedState(this.message);
}
