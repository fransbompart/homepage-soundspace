part of 'player_bloc.dart';

abstract class PlayerEvent {}

class PlayingStartedEvent extends PlayerEvent {
  final Song song;

  PlayingStartedEvent({required this.song});
}

class PlayedOrPausedEvent extends PlayerEvent {}

class PlayingStoppedEvent extends PlayerEvent {}
