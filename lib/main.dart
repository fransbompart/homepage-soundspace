import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/connectivity/connectivity_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/gps/gps_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/notifications/notifications_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/theme/app_theme.dart';
import 'package:sign_in_bloc/infrastructure/services/inject_manager.dart';
import 'application/BLoC/auth/auth_bloc.dart';
import 'application/BLoC/logInSubs/log_in_subscriber_bloc.dart';
import 'application/BLoC/player/player_bloc.dart';
import 'infrastructure/presentation/config/router/app_router.dart';

Future<void> main() async {
  //TODO: en vez de tener el main como Future hace un splash screen con future builder
  await InjectManager.initialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application
  @override
  Widget build(BuildContext context) {
    final getIt = GetIt.instance;
    final appNavigator = getIt.get<AppNavigator>();
    //TODO: poner esto en un widget privado
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt.get<PlayerBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<AuthBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<TrendingsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<ConnectivityBloc>(),
        ),
        BlocProvider(
          create: (context) {
            return getIt.get<LogInSubscriberBloc>();
          },
        ),
        BlocProvider(
          create: (context) => getIt.get<NotificationsBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt.get<GpsBloc>(),
        )
      ],
      child: MaterialApp.router(
        title: 'SoundSpace', //TODO: mejorar con las .env
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        routerDelegate: appNavigator.routerDelegate,
        routeInformationParser: appNavigator.routeInformationParser,
        routeInformationProvider: appNavigator.routeInformationProvider,
      ),
    );
  }
}
