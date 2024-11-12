import 'dart:convert';
import 'package:fac/home/Userbottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart'as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../home/user_prof_view.dart';
class Not extends StatefulWidget {
  const Not({super.key});

  @override
  State<Not> createState() => _NotState();
}

class _NotState extends State<Not> {

int rowss=0;
List<Map<String, dynamic>> notifications = [];

  @override
  void initState() {
    super.initState();
    Allnotifications();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Notifications",
            style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
          ),
          leading: Navigator.canPop(context)?IconButton(
            onPressed: () {
              if(Navigator.canPop(context))
                Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ):Container(),
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Notifications",
                        style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          fontSize: 20,
                        ),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "allnotifications");
                        },
                        child: Text(
                          "View All",
                          style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w400,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                 if(notifications.isNotEmpty)

                   ListView.builder(
                     shrinkWrap: true,
                     physics: NeverScrollableScrollPhysics(),
                     itemCount: notifications.length,
                     itemBuilder: (context, index) {
                       DateTime dateTime = DateTime.parse(notifications[index]["date"]);
                       String formattedTime = DateFormat.Hm().format(dateTime);
                       Color containerColor;
                       Color textColor;
                       Color timeColor;
                       switch (notifications[index]["ntype"]) {
                         case "Message":
                           containerColor = Colors.white;
                           textColor=Colors.black;
                           timeColor=Colors.grey;
                           break;
                         case "Interview":
                           if(notifications[index]["new"]=="Yes")
                           {
                             containerColor = Color(0xFF4e3b7b);
                           }else{
                             containerColor = Color(0xFF7e698c);
                           }
                           textColor=Colors.white;
                           timeColor=Colors.white;

                           break;
                         case "Selected":
                           if(notifications[index]["new"]=="Yes")
                           {
                             containerColor = Color(0xFF8fae5e);
                           }else{
                             containerColor = Color(0xFF919f7b);
                           }
                           textColor=Colors.white;
                           timeColor=Colors.white;


                           break;
                         case "Shortlisted":
                           if(notifications[index]["new"]=="Yes")
                           {
                             containerColor = Color(0xFF4b8f8c);
                           }else{
                             containerColor = Color(0xFF85b5b3);
                           }
                           textColor=Colors.white;
                           timeColor=Colors.white;


                           break;
                         case "Rejected":
                           if(notifications[index]["new"]=="Yes")
                           {
                             containerColor = Color(0xFFff786c);
                           }else{
                             containerColor = Color(0xFFfc947f);
                           }
                           textColor=Colors.white;
                           timeColor=Colors.white;


                           break;
                         default:
                           containerColor = Colors.white;
                           textColor=Colors.black;
                           timeColor=Colors.grey;

                       }
                       return InkWell(
                         onTap: (){
                           if(notifications[index]["ntype"] == "Application") {
                             Navigator.push(context, MaterialPageRoute(
                                 builder: (context) =>
                                     UserProfView(
                                         userId: "${notifications[index]["sender_user_id"]}")));
                           }
                         },
                         child: Container(
                           margin: EdgeInsets.only(bottom: 20),
                           width: double.infinity,
                           decoration: BoxDecoration(
                             boxShadow: [
                               BoxShadow(
                                 color: Colors.grey.withOpacity(0.2),
                                 spreadRadius: 2,
                                 blurRadius: 2,
                               ),
                             ],
                             color: containerColor,
                             borderRadius: BorderRadius.circular(15),
                           ),
                           child: Padding(
                             padding: const EdgeInsets.all(12.0),
                             child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                               children: [
                                 Expanded(
                                   child: Container(
                                     child: Text(
                                       notifications[index]["notification"],
                                       maxLines: 4,
                                       style: GoogleFonts.rubik(
                                           fontSize: 13,
                                           fontWeight: notifications[index]["new"] == "Yes" ? FontWeight.w500 : FontWeight.w200,
                                           color: textColor
                                       ),
                                       overflow: TextOverflow.ellipsis,
                                     ),
                                   ),
                                 ),
                                 SizedBox(width: 10,),
                                 Text(
                                   formattedTime,
                                   style: GoogleFonts.rubik(color: timeColor),
                                 ),
                               ],
                             ),
                           ),
                         ),
                       );
                     },
                   ),
                  if(notifications.isEmpty)
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.2),
                            spreadRadius: 2,
                            blurRadius: 2,
                          ),
                        ],
                        color: Colors.white,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Text("No new Notification",style:GoogleFonts.rubik(),textAlign:TextAlign.center,),
                      ),
                    ),

                  SizedBox(height: 20,),
                ],
              ),
            ),
          ],
        ),

        bottomNavigationBar: Userbottom(),
      ),
    );
  }

  Future<void> Allnotifications() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id,
    };
    final response = await http.post(
      Uri.parse('$mainurl/view_notifications.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("Notification-----> $jsondata");
      if (jsondata["error"] == 0) {
        setState(() {
    print("ohkkk");
    rowss = jsondata["rows"];
    print("--------------->$rowss----------------------------->");
    if(rowss!="0"){
      notifications = List<Map<String, dynamic>>.from(jsondata["notification"]);
    }else{
      notifications=[];
    }


        });
      } else {
        print("Error: ${jsondata["error"]}");
      }
  }
}
