import 'dart:math';

import 'package:fac/welcome/login.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FirebaseApi{
  final _firebaseMessaging = FirebaseMessaging.instance;
  // final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  @pragma('vm:entry-point')
  Future<void> handleBackgroundMessg(RemoteMessage message)async{
    print("Title : :  :: : :: : : :${message.notification?.title}");
    print("Title : :  :: : :: : : :${message.notification?.body}");
    print("Payload : :  :: : :: : : :${message.data}");
   // await Firebase.initializeApp();
  }

  // void initLocalNotificaiton(RemoteMessage message)async{
  //   var androidInitialization = const AndroidInitializationSettings("mipmap/ic_launcher");
  //   var iosInitialization = const DarwinInitializationSettings();
  //
  //   var  initializtionSetting = InitializationSettings(
  //       android: androidInitialization,
  //       iOS: iosInitialization,
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.initialize(
  //     initializtionSetting,
  //     onDidReceiveNotificationResponse: (payload){
  //       print(":::::::::::::::::::::::::::::::jhhjjkk :::$payload");
  //       print(":::::::::::::::::::hkksdkfskdfh ::::::::::::${message.data}");
  //      // Navigator.push(context, MaterialPageRoute(builder: (context)=>AllTest()));
  //      // handleMessage(context, message);
  //     },
  //   );
  // }

  // Future<void> initNotifications()async{
  //   var prefs = await SharedPreferences.getInstance();
  //   var token=prefs.getString(LoginState.TOKEN);
  //   var login = prefs.getBool(LoginState.LOGIN)?? false;
  //   if(login==false) {
  //     await _firebaseMessaging.requestPermission();
  //     await _firebaseMessaging.deleteToken();
  //     final fCMToken = await _firebaseMessaging.getToken();
  //     prefs.setString(LoginState.TOKEN, fCMToken!);
  //     print('Token :::::::: new token gentrated $fCMToken');
  //     FirebaseMessaging.onMessage.listen((message) {
  //       initLocalNotificaiton(message);
  //       if(kDebugMode) {
  //         print("Title : :  :: : :: : : :${message.notification?.title}");
  //         print("Title : :  :: : :: : : :${message.notification?.body}");
  //       }
  //       showNotification(message);
  //     });
  //     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessg);
  //   }else{
  //     FirebaseMessaging.onMessage.listen((message) {
  //       initLocalNotificaiton(message);
  //       if(kDebugMode) {
  //         print("Title : :  :: : :: : : :${message.notification?.title}");
  //         print("Title : :  :: : :: : : :${message.notification?.body}");
  //         print("Title : :  :: :data  :: : : :${message.data["type"]}");
  //         print("Title : :  :: : data :: : : :${message.data["id"]}");
  //       }
  //
  //       showNotification(message);
  //     });
  //     print("hello its problem here");
  //     FirebaseMessaging.onBackgroundMessage(handleBackgroundMessg);
  //     print('Token : $token');
  //   }
  // }
  //
  // Future<void> showNotification(RemoteMessage message)async{
  //
  //   AndroidNotificationChannel channel = AndroidNotificationChannel(
  //       Random.secure().nextInt(100000).toString(),
  //       "high importance channel",
  //     importance: Importance.max
  //   );
  //   AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
  //       channel.id.toString(),
  //       channel.name.toString(),
  //     channelDescription: "Your channel description",
  //     importance: Importance.high,
  //    // sound: RawResourceAndroidNotificationSound('notification'),
  //     priority: Priority.high,
  //     ticker: 'ticker'
  //   );
  //   const DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
  //     presentAlert: true,
  //     presentBadge: true,
  //     presentSound: true,
  //   );
  //   NotificationDetails notificationDetail = NotificationDetails(
  //     android: androidNotificationDetails,
  //     iOS: darwinNotificationDetails,
  //   );
  //   Future.delayed(Duration.zero,(){
  //     _flutterLocalNotificationsPlugin.show(
  //         0,
  //         message.notification!.title.toString(),
  //         message.notification!.body.toString(),
  //         notificationDetail,
  //     );
  //   }
  //   );
  // }

  // void handleMessage(BuildContext context , RemoteMessage message){
  //   if(message.data["type"] == 'msg'){
  //     Navigator.push(context, MaterialPageRoute(builder: (context)=>AllTest()));
  //   }
  // }
}