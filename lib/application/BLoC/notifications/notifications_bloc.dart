import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:sign_in_bloc/application/models/NotificationModel.dart';
import 'package:sign_in_bloc/config/local_notifications/local_notifications.dart';
import 'package:sign_in_bloc/infrastructure/services/firebase_options.dart';

part 'notifications_event.dart';
part 'notifications_state.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  await Firebase.initializeApp();

  print("Handling a background message: ${message.messageId}");
}

//TODO: mandar la config de permiso de las local por constructor como inversion de dependencias

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  //TODO INVERSION DE DEPENDENCIAS
  final Future<void> Function()? requestLocalNotificationPermissions;
  final void Function(
      {required int id,
      String? title,
      String? body,
      String? data})? showLocalNotifications;

  NotificationsBloc(
      {this.showLocalNotifications, this.requestLocalNotificationPermissions})
      : super(const NotificationsState()) {
    on<NotificationStatusChanged>(_notificationStatusChanged);

    // Verificar estado de las notificaciones
    _initialStatusCheck();

    // Listener para notificaciones en Foreground
    _onForegroundMessage();
  }

  static Future<void> initializeFCM() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  void _notificationStatusChanged(
      NotificationStatusChanged event, Emitter<NotificationsState> emit) {
    emit(state.copyWith(status: event.status));
    _getFCMToken();
  }

  void _initialStatusCheck() async {
    final settings = await messaging.getNotificationSettings();
    add(NotificationStatusChanged(settings.authorizationStatus));
  }

  void _getFCMToken() async {
    if (state.status != AuthorizationStatus.authorized) return;

    final token = await messaging.getToken();
    print(token);
  }

  void handleRemoteMessage(RemoteMessage message) {
    if (message.notification == null) return;

    if (showLocalNotifications != null) {
      showLocalNotifications!(
        id: 1,
        body: message.notification!.body ?? '',
        data: message.data.toString(),
        title: message.notification!.title ?? '',
      );
    }
  }

  void _onForegroundMessage() {
    _getFCMToken();
    FirebaseMessaging.onMessage.listen(handleRemoteMessage);
  }

  void requestPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: true,
      provisional: false,
      sound: true,
    );

    //Permiso de las local notifications
    if (requestLocalNotificationPermissions != null) {
      await requestLocalNotificationPermissions!();
    }

    add(NotificationStatusChanged(settings.authorizationStatus));
  }
}
