import 'dart:async';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/notificationservice/local_notification_service.dart';
import 'package:fac/starting/intro_screen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/fetchdata.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

var mainurl="http://103.99.202.191/fac/api";
var photo = "http://103.99.202.191/fac/img";
var photos="http://103.99.202.191/fac/images/";
var c_v="http://103.99.202.191/fac/cv";
var d_c="http://103.99.202.191/fac/documents";

var user_id = "";
var session_id = "";
bool inside = false;

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final homeScaffoldKey = GlobalKey<ScaffoldState>();
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  Future<void> requestNotificationPermission() async {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.requestNotificationsPermission();
    print("hnji");
  }

  @override
  void initState() {
    super.initState();
    fetchData();
    requestNotificationPermission();
    LocalNotificationService.initialize(context, RemoteMessage());
    FirebaseMessaging.instance.getInitialMessage().then((message) {
      if (message != null) {
        LocalNotificationService.display(message);
      }
    });

    FirebaseMessaging.onMessage.listen((message) async {
      if (message.notification != null) {
        print("+++++++++++++++++++");
        if (message.data != null) {
          print(message.data.toString());
        }
        print("11111111111111111111111111111111111");
        print(message.notification!.body);
      }
      LocalNotificationService.display(message);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("oh hiii");
      print('Notification tap ahib c message: ${message.notification!.body}');
      print("shubhpreet");

      LocalNotificationService.display(message);

      print("shubhpreet hundal");
    });

    Timer(Duration(seconds: 3), () {
      navigateToNextScreen();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/bg.jpg'), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: Center(
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.62,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset("assets/logo.png"),
            ),
          ),
        ));
  }

  void navigateToNextScreen() async {
    if (user_id == "") {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
      if (isFirstTime) {
        await prefs.setBool('isFirstTime', false);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => IntroScreen(),
          ),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Choose(),
          ),
        );
      }
    } else {
      if (type == "User") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Mainprofile(),
          ),
        );
      } else if (type == "Employer") {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const Emphome(),
          ),
        );
      }
    }
  }
}