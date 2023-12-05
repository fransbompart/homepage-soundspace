import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotifications {
  //TODO: esto es una interfaz
  static Future<void> requestPermissionLocalNotifications() async {
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
        FlutterLocalNotificationsPlugin();
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
  }

  static Future<void> inicializeLocalNotifications() async {
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

  static void showLocalNotifications(
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
