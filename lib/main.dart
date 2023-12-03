import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/theme/app_theme.dart';
import 'package:sign_in_bloc/infrastructure/services/inject_manager.dart';
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

    return MaterialApp.router(
      title: 'SoundSpace', //TODO: mejorar con las .env
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      routerDelegate: appNavigator.routerDelegate,
      routeInformationParser: appNavigator.routeInformationParser,
      routeInformationProvider: appNavigator.routeInformationProvider,
    );
  }
}
