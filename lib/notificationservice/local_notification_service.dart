import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class LocalNotificationService {
  static final FlutterLocalNotificationsPlugin _notificationsPlugin =
  FlutterLocalNotificationsPlugin();

  static void initialize(BuildContext context,RemoteMessage message) {
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: AndroidInitializationSettings("@mipmap/ic_launcher"));

    _notificationsPlugin.initialize(initializationSettings,onDidReceiveNotificationResponse: (payload){
      print("hi hrln");
      print(message.data.toString());
      LocalNotificationService.display(message);

    },
      onDidReceiveBackgroundNotificationResponse: (payload){
        print("hi hrln m in ");

        print(message.data.toString());
        LocalNotificationService.display(message);



      },
    );
  }


  static void display(RemoteMessage message) async {
    try {
      final id = DateTime.now().millisecondsSinceEpoch ~/ 1000;

      final NotificationDetails notificationDetails = NotificationDetails(
          android: AndroidNotificationDetails(
            "FAC",
            "FAC channel",
            importance: Importance.max,
            priority: Priority.high,
            visibility: NotificationVisibility.public,
          ));

      await _notificationsPlugin.show(
        id,
        message.notification!.title,
        message.notification!.body,
        notificationDetails,
        payload: message.data["url"],
      );
    } on Exception catch (e) {
      print(e);
    }
  }
 static Future<void> setupInteractMessage(BuildContext) async{
    RemoteMessage? message= await FirebaseMessaging.instance.getInitialMessage();
    if(message!=null){

      LocalNotificationService.display(message);
      print("hi hrln in in");



    }

  }
}