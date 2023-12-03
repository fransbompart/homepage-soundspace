import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/song/song.dart';

part 'player_event.dart';
part 'player_state.dart';

class PlayerBloc extends Bloc<PlayerEvent, PlayerState> {
  PlayerBloc() : super(NotPlayingState()) {
    on<PlayingStartedEvent>(_playingStartedEventHandler);
    on<PlayedOrPausedEvent>(_playedOrPausedEventHandler);
    on<PlayingStoppedEvent>(_playingStoppedEventHandler);
  }

  void _playingStartedEventHandler(
      PlayingStartedEvent event, Emitter<PlayerState> emit) {
    emit(PlayingState());
  }

  void _playedOrPausedEventHandler(
      PlayedOrPausedEvent event, Emitter<PlayerState> emit) {
    if (state is PlayingState) {
      emit(PausingState());
    } else if (state is PausingState) {
      emit(PlayingState());
    }
  }

  void _playingStoppedEventHandler(
      PlayingStoppedEvent event, Emitter<PlayerState> emit) {
    emit(NotPlayingState());
  }
}
