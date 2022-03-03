import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class PushNotificationsManager {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  Future<void> init() async {

    /// Initialize all Settings -->
    var initializationSettingsAndroid = new AndroidInitializationSettings('@mipmap/ic_launcher');
    var initializationSettingsIOS = new IOSInitializationSettings();
    var initializationSettings = new InitializationSettings(
        android:  initializationSettingsAndroid,
        iOS:  initializationSettingsIOS);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);

    _firebaseMessaging.requestPermission(badge: true,alert: true);

    ///Configuration of new notification -->


    print("<--Inside--Notification--Manager-->");

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print("onMessage-->" + message.notification.toString());

      String notificationTitle = message.notification!.title!;

      String notificationBody = message.notification!.body!;

      var androidPlatformChannelSpecifics = AndroidNotificationDetails(
          'channel_ID', 'channel name',
          channelDescription: 'channel description',
          importance: Importance.max,
          playSound: true,
          showProgress: true,
          priority: Priority.high,
          ticker: 'test ticker');

      var iOSChannelSpecifics = IOSNotificationDetails();
      var platformChannelSpecifics = NotificationDetails(
          android: androidPlatformChannelSpecifics,
          iOS: iOSChannelSpecifics);

      ///Show notification container -->
      await flutterLocalNotificationsPlugin.show(
          0, notificationTitle, notificationBody, platformChannelSpecifics,
          payload: 'test');
    });


    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage remoteMessage){
      print("onMessageOpenedApp-->"+remoteMessage.data.toString());
    });


  }
}

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) async {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
    print("BData" + data.toString());
  }

  if (message.containsKey('notification')) {
    //Handle notification message
    final dynamic notification = message['notification'];
    print("BNotification" + notification.toString());
  }
}