import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../starting/splashscreen.dart';

class MySchedules extends StatefulWidget {
  const MySchedules({super.key});

  @override
  State<MySchedules> createState() => _MySchedulesState();
}

class _MySchedulesState extends State<MySchedules> {
  var scheduleData;
  TextEditingController _open=TextEditingController();
  TextEditingController _openTu=TextEditingController();
  TextEditingController _openWed=TextEditingController();
  TextEditingController _openTh=TextEditingController();
  TextEditingController _openFri=TextEditingController();
  TextEditingController _openSat=TextEditingController();
  TextEditingController _openSun=TextEditingController();

  TextEditingController _close=TextEditingController();
  TextEditingController _closeTu=TextEditingController();
  TextEditingController _closeWed=TextEditingController();
  TextEditingController _closeTh=TextEditingController();
  TextEditingController _closeFri=TextEditingController();
  TextEditingController _closeSat=TextEditingController();
  TextEditingController _closeSun=TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();

  var selectOption=[
    0,0,0,0,0,0,0,0
  ];

  Future<void> _selectTime(BuildContext context,TextEditingController timeSel) async {
    print("::::::::::::::::::::::::::::::::::::hello its you r seleted time function is taped");
    final ThemeData theme = Theme.of(context);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext? context, Widget? child) {
        return child!;
      },
    );
    if (picked != null) {
      print({picked.hour.toString() + ':' + picked.minute.toString()});
      setState(() {
        timeSel.text="${picked.hour.toString()}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }
  Future<void> _selectTimeOpen(BuildContext context,TextEditingController timeOpen) async {
    print("::::::::::::::::::::::::::::::::::::hello its you r seleted time function is taped");
    final ThemeData theme = Theme.of(context);
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext? context, Widget? child) {
        return child!;
      },
    );
    if (picked != null) {
      print({picked.hour.toString() + ':' + picked.minute.toString()});
      setState(() {
        timeOpen.text="${picked.hour.toString()}:${picked.minute.toString().padLeft(2, '0')}";
      });
    }
  }

  Future<void> addSchedules(BuildContext context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = "34";
    map["monday_on_off"] = "${selectOption[0]}";
    map["monday_opening_time"] = _open.text;
    map["monday_closing_time"] = _close.text;
    map["tuesday_on_off"] = "${selectOption[1]}";
    map["tuesday_opening_time"] = _openTu.text;
    map["tuesday_closing_time"] = _closeTu.text;
    map["wednesday_on_off"] = "${selectOption[2]}";
    map["wednesday_opening_time"] = _openWed.text;
    map["wednesday_closing_time"] = _closeWed.text;
    map["thursday_on_off"] = "${selectOption[3]}";
    map["thursday_opening_time"] = _openTh.text;
    map["thursday_closing_time"] = _closeTh.text;
    map["friday_on_off"] = "${selectOption[4]}";
    map["friday_opening_time"] = _openFri.text;
    map["friday_closing_time"] = _closeFri.text;
    map["saturday_on_off"] = "${selectOption[5]}";
    map["saturday_opening_time"] = _openSat.text;
    map["saturday_closing_time"] = _closeSat.text;
    map["sunday_on_off"] = "${selectOption[6]}";
    map["sunday_opening_time"] = _openSun.text;
    map["sunday_closing_time"] =_closeSun.text;

    var res = await http.post(Uri.parse("$mainurl/employer_schedule.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::: $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        showSchedules(context);
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Schedule Uploaded'),
                content: const Text('Successfully!'),
                actions: <Widget>[

                ],
              );
            },
          );
          Future.delayed(const Duration(seconds: 1), () {
            setState(() {
              Navigator.pop(context);
            });

          });
      } else {

      }
    } else {
      print('error');
    }
  }
  Future<void> showSchedules(BuildContext context) async {
    HashMap<String, String> map = HashMap();
    print("hello your user id is :::: ${user_id}");
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/employer_schedule_show.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print("YOUr schedule data is or not:::::::::::: $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          scheduleData=jsondata;
        });
        setState(() {
          selectOption[0]=jsondata["monday_on_off"]==null?0:int.parse(jsondata["monday_on_off"]);
          selectOption[1]=jsondata["tuesday_on_off"]==null?0:int.parse(jsondata["tuesday_on_off"]);
          selectOption[2]=jsondata["wednesday_on_off"]==null?0:int.parse(jsondata["wednesday_on_off"]);
          selectOption[3]=jsondata["thursday_on_off"]==null?0:int.parse(jsondata["thursday_on_off"]);
          selectOption[4]=jsondata["friday_on_off"]==null?0:int.parse(jsondata["friday_on_off"]);
          selectOption[5]=jsondata["saturday_on_off"]==null?0:int.parse(jsondata["saturday_on_off"]);
          selectOption[6]=jsondata["sunday_on_off"]==null?0:int.parse(jsondata["sunday_on_off"]);

          _close.text=jsondata["monday_closing_time"]??"";
          _closeTu.text=jsondata["tuesday_closing_time"]??"";
          _closeWed.text=jsondata["wednesday_closing_time"]??"";
          _closeTh.text=jsondata["thursday_closing_time"]??"";
          _closeFri.text=jsondata["friday_closing_time"]??"";
          _closeSat.text=jsondata["saturday_closing_time"]??"";
          _closeSun.text=jsondata["sunday_closing_time"]??"";

          _open.text=jsondata["monday_opening_time"]??"";
          _openTu.text=jsondata["tuesday_opening_time"]??"";
          _openWed.text=jsondata["wednesday_opening_time"]??"";
          _openTh.text=jsondata["thursday_opening_time"]??"";
          _openFri.text=jsondata["friday_opening_time"]??"";
          _openSat.text=jsondata["saturday_opening_time"]??"";
          _openSun.text=jsondata["sunday_opening_time"]??"";
        });
      } else {
        setState(() {
          scheduleData=[];
        });
      }
    } else {
      setState(() {
        scheduleData=[];
      });
      print('error');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSchedules(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Schedules",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            ),
            onTap: () {
              Navigator.pop(context);
            }
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Drawer(),), (route) => false);        },
        ),
      ),
      body: scheduleData==null?Center(child: CircularProgressIndicator(color: Colors.green,)):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                scheduleBuild("Monday", 0, _open, _close),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Tuesday", 1, _openTu, _closeTu),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Wednesday", 2, _openWed, _closeWed),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Thursday", 3, _openTh, _closeTh),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Friday", 4, _openFri, _closeFri),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Saturday", 5, _openSat, _closeSat),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Sunday", 6, _openSun, _closeSun),
                SizedBox(height: 15),
                Container(
                    width: double.infinity,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                      onPressed: () {
                        if(_key.currentState!.validate()) {
                          addSchedules(context);
                        }
                      },
                      child: Text(
                        scheduleData.length==0?"Add":"Update",
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontSize: 17),
                      ),
                    )),

              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget scheduleBuild(var day,var option , TextEditingController open ,TextEditingController close){
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("$day",style: GoogleFonts.rubik(fontWeight: FontWeight.w400,fontSize: 18,),),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: MediaQuery.of(context).size.width/2.3,
              child: ListTile(
                title: Text('On',style: GoogleFonts.rubik(fontWeight: FontWeight.w300,fontSize: 18,)),
                leading: Radio<int>(
                  value: 1,
                  groupValue: selectOption[option],
                  activeColor: Color(0xFF118743), // Change the active radio button color here
                  fillColor: MaterialStateProperty.all(Color(0xFF118743)), // Change the fill color when selected
                  splashRadius: 25, // Change the splash radius when clicked
                  onChanged: (int? value) {
                    setState(() {
                      selectOption[option] = value!;
                    });
                  },
                ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width/2.3,
              child: ListTile(
                title: Text('Off',style: GoogleFonts.rubik(fontWeight: FontWeight.w300,fontSize: 18,)),
                leading: Radio<int>(
                  value: 0,
                  groupValue: selectOption[option],
                  activeColor: Color(0xFF118743), // Change the active radio button color here
                  fillColor: MaterialStateProperty.all(Color(0xFF118743)), // Change the fill color when selected
                  splashRadius: 25, // Change the splash radius when clicked
                  onChanged: (int? value) {
                    setState(() {
                      selectOption[option] = value!;
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        if(selectOption[option]==1)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width/2.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:12.0,top: 4),
                            child: Text("Opening Time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                          ),
                          Positioned(
                              top:0,
                              right: 0,
                              child: Text("*",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),)),

                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: open,
                      keyboardType: TextInputType.text,
                      onTap: ()async{
                        await _selectTimeOpen(context,open);
                      },
                      readOnly: true,
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return "Please enter value";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "time",
                        hintStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54,fontSize: 12),
                        helperStyle: TextStyle(fontSize: 18),
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 16),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                        ),
                        // fillColor: Color(0xFFF6F6F6),
                        // filled: true,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width/2.3,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(right:12.0,top: 4),
                            child: Text("Closing Time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
                          ),
                          Positioned(
                              top:0,
                              right: 0,
                              child: Text("*",style: TextStyle(color: Colors.red,fontSize: 16,fontWeight: FontWeight.w600),)),

                        ]),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: close,
                      keyboardType: TextInputType.text,
                      onTap: ()async{
                        await _selectTime(context,close);
                      },
                      readOnly: true,
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return "Please enter value";
                        }
                        return null;
                      },
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "time",
                        hintStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54,fontSize: 12),
                        helperStyle: TextStyle(fontSize: 18),
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 16),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 1, color: Colors.black12),
                        ),
                        // fillColor: Color(0xFFF6F6F6),
                        // filled: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
