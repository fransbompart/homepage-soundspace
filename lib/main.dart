import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/notifications/notifications_bloc.dart';
import 'package:sign_in_bloc/application/BLoC/sockets/socket_bloc.dart';
import 'package:sign_in_bloc/infrastructure/services/local_notifications/local_notifications_impl.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/app_theme.dart';
import 'package:sign_in_bloc/infrastructure/presentation/config/background.dart';
import 'package:sign_in_bloc/infrastructure/services/socket_client/socket_client_impl.dart';

import 'application/BLoC/trendings/trendings_bloc.dart';
import 'infrastructure/presentation/homePage/home_page.dart';

void main() async {
  // PARA INICIALIZAR LOS WIDGETS
  WidgetsFlutterBinding.ensureInitialized();

  //PARA RECIBIR NOTIFICACIONES EN BACKGROUND
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);

  //PARA INICIALIZAR FIREBASE CLOUD MESSAGING
  await NotificationsBloc.initializeFCM();

  //PARA INICIALiZAR LOCAL NOTIFICATIONS
  await LocalNotificationsImpl().inicializeLocalNotifications();

  //PARA INICIALIZAR EL SOCKET
  SocketClientImpl().inicializeSocket();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().getTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => TrendingsBloc()),
          BlocProvider(
              create: (context) => NotificationsBloc(
                  localNotifications: LocalNotificationsImpl())),
          BlocProvider(
              create: (context) => SocketBloc(socketClient: SocketClientImpl()))
        ],
        child: const GradientBackground(child: HomePage()),
      ),
    );
  }
}
