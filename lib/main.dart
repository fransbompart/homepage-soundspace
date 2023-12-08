import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/application/BLoC/trendings/trendings_bloc.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/theme/app_theme.dart';
import 'package:sign_in_bloc/infrastructure/services/inject_manager.dart';
import 'application/BLoC/auth/auth_bloc.dart';
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
