import 'dart:async';
import 'dart:convert';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

int _currentIndex = 0;

class Userbottom extends StatefulWidget {
  const Userbottom({Key? key}) : super(key: key);

  @override
  State<Userbottom> createState() => UserbottomState();
}

class UserbottomState extends State<Userbottom> {
  Timer? _timer;
  int totalNotifications = 0;
  int total=0;

  @override
  void initState() {
    notificationhere();
    super.initState();
    StartTimer();
  }

  static void resetIndex() {
    _currentIndex = 0;
  }

  void StartTimer() {
    _timer = Timer.periodic(Duration(seconds: 8), (timer) {
      print("Timer expired. Refreshing notifications...");
      notificationhere();
    });
  }

  @override
  void deactivate() {
    _timer?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: _currentIndex,
      onTap: (index) {
        print("hello your indez is this  $index");
        if (index != _currentIndex) {
          setState(() {
            _currentIndex = index;
          });
          switch (index) {
            case 0:
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
              break;
            case 1:
              Navigator.pushReplacementNamed(context, "usermsg");
              break;
            case 2:
              Navigator.pushReplacementNamed(context, "alljobs");
              break;
            case 3:
              Navigator.pushReplacementNamed(context, "notification");
              break;
            case 4:
              Navigator.pushReplacementNamed(context, "ud");
              break;
          }
        }
      },
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: '.',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.mail),
              if (totalNotifications > 0)
                Positioned(
                  top: -5,
                  right: -1,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      totalNotifications.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          label: '.',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.notes),
          label: '.',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            children: [
              Icon(Icons.notifications_active_rounded),
              if (total > 0)
                Positioned(
                  top: -5,
                  right: -1,
                  child: Container(
                    padding: EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      total.toString(),
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
          label: '.',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_customize_outlined),
          label: '.',
        ),
      ],
      backgroundColor: Colors.white,
      selectedItemColor: Color(0xFF118743),
      unselectedItemColor: Colors.grey,
    );
  }

  Future<void> notificationhere() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id,
    };
    final response = await http.post(
      Uri.parse('$mainurl/count_notification.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("Notifications response: $jsondata");
    try {
      if (jsondata["error"] == 0) {
        setState(() {
          totalNotifications = int.parse(jsondata["total_messages"]);
          total = int.parse(jsondata["total_notification"]);

        });
        print("Total messages: $totalNotifications");
      } else {
        print("Error: ${jsondata["error"]}");
      }
    } catch (e) {
      print('Error while fetching messages_notifications: $e');
    }
  }
}
