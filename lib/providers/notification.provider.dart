import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class NotificationProvider extends ChangeNotifier {
  String? titleReceive;
  String? bodyReceive;
  DateTime? dateTime;

  NotificationProvider() {
    init();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  Random random = Random();

  Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: selectNotification);
  }

  Future<dynamic> selectNotification(String? payload) async {
    debugPrint('notification payload: $payload');
    Map<String, dynamic> data = jsonDecode(payload!);
    titleReceive = data['title'];
    bodyReceive = data['body'];
    dateTime = DateTime.now();
    notifyListeners();
  }

  Future<void> viewNotification(
      {required String channelName,
      required String channelDesc,
      required String title,
      required String body}) async {
    int randomNumber = random.nextInt(25);
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('c$randomNumber', channelName,
            channelDescription: channelDesc,
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);
    var data = {"title": title, "body": body};
    var jsonString = jsonEncode(data);
    await flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: jsonString);
  }

  Future<void> scheduleNotification(BuildContext context,
      {required String channelName,
      required String channelDesc,
      required String title,
      required String body,
      required DateTime dateTime}) async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    int randomNumber = random.nextInt(25);
    var data = {"title": title, "body": body};
    var jsonString = jsonEncode(data);
    await flutterLocalNotificationsPlugin.zonedSchedule(
        randomNumber,
        title,
        body,
        tz.TZDateTime.from(dateTime, tz.local),
        NotificationDetails(
            android: AndroidNotificationDetails('c$randomNumber', channelName,
                channelDescription: channelDesc,
                importance: Importance.max,
                priority: Priority.high,
                ticker: 'ticker')),
        androidAllowWhileIdle: true,
        payload: jsonString,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text('Reminder Set')));
  }

  Future<void> scheduleDaily(
      {required String channelName,
      required String channelDesc,
      required String title,
      required String body,
      required TimeOfDay timeOfDay}) async {
    tz.initializeTimeZones();
    final String currentTimeZone =
        await FlutterNativeTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(currentTimeZone));
    int randomNumber = random.nextInt(25);
    var data = {"title": title, "body": body};
    var jsonString = jsonEncode(data);
    await flutterLocalNotificationsPlugin.showDailyAtTime(
      randomNumber,
      title,
      body,
      Time(timeOfDay.hour, timeOfDay.minute, 0),
      NotificationDetails(
          android: AndroidNotificationDetails('c$randomNumber', channelName,
              channelDescription: channelDesc,
              importance: Importance.max,
              priority: Priority.high,
              ticker: 'ticker')),
      payload: jsonString,
    );
  }

  void receiveNotification() {
    bodyReceive = null;
    titleReceive = null;
    dateTime = null;
    notifyListeners();
  }

  void notificationReceived() {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);
    });
    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      // Will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }
}
