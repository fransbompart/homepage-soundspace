part of 'player_bloc.dart';

abstract class PlayerState extends Equatable {
  const PlayerState();

  @override
  List<Object> get props => [];
}

class PlayingState extends PlayerState {}

class NotPlayingState extends PlayerState {}

class PausingState extends PlayerState {}
