// Define the events
abstract class SocketEvent {}

class ConnectEvent extends SocketEvent {}

class DisconnectEvent extends SocketEvent {}

class MessageReceivedState extends SocketEvent {
  final String message;

  MessageReceivedState(this.message);
}
