import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:http/http.dart' as http;
import '../starting/splashscreen.dart';
import 'bottom.dart';

class MySlots extends StatefulWidget {
  const MySlots({super.key});

  @override
  State<MySlots> createState() => _MySlotsState();
}
var timeSlot;

class _MySlotsState extends State<MySlots> {
  int count =0;

  interviewSlots() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id.toString();


    // if(selectedStatus=="Interview")
    //   map["schedule_date"]=datecontroller.text;
    // if(selectedStatus=="Interview")
    //   map["schedule_time"]=ttime.toString();


    var res = await http.post(Uri.parse("$mainurl/interview_all_slot.php"),
        body: jsonEncode(map));
    print("*");
    print(map);
    print("*");
    print(res.body);
    print("*");
    dynamic jsondata = jsonDecode(res.body);
    print(" its you slots api $map");
    print(jsondata);
    print("uour fjson data is  this sthish $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0 ) {
        setState(() {
          print("::::::::::Your time slot value is :$jsondata");
          timeSlot=jsondata["data"];
        });
        return jsondata;
      }
      else if(jsondata["error_msg"]=="Time Schedule Slot Empaty"){
        setState(() {
          timeSlot=[];
        });
      }
      else {
        setState(() {
          timeSlot=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Fill date properly"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      setState(() {
        timeSlot=[];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something Went wrong"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
    }
  }

  @override
  void initState() {
    interviewSlots();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Slots",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Navigator.canPop(context)==true?Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ):Container(),
          onTap: () {
            if(Navigator.canPop(context));
            Navigator.pop(context);
            setState(() {

            });
          },
        ),
      ),
     body: timeSlot==null?CircularProgressIndicator(color: Colors.green,):timeSlot.length==0?Center(child: Text("No Slot is Booked")):Padding(
       padding: const EdgeInsets.all(10.0),
       child: _syncTableCalender(),
     ),
     bottomNavigationBar: Bottom(),
    );
  }
  Widget _syncTableCalender(){
    return SfCalendar(
      view: CalendarView.week,
      firstDayOfWeek: 1,
      onTap: (val){
        if(val.appointments?.isEmpty != null && val.appointments?.isEmpty == false) {
          Appointment appointment = val.appointments!.first;
          int index = getAppointments().indexOf(appointment);
          showSucessAlert(
              context, "${timeSlot[index]["user_name"]}", "${timeSlot[index]["email_id"]}",
              "${timeSlot[index]["open_position"]}");
        }
        print("hello its your interview value ${val.appointments?.isEmpty}");
        //print("hello its your interview value${val.appointments!.first}");
      },

      todayHighlightColor: Colors.green.shade700,
      dataSource: MeetingDataSource(getAppointments()),
      timeSlotViewSettings: TimeSlotViewSettings(
        numberOfDaysInView: 4,
        startHour: 8,
        endHour: 19,
        // nonWorkingDays: <int>[DateTime.friday, DateTime.saturday]),
      ),
    );
  }
  Future<void> showSucessAlert(BuildContext context,String message,String email,String job)async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Interview Details",softWrap: true,maxLines: 3,overflow: TextOverflow.ellipsis,),
                  ],
                ),
                SizedBox(
                  height: 30,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Name  : ',
                    style:TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),
                    children: [
                      WidgetSpan(
                          child: SizedBox(
                            width: 2, // your of space
                          )),
                      TextSpan(text: message, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'email  : ',
                    style:TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),
                    children: [
                      WidgetSpan(
                          child: SizedBox(
                            width: 2, // your of space
                          )),
                      TextSpan(text: email, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
                SizedBox(
                  height: 10,
                ),
                RichText(
                  text: TextSpan(
                    text: 'Job applied  : ',
                    style:TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),
                    children: [
                      WidgetSpan(
                          child: SizedBox(
                            width: 2, // your of space
                          )),
                      TextSpan(text: job, style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black)),
                    ],
                  ),
                  textAlign: TextAlign.left,
                ),
              ],
            ),
          ),
          actions: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: (){
                    Navigator.pop(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green.shade800,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child:Padding(
                      padding: const EdgeInsets.only(left: 20.0,right: 20,top: 10,bottom: 10),
                      child: Text(
                        "Ok",style: TextStyle(
                        fontWeight: FontWeight.w500,fontSize: 14,color: Colors.white
                      ),
                      ),
                    ) ,
                  ),
                ),
              ],
            )
          ],
        );
      },
    );
  }

  List<Appointment> getAppointments(){
    List<Appointment> meetings = <Appointment>[];
    print("hello chahat its printing $timeSlot ");
    for(int i=0;i<timeSlot.length;i++){
      print("hello its count call: $count && ${timeSlot[i]["schedule_date"]} && $i");
      if(timeSlot[i]["status"] == "Interview") {
        print("hello its count call: 23$count && ${timeSlot[i]["schedule_date"]} && $i");
        count++;
        //final DateTime todayDate= DateTime.parse("${timeSlot[i]["schedule_date"]}:${timeSlot[i]["schedule_time"]}");
        DateTime todayDate = DateFormat('yyyy-MM-dd:HH:mm:ss').parse(
            "${timeSlot[i]["schedule_date"]}:${timeSlot[i]["schedule_time"]}");
        //final DateTime todaytime=DateTime.parse(timeSlot[i]["schedule_time"]);
        final DateTime startTime = DateTime(
            todayDate.year, todayDate.month, todayDate.day, todayDate.hour,
            todayDate.minute, todayDate.second);
        print("hello chahat its printing $startTime and its today $todayDate");
        final DateTime endTime = startTime.add(Duration(hours: 1));
        meetings.add(Appointment(
            startTime: startTime,
            endTime: endTime,
            //recurrenceExceptionDates: [DateTime.now().add(Duration(days: 1))],
            //recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
            subject: 'Interview',
            color: Colors.green
        ));

      }
    }
    print("and your meitin is ::::: jksjdkf${count}");
    if(count == 0){
      print("and your meitin is ::::: jksjdkf${count}");
      setState(() {
        timeSlot =[];
      });
    }
    print("and your meitin is :::::::$meetings");
    // final DateTime today=DateTime.now();
    // final DateTime startTime = DateTime(today.year,today.month,today.day,4,30,0);
    // final DateTime startTime2 = DateTime(today.year,today.month,22,11,30,0);
    // final DateTime endTime = startTime.add(Duration(hours: 1));
    // final DateTime endTime2 = startTime2.add(Duration(hours: 1));
    // meetings.add(Appointment(
    //     startTime: startTime,
    //     endTime: endTime,
    //     recurrenceExceptionDates: [DateTime.now().add(Duration(days: 1))],
    //     //recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
    //     recurrenceRule: 'FREQ=DAILY;COUNT=3',
    //     subject: 'Interview',
    //     color: Colors.green
    // ));
    // meetings.add(Appointment(
    //     startTime: startTime2,
    //     endTime: endTime2,
    //     recurrenceExceptionDates: [DateTime.now().add(Duration(days: 2))],
    //     //recurrenceRule: 'FREQ=DAILY;INTERVAL=1',
    //     recurrenceRule: 'FREQ=DAILY;COUNT=2',
    //     subject: 'Interview 2',
    //     color: Colors.green.shade400
    // ));
    return meetings;
  }
}
class MeetingDataSource extends CalendarDataSource{
  MeetingDataSource(List<Appointment> source){
    appointments = source;

  }
}