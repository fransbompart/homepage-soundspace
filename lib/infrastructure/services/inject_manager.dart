import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sign_in_bloc/application/BLoC/notifications/notifications_bloc.dart';
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
import 'package:sign_in_bloc/infrastructure/services/api_connection_manager_impl.dart';
import 'package:sign_in_bloc/infrastructure/services/connection_manager_impl.dart';
import 'package:sign_in_bloc/infrastructure/services/firebase/firebase_options.dart';
import 'package:sign_in_bloc/infrastructure/services/local_storage_impl.dart';
import '../../application/BLoC/auth/auth_bloc.dart';
import '../../application/BLoC/connectivity/connectivity_bloc.dart';
import '../../application/BLoC/logInSubs/log_in_subscriber_bloc.dart';
import '../../application/BLoC/trendings/trendings_bloc.dart';
import '../../application/useCases/promotional_banner/get_promotional_banner_use_case.dart';
import '../../application/useCases/user/log_in_use_case.dart';
import '../presentation/config/router/app_router.dart';
import '../repositories/playlist/playlist_repository_impl.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../repositories/user/user_repository_impl.dart';
import 'local_notifications/local_notifications_impl.dart';

class InjectManager {
  static Future<void> firebaseMessagingBackgroundHandler(
      RemoteMessage message) async {
    // If you're going to use other Firebase services in the background, such as Firestore,
    // make sure you call `initializeApp` before using other Firebase services.
    await Firebase.initializeApp();

    print("Handling a background message: ${message.messageId}");
  }

  static Future<void> initialized() async {
    WidgetsFlutterBinding.ensureInitialized();
    //firebase
    FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    //env
    await dotenv.load(fileName: ".env");
    //services
    final apiConnectionManagerImpl = ApiConnectionManagerImpl(
        baseUrl:
            dotenv.env['API_URL']!); //TODO:a esto hay que hacerle la interfaz

    final localNotifications = LocalNotificationsImpl()
      ..inicializeLocalNotifications();
    //repositories
    final userRepository =
        UserRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final promotionalBannerRepository = PromotionalBannerRepositoryImpl(
        apiconnectionManager: apiConnectionManagerImpl);
    final playlistRepository =
        PlaylistRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final albumRepository =
        AlbumRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final artistRepository =
        ArtistRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final songRepository =
        SongRepositoryImpl(apiConnectionManager: apiConnectionManagerImpl);
    final sharedPreferences = await SharedPreferences.getInstance();
    final localStorage = LocalStorageImpl(prefs: sharedPreferences);
    //usecases
    final LogInUseCase logInUseCase = LogInUseCase(
        userRepository: userRepository, localStorage: localStorage);
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
    getIt.registerSingleton<LogInSubscriberBloc>(
        LogInSubscriberBloc(logInUseCase: logInUseCase));
    final authBloc = getIt.get<AuthBloc>();
    getIt.registerSingleton<ConnectivityBloc>(
        ConnectivityBloc(connectionManager: ConnectionManagerImpl()));
    getIt.registerSingleton<NotificationsBloc>(
        NotificationsBloc(localNotifications: localNotifications));
    //para chekear el estado de la autenticacion
    authBloc.add(UserAuthenticatedEvent());
    final authGuard = AuthRouteGuard(authBloc: authBloc);
    final subscriptionGuard = SubscriptionRouteGuard(authBloc: authBloc);
    getIt.registerSingleton<AppNavigator>(AppNavigator(
        authRouteGuard: authGuard, subscriptionRouteGuard: subscriptionGuard));
  }
}
