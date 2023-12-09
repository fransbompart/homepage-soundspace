import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:sign_in_bloc/infrastructure/services/local_notifications/local_notifications.dart';

class LocalNotificationsImpl extends LocalNotifications {
  @override
  Future<void> inicializeLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  @override
  Future<void> requestPermissionLocalNotifications() async {
    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    const initializationSettingsAndroid =
        AndroidInitializationSettings('app_logo');

    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      //TODO despues
    );
  }

  @override
  void showLocalNotifications(
      {required int id, String? title, String? body, String? data}) {
    //TODO CUADRAR LO DE LA IMAGEN CON HTTP
    const androidDetails = AndroidNotificationDetails(
        "channelId", "channelName",
        playSound: true, importance: Importance.max, priority: Priority.high);

    const notificationDetails = NotificationDetails(
      android: androidDetails,
      //TODO IOS DETAILS
    );

    final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    flutterLocalNotificationsPlugin.show(id, title, body, notificationDetails,
        payload: data);
  }
}
