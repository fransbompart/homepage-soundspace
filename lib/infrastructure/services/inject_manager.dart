import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_bloc/application/BLoC/player/player_bloc.dart';
import 'package:sign_in_bloc/application/useCases/album/get_trending_albums_use_case.dart';
import 'package:sign_in_bloc/application/useCases/artist/get_trending_artists_use_case.dart';
import 'package:sign_in_bloc/application/useCases/playlist/get_trending_playlists_use_case.dart';
import 'package:sign_in_bloc/application/useCases/song/get_trending_songs_use_case.dart';
import 'package:sign_in_bloc/application/useCases/user/is_authenticated.dart';
import 'package:sign_in_bloc/infrastructure/repositories/album/album_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/repositories/artist/artist_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/repositories/promotional_banner/promotional_banner_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/repositories/song/song_repository_impl.dart';
import 'package:sign_in_bloc/infrastructure/services/local_storage_impl.dart';
import 'package:sign_in_bloc/infrastructure/services/network_manager.dart';
import '../../application/BLoC/auth/auth_bloc.dart';
import '../../application/BLoC/trendings/trendings_bloc.dart';
import '../../application/useCases/promotional_banner/get_promotional_banner_use_case.dart';
import '../presentation/config/router/app_router.dart';
import '../repositories/playlist/playlist_repository_impl.dart';

class InjectManager {
  static Future<void> initialized() async {
    //services
    WidgetsFlutterBinding.ensureInitialized();
    final networkManager =
        NetworkManager(); //TODO:a esto hay que hacerle la interfaz
    //repositories
    final promotionalBannerRepository =
        PromotionalBannerRepositoryImpl(networkManager: networkManager);
    final playlistRepository =
        PlaylistRepositoryImpl(networkManager: networkManager);
    final albumRepository = AlbumRepositoryImpl(networkManager: networkManager);
    final artistRepository =
        ArtistRepositoryImpl(networkManager: networkManager);
    final songRepository = SongRepositoryImpl(networkManager: networkManager);
    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorage = LocalStorageImpl(prefs: sharedPreferences);
    //usecases
    final GetPromotionalBannerUseCase getPromotionalBannerUseCase =
        GetPromotionalBannerUseCase(
            promotionalBannerRepository: promotionalBannerRepository);
    final GetTrendingPlaylistsUseCase getTrendingPlaylistsUseCase =
        GetTrendingPlaylistsUseCase(playlistRepository: playlistRepository);
    final GetTrendingAlbumsUseCase getTrendingAlbumsUseCase =
        GetTrendingAlbumsUseCase(albumRepository: albumRepository);
    final GetTrendingArtistsUseCase getTrendingArtistsUseCase =
        GetTrendingArtistsUseCase(artistRepository: artistRepository);
    final GetTrendingSongsUseCase getTrendingSongsUseCase =
        GetTrendingSongsUseCase(songRepository: songRepository);
    final IsAuthenticatedUseCase isAuthenticatedUseCase =
        IsAuthenticatedUseCase(localStorage: localStorage);
    //blocs
    final getIt = GetIt.instance;
    getIt.registerSingleton<TrendingsBloc>(TrendingsBloc(
        getTrendingArtistsUseCase: getTrendingArtistsUseCase,
        getTrendingAlbumsUseCase: getTrendingAlbumsUseCase,
        getPromotionalBannerUseCase: getPromotionalBannerUseCase,
        getTrendingPlaylistsUseCase: getTrendingPlaylistsUseCase,
        getTrendingSongsUseCase: getTrendingSongsUseCase));
    getIt.registerSingleton<AuthBloc>(
        AuthBloc(isAuthenticatedUseCase: isAuthenticatedUseCase));
    getIt.registerSingleton<PlayerBloc>(PlayerBloc());
    final authBloc = getIt.get<AuthBloc>();
    //para chekear el estado de la autenticacion
    authBloc.add(UserAuthenticatedEvent());
    final authGuard = AuthRouteGuard(authBloc: authBloc);
    final subscriptionGuard = SubscriptionRouteGuard(authBloc: authBloc);
    getIt.registerSingleton<AppNavigator>(AppNavigator(
        authRouteGuard: authGuard, subscriptionRouteGuard: subscriptionGuard));
  }
}
