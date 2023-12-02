import 'package:bloc/bloc.dart';
import 'package:sign_in_bloc/application/useCases/playlist/get_trending_playlists_use_case.dart';
import 'package:sign_in_bloc/application/useCases/promotional_banner/get_promotional_banner_use_case.dart';
import 'package:sign_in_bloc/application/useCases/song/get_trending_songs_use_case.dart';
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
import '../../useCases/album/get_trending_albums_use_case.dart';
import '../../useCases/artist/get_trending_artists_use_case.dart';
part 'trendings_event.dart';
part 'trendings_state.dart';

class TrendingsBloc extends Bloc<TrendingsEvent, TrendingsState> {
  final GetTrendingArtistsUseCase getTrendingArtistUseCase =
      GetTrendingArtistsUseCase(
          artistRepository:
              ArtistRepositoryImpl()); //esto lo haremos con get it

  final GetTrendingAlbumsUseCase getTrendingAlbumUseCase =
      GetTrendingAlbumsUseCase(
          albumRepository: AlbumRepositoryImpl()); //esto lo haremos con get it

  final GetPromotionalBannerUseCase getPromotionalBannerUseCase =
      GetPromotionalBannerUseCase(
          promotionalBannerRepository:
              PromotionalBannerImpl()); //esto lo haremos con get it

  final GetTrendingPlaylistsUseCase getPlaylistUseCase =
      GetTrendingPlaylistsUseCase(
          playlistRepository:
              PlaylistRepositoryImpl()); //esto lo haremos con get it

  final GetTrendingSongsUseCase getSongUseCase = GetTrendingSongsUseCase(
      songRepository: SongRepositoryImpl()); //esto lo haremos con get it

  TrendingsBloc() : super(TrendingsLoading()) {
    on<FetchTrendingsEvent>(_fetchTrendingsEventHandler);
  }

  void _fetchTrendingsEventHandler(
      FetchTrendingsEvent event, Emitter<TrendingsState> emit) async {
    final trendingArtistsResult = await getTrendingArtistUseCase.execute();
    final promotionalBannerResult = await getPromotionalBannerUseCase.execute();
    final trendingAlbumsResult = await getTrendingAlbumUseCase.execute();
    final trendingPlaylistsResult = await getPlaylistUseCase.execute();
    final trendingSongsResult = await getSongUseCase.execute();

    if ([
      trendingArtistsResult,
      promotionalBannerResult,
      trendingAlbumsResult,
      trendingPlaylistsResult,
      trendingSongsResult
    ].every((result) => result.hasValue())) {
      emit(TrendingsLoaded(
        trendingArtists: trendingArtistsResult.value!,
        trendingAlbums: trendingAlbumsResult.value!,
        promotionalBanner: promotionalBannerResult.value!,
        trendingPlaylists: trendingPlaylistsResult.value!,
        trendingSongs: trendingSongsResult.value!,
      ));
    } else {
      emit(TrendingsFailed());
    }
  }
}
