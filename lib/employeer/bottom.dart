import 'dart:async';
import 'dart:convert';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/my_slots.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

int _currentIndex = 0;

class Bottom extends StatefulWidget {
  const Bottom({Key? key}) : super(key: key);

  @override
  State<Bottom> createState() => BottomState();
}

class BottomState extends State<Bottom> {

  Timer? _timer;
  int totalNotifications = 0;
  int total=0;


  @override

  void initState() {
    notificationhere();
    super.initState();
  }

  static void resetIndex() {
    _currentIndex = 0;
  }


  void StartTimer() {
    _timer = Timer(Duration(seconds: 3), () {
      print(
          "RELOADINGGGGGGGGGG--------in employer");
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
      if(index !=_currentIndex){
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Emphome(),), (route) => false);
            break;
          case 1:
            Navigator.pushReplacementNamed(context, "msg");
            break;
          case 2:
            Navigator.pushReplacementNamed(context, "application");
            break;
          case 3:
            Navigator.pushReplacementNamed(context, "empnotification");
            break;
          case 4:
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MySlots()));
            break;
          case 5:
            Navigator.pushReplacementNamed(context, "drawer");
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
              Icon(Icons.notifications_active),
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
          icon: Icon(Icons.calendar_month),
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

  Future notificationhere() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id":user_id,
    };
    final response = await http.post(
      Uri.parse('$mainurl/count_notification.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("nn");
    print(jsondata);
    try {
      StartTimer();
      if (jsondata["error"] ==0) {
        print("okkkkkk");
        setState(() {
          totalNotifications = int.parse(jsondata["total_messages"]);
          total = int.parse(jsondata["total_notification"]);

        });
        print(jsondata["total_messages"]);
        print("okkkkkk");
      }
      else {
        print(jsondata["error"]);
      }
    } catch (e) {
      print('Error while fetching notification: $e');

    }
  }


}
