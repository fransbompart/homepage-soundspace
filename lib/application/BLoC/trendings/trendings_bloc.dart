import 'package:bloc/bloc.dart';

import 'package:sign_in_bloc/application/useCases/artist/get_trending_artist_use_case.dart';
import 'package:sign_in_bloc/application/useCases/promotional_banner/get_promotional_banner_use_case.dart';
import 'package:sign_in_bloc/application/useCases/album/get_trending_album_use_case.dart';
import 'package:sign_in_bloc/application/useCases/playlist/get_playlist_use_case.dart';
import 'package:sign_in_bloc/application/useCases/song/get_song_use_case.dart';

import 'package:equatable/equatable.dart';

import 'package:sign_in_bloc/domain/artist/artist.dart';
import 'package:sign_in_bloc/domain/album/album.dart';
import 'package:sign_in_bloc/domain/promotional_banner/promotional_banner.dart';
import 'package:sign_in_bloc/domain/playlist/playlist.dart';

import '../../../domain/song/song.dart';
import '../../../infrastructure/repositories/artist/artist_repository_impl.dart';
import '../../../infrastructure/repositories/promotional_banner/promotional_banner_repository_impl.dart';
import '../../../infrastructure/repositories/album/album_repository_impl.dart';
import '../../../infrastructure/repositories/playlist/playlist_repository_impl.dart';
import '../../../infrastructure/repositories/song/song_repository_impl.dart';

part 'trendings_event.dart';
part 'trendings_state.dart';

class TrendingsBloc extends Bloc<TrendingsEvent, TrendingsState> {
  final GetTrendingArtistUseCase getTrendingArtistUseCase =
      GetTrendingArtistUseCase(
          artistRepository:
              ArtistRepositoryImpl()); //esto lo haremos con get it

  final GetTrendingAlbumUseCase getTrendingAlbumUseCase =
      GetTrendingAlbumUseCase(
          albumRepository: AlbumRepositoryImpl()); //esto lo haremos con get it

  final GetPromotionalBannerUseCase getPromotionalBannerUseCase =
      GetPromotionalBannerUseCase(
          promotionalBannerRepository:
              PromotionalBannerImpl()); //esto lo haremos con get it

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
    try {
      final trendingArtistResult = await getTrendingArtistUseCase.execute();
      final promotionalBannerResult =
          await getPromotionalBannerUseCase.execute();
      final trendingAlbumResult = await getTrendingAlbumUseCase.execute();
      final playlistResult = await getPlaylistUseCase.execute();
      final songResult = await getSongUseCase.execute();

      if (trendingArtistResult.hasValue() &&
          promotionalBannerResult.hasValue() &&
          trendingAlbumResult.hasValue() &&
          playlistResult.hasValue() &&
          songResult.hasValue()) {
        emit(TrendingsLoaded(
          trendingArtist: trendingArtistResult.value!,
          trendingAlbum: trendingAlbumResult.value!,
          promotionalBanner: promotionalBannerResult.value!,
          playlists: playlistResult.value!,
          songs: songResult.value!,
        ));
      } else {
        emit(TrendingsFailed());
      }
    } catch (e) {
      emit(TrendingsFailed());
    }
  }
}
