import 'dart:collection';
import 'dart:convert';

import 'package:clean_calendar/clean_calendar.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

import '../starting/splashscreen.dart';
import 'event.dart';

class TimeSlots extends StatefulWidget {
  final Function(String,String) callback;
  TimeSlots({required this.callback});

  @override
  State<TimeSlots> createState() => _TimeSlotsState();
}

class _TimeSlotsState extends State<TimeSlots> {

  CalendarFormat _format =CalendarFormat.month;

  late CalendarController _controller;
  late Map<DateTime, List<dynamic>> _events;
  late DateTime selectDay;
  late List<CleanCalendar> selectedEvent;
  var _current = DateTime.now();
  List<DateTime> _selectedDates = [];
  List<DateTime> _dateStrikes=[];

  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? currentIndex ;
  bool _isWeekend = false;
  bool _dateSelected=false;
  bool _timeSelected=false;
  bool _isExpanded=true;
  var timeSlot;
  var weekOffOn;

  Map<DateTime,List<Event>>events ={};
  late final ValueNotifier<List<Event>> _selectedEvents;

  List<Event> _getEventForDay(DateTime day){
    return events[day] ??[];
  }



  timeSlots(var data_selected) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["select_date"] = data_selected;
    map["user_id"]= user_id.toString();


    // if(selectedStatus=="Interview")
    //   map["schedule_date"]=datecontroller.text;
    // if(selectedStatus=="Interview")
    //   map["schedule_time"]=ttime.toString();


    var res = await http.post(Uri.parse("$mainurl/interview_slots_time.php"),
        body: jsonEncode(map));
    print("*");
    print(map);
    print("*");
    print(res.body);
    print("*");
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          print("::::::::::Your time slot value is :$jsondata");
          if(jsondata["slotes"] !=null) {
            timeSlot = jsondata["slotes"];
          }else{
            timeSlot=[];
          }
        });
        return jsondata;
      } else {
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
  weekOnOff() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id.toString();


    // if(selectedStatus=="Interview")
    //   map["schedule_date"]=datecontroller.text;
    // if(selectedStatus=="Interview")
    //   map["schedule_time"]=ttime.toString();


    var res = await http.post(Uri.parse("$mainurl/working_days.php"),
        body: jsonEncode(map));
    print("*");
    print(map);
    print("*");
    print(res.body);
    print("*");
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          weekOffOn = jsondata;
        });
        return jsondata;
      } else {
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
  daybooked(int month) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id.toString();
    map["month"]= "$month";

    // if(selectedStatus=="Interview")
    //   map["schedule_date"]=datecontroller.text;
    // if(selectedStatus=="Interview")
    //   map["schedule_time"]=ttime.toString();


    var res = await http.post(Uri.parse("$mainurl/interview_month_slot.php"),
        body: jsonEncode(map));
    print("*");
    print(map);
    print("*");
    print(res.body);
    print("*");
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh strikes  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        var data2 = jsondata["data"];
        for(int i=0;i<data2.length;i++) {
          DateTime formate =DateTime.parse(data2[i]["schedule_date"]);
          print("your day stikees is ${formate.day}");
          DateTime stike = DateTime(formate.year,formate.month,formate.day);
          setState(() {
            _dateStrikes.add(stike);
          });
        }
        print("hllo its strikes data :::::${_dateStrikes}");
        return jsondata;
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No slot is booked"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
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
    String selctedDate =DateFormat('yyyy-MM-dd').format(_currentDay);
    timeSlots(selctedDate);
    weekOnOff();
    daybooked(_currentDay.month);
    _selectedEvents=ValueNotifier(_getEventForDay(_currentDay));
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Select Slots"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          _cleanCalender(),
          SizedBox(
            height: 10,
          ),
          Text("Available Slots",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
          SizedBox(
            height: 10,
          ),
          timeSlot==null?Center(child: CircularProgressIndicator(color: Colors.green.shade500,)):timeSlot.length==0? Column(
            children: [
              Center(child: Text("Office is Closed",style: TextStyle(fontWeight: FontWeight.w500),)),
            ],
          ):Expanded(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: GridView.count(
                crossAxisCount: 3 ,
                children: List.generate(timeSlot.length,(index){
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: (){
                        if(timeSlot[index]["slot_available"]!="Slot Not available" && timeSlot[index]["slot_available"]>0) {
                          String selctedDate =DateFormat('yyyy-MM-dd').format(_current);
                          print("hello its you current dat for selected date ${selctedDate}");
                          print("hello its you current dat for selected date ${timeSlot[index]}");
                         openHere(selctedDate, timeSlot[index]["tdate_first_time"]);

                        }else{
                          showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                backgroundColor: Colors.white,
                                content: Container(
                                    height: 100,
                                    width: 50,
                                    child: Center(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.clear,color: Colors.red,size: 40,),
                                            SizedBox(height: 10,),
                                            Text(
                                              "Slot is not available",
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 17),
                                            ),
                                          ],
                                        ))),
                              )
                          );
                          Future.delayed(Duration(seconds: 1),(){
                            Navigator.pop(context);
                          });
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 0.2,color: Colors.black),
                            borderRadius: BorderRadius.circular(10),
                            color: timeSlot[index]["slot_available"]=="Slot Not available"?Colors.white:Colors.green.shade200
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("Time : ${timeSlot[index]["slots_timing"]??""}",textAlign: TextAlign.center,style: TextStyle(fontWeight: FontWeight.w600,color: timeSlot[index]["slot_available"]=="Slot Not available"?Colors.black:Colors.white)),
                              SizedBox(
                                height: 4,
                              ),
                              Text("${timeSlot[index]["slot_available"]!="Slot Not available"?"${timeSlot[index]["slot_available"]} Slot available":timeSlot[index]["slot_available"]}",textAlign: TextAlign.center,style: TextStyle(color: timeSlot[index]["slot_available"]=="Slot Not available"?Colors.black:Colors.white),),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          )
        ],
      ),

    );
  }

  void openHere(var selDate,var timeSlot) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
            height: 50,
            width: 50,
            child: Center(
                child: Text(
                  "Are You Sure? You Want To Book This Slot",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.baloo2(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                       Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743)),
                    )),
                Spacer(
                  flex: 2,
                ),
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          Navigator.pop(context);
                          Navigator.pop(context);

                          widget.callback(selDate,timeSlot);
                          //_time.text = "${timeSlot[index]["slots_timing"] ?? ""}";
                        });
                      },
                      child: Text(
                        "Yes",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                      ),
                    )),
              ],
            ),
          )
        ],
      ));
  Widget _tableCalender(){
    return ExpansionTile(
      title: _isExpanded==false?Text('Open Calendar'):Text('Close Calendar'), // Title for the panel when collapsed
      backgroundColor: Colors.white,
      initiallyExpanded: _isExpanded, // Initially expanded or collapsed based on the state
      onExpansionChanged: (expanded) { // Callback when the panel's expansion state changes
        setState(() {
          _isExpanded = expanded; // Update the expansion state
        });
      },
      children: [
        TableCalendar(
          focusedDay: _focusDay,
          firstDay: DateTime.now(),
          lastDay: DateTime(2025,12,31),
          calendarFormat: _format,
          currentDay: _currentDay,
          rowHeight: 48,
          calendarStyle: const CalendarStyle(
            todayDecoration: BoxDecoration(
                color: Colors.green,
                shape: BoxShape.circle
            ),
          ),
          availableCalendarFormats: const {
            CalendarFormat.month:'Month',
          },
          onFormatChanged: (format){
            setState(() {
              _format=format;
              print("hello its date formated ::::$_format");
            });
          },
          // eventLoader: (day) {
          //   // Replace this with your logic to load booked slots events for the given day from your API
          //   final List<dynamic> bookedSlots = fetchBookedSlotsForDay(day); // Function to fetch booked slots for the day
          //   return bookedSlots.map((slot) => Event(date: slot)).toList();
          // },
          onDaySelected: ((selectedDay , focusedDay){
            setState(() {
              _currentDay=selectedDay;
              _focusDay=focusedDay;
              _dateSelected=true;
              String selctedDate =DateFormat('yyyy-MM-dd').format(_currentDay);
              print("current dat ao f ${_currentDay}");
              timeSlots(selctedDate);
              print("hello selected items ::::::${DateFormat('yyyy-MM-dd').format(_currentDay)} $selctedDate , $selectedDay");
              //check if wweekend is selected
              if(selectedDay.weekday==6 || selectedDay.weekday == 7){
                _isWeekend=true;
                _timeSelected=false;
                currentIndex=null;
              }else{
                _isWeekend=false;
              }
            });
          }),
        ),
      ],
    );
  }
  Widget _cleanCalender(){
    return Container(

      child: CleanCalendar(
        currentDateOfCalendar: _current,
        //selectedDates: _selectedDates,

        enableDenseViewForDates: true,
        enableDenseSplashForDates: true,
        dateSelectionMode: DatePickerSelectionMode.singleOrMultiple,
        onSelectedDates: (List<DateTime> selectedDates) {
          setState(() {
            _selectedDates = selectedDates; // Update the selected dates
          });

          // Log each selected date
          for (var selectedDate in selectedDates) {
            print('Selected Date: $selectedDate');
            var selectedD = DateFormat('yyyy-MM-dd').format(selectedDate);
            var selectedDN = DateFormat('yyyy-MM-dd').format(DateTime.now());
            if(selectedDate.isBefore(DateTime.now())==false || selectedD == selectedDN) {
              setState(() {

                _current = selectedDate;

                String selctedDate = DateFormat('yyyy-MM-dd').format(_current);
                timeSlots(selctedDate);
              });
            }
          }
        },
        onCalendarViewDate: (value){
          int month = value.month;
          daybooked(month);
          print('Current month: $month');
          print("hello its view calenders ${value}");
        },
        weekdaysProperties: WeekdaysProperties(
            mondayDecoration: WeekdaysDecoration(
                weekdayTextColor: weekOffOn == null?Colors.black:weekOffOn["monday"]=="On"?Colors.black: Colors.green
            ),
            tuesdayDecoration: WeekdaysDecoration(
                weekdayTextColor: weekOffOn == null?Colors.black:weekOffOn["tuesday"]=="On"?Colors.black: Colors.green
            ),
            wednesdayDecoration: WeekdaysDecoration(
                weekdayTextColor: weekOffOn == null?Colors.black:weekOffOn["wednesday"]=="On"?Colors.black: Colors.green
            ),
            thursdayDecoration: WeekdaysDecoration(
                weekdayTextColor: weekOffOn == null?Colors.black:weekOffOn["thursday"]=="On"?Colors.black: Colors.green
            ),
            fridayDecoration: WeekdaysDecoration(
                weekdayTextColor: weekOffOn == null?Colors.black:weekOffOn["friday"]=="On"?Colors.black: Colors.green
            ),
            generalWeekdaysDecoration:
            WeekdaysDecoration(weekdayTextColor: Colors.black),
            sundayDecoration: WeekdaysDecoration(
              weekdayTextColor: weekOffOn == null?Colors.black:weekOffOn["sunday"]=="On"?Colors.black: Colors.green,
            ),
            saturdayDecoration: WeekdaysDecoration(
              weekdayTextColor: weekOffOn == null?Colors.black:weekOffOn["saturday"]=="On"?Colors.black: Colors.green,
              // weekdayTextStyle:
              // Theme.of(context).textTheme.headlineMedium),
            )
        ),
        datesForStreaks: _dateStrikes,
        startWeekday: WeekDay.monday,
        currentDateProperties: DatesProperties(
          datesDecoration: DatesDecoration(
            datesBorderRadius: 1000,
            datesBackgroundColor: Colors.green,
            datesBorderColor: Colors.green,
            datesTextColor: Colors.white,
          ),
        ),
        generalDatesProperties: DatesProperties(
          datesDecoration: DatesDecoration(
            datesBorderRadius: 1000,
            datesBackgroundColor: Colors.white,
            datesBorderColor: Colors.white,
            datesTextColor: Colors.black,
          ),
        ),
        streakDatesProperties: DatesProperties(
          datesDecoration: DatesDecoration(
            datesBorderRadius: 1000,
            datesBackgroundColor: Colors.lightGreen.shade100,
            datesBorderColor: Colors.lightGreen.shade100,
            datesTextColor: Colors.black,
          ),
        ),
      ),
    );
  }
}
