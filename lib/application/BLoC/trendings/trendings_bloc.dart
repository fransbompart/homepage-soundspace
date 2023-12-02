import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/useCases/playlist/get_playlist_use_case.dart';
import 'package:sign_in_bloc/application/useCases/song/get_song_use_case.dart';
import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:equatable/equatable.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';
import 'package:sign_in_bloc/infrastructure/repositories/artist/artist_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/repositories/song/song_repository_impl.dart';

import '../../../infrastructure/repositories/playlist/playlist_repository_impl.dart';
import '../../useCases/artist/get_trending_artist_use_case.dart';
part 'trendings_event.dart';
part 'trendings_state.dart';

class TrendingsBloc extends Bloc<TrendingsEvent, TrendingsState> {
  final GetTrendingArtistUseCase getTrendingArtistUseCase =
      GetTrendingArtistUseCase(
          artistRepository:
              ArtistRepositoryImpl()); //esto lo haremos con get it

  final GetPlaylistUseCase getPlaylistUseCase = GetPlaylistUseCase(
      playlistRepository:
          PlaylistRepositoryImpl()); //esto lo haremos con get it

  final GetSongUseCase getSongUseCase = GetSongUseCase(
      songRepository: SongRepositoryImpl()); //esto lo haremos con get it

  TrendingsBloc() : super(TrendingsLoading()) {
    on<FetchTrendingsEvent>(_fetchTrendingsEventHandler);
  }

  void _fetchTrendingsEventHandler(
      FetchTrendingsEvent event, Emitter<TrendingsState> emit) async {
    //activar todos los casos de uso relacionados a trending
    final trendingArtistResult = await getTrendingArtistUseCase.execute();
    final playlistResult = await getPlaylistUseCase.execute();
    final songResult = await getSongUseCase.execute();

    if (trendingArtistResult.hasValue()) {
      emit(TrendingsLoaded(trendingArtist: trendingArtistResult.value!));
    } else {
      emit(TrendingsFailed());
    }

    if (playlistResult.hasValue()) {
      //emit(TrendingsLoaded( playlistResult: playlistResult.value!));
    } else {
      emit(TrendingsFailed());
    }

    if (songResult.hasValue()) {
      //emit(TrendingsLoaded( songResult: songResult.value!));
    } else {
      emit(TrendingsFailed());
    }
  }
}
