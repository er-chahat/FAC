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

  var n=[1,1,1,1,1,1,1,1];
  List<String> itemList = ['15 min', '30 min', '60 min','120 min'];
  String? selectedItem ;

  var mon =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var monC =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var tues =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var tuesC =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var wed =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var wedC =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var th =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var thC =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var fri =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var friC =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var sat =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var satC =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var sun =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];
  var sunC =[
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

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
    map["user_id"] = user_id.toString();
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
    map["monday_one_start_break"] = mon[0].text;
    map["monday_two_start_break"] = mon[1].text;
    map["monday_three_start_break"] = mon[2].text;
    map["monday_one_end_break"] = monC[0].text;
    map["monday_two_end_break"] = monC[1].text;
    map["monday_three_end_break"] = monC[2].text;
    map["tuesday_one_start_break"] = tues[0].text;
    map["tuesday_two_start_break"] = tues[1].text;
    map["tuesday_three_start_break"] = tues[2].text;
    map["tuesday_one_end_break"] = tuesC[0].text;
    map["tuesday_two_end_break"] = tuesC[1].text;
    map["tuesday_three_end_break"] = tuesC[2].text;
    map["wednesday_one_start_break"] = wed[0].text;
    map["wednesday_two_start_break"] = wed[1].text;
    map["wednesday_three_start_break"] = wed[2].text;
    map["wednesday_one_end_break"] = wedC[0].text;
    map["wednesday_two_end_break"] = wedC[1].text;
    map["wednesday_three_end_break"] = wedC[2].text;
    map["thursday_one_start_break"] = th[0].text;
    map["thursday_two_start_break"] = th[1].text;
    map["thursday_three_start_break"] = th[2].text;
    map["thursday_one_end_break"] = thC[0].text;
    map["thursday_two_end_break"] = thC[1].text;
    map["thursday_three_end_break"] = thC[2].text;
    map["friday_one_start_break"] = fri[0].text;
    map["friday_two_start_break"] = fri[1].text;
    map["friday_three_start_break"] = fri[2].text;
    map["friday_one_end_break"] = friC[0].text;
    map["friday_two_end_break"] = friC[1].text;
    map["friday_three_end_break"] = friC[2].text;
    map["saturday_one_start_break"] = sat[0].text;
    map["saturday_two_start_break"] = sat[1].text;
    map["saturday_three_start_break"] = sat[2].text;
    map["saturday_one_end_break"] = satC[0].text;
    map["saturday_two_end_break"] = satC[1].text;
    map["saturday_three_end_break"] = satC[2].text;
    map["sunday_one_start_break"] = sun[0].text;
    map["sunday_two_start_break"] = sun[1].text;
    map["sunday_three_start_break"] = sun[2].text;
    map["sunday_one_end_break"] =sunC[0].text;
    map["sunday_two_end_break"] =sunC[1].text;
    map["sunday_three_end_break"] =sunC[2].text;
    map["slot_time"] =selectedItem != null?selectedItem!.split(" ")[0]:"";

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
        print("helo its json dschedule data $scheduleData");
        setState(() {
          selectOption[0]=jsondata["monday_on_off"]==""?0:int.parse(jsondata["monday_on_off"]);
          selectOption[1]=jsondata["tuesday_on_off"]==""?0:int.parse(jsondata["tuesday_on_off"]);
          selectOption[2]=jsondata["wednesday_on_off"]==""?0:int.parse(jsondata["wednesday_on_off"]);
          selectOption[3]=jsondata["thursday_on_off"]==""?0:int.parse(jsondata["thursday_on_off"]);
          selectOption[4]=jsondata["friday_on_off"]==""?0:int.parse(jsondata["friday_on_off"]);
          selectOption[5]=jsondata["saturday_on_off"]==""?0:int.parse(jsondata["saturday_on_off"]);
          selectOption[6]=jsondata["sunday_on_off"]==""?0:int.parse(jsondata["sunday_on_off"]);
          print("helo its json dschedule data123 $scheduleData");
          _close.text=jsondata["monday_closing_time"]??"";
          _closeTu.text=jsondata["tuesday_closing_time"]??"";
          _closeWed.text=jsondata["wednesday_closing_time"]??"";
          _closeTh.text=jsondata["thursday_closing_time"]??"";
          _closeFri.text=jsondata["friday_closing_time"]??"";
          _closeSat.text=jsondata["saturday_closing_time"]??"";
          _closeSun.text=jsondata["sunday_closing_time"]??"";
          print("helo its json dschedule data12$scheduleData");
          _open.text=jsondata["monday_opening_time"]??"";
          _openTu.text=jsondata["tuesday_opening_time"]??"";
          _openWed.text=jsondata["wednesday_opening_time"]??"";
          _openTh.text=jsondata["thursday_opening_time"]??"";
          _openFri.text=jsondata["friday_opening_time"]??"";
          _openSat.text=jsondata["saturday_opening_time"]??"";
          _openSun.text=jsondata["sunday_opening_time"]??"";

          if(jsondata["monday_one_start_break"] != null){
            mon[0].text = jsondata["monday_one_start_break"]??"";
            monC[0].text = jsondata["monday_one_end_break"]??"";
          }
          if(jsondata["monday_two_start_break"] != null && jsondata["monday_two_start_break"]!="00:00:00"){
            if(n[0]<2)
              n[0]++;
            mon[1].text = jsondata["monday_two_start_break"]??"";
            monC[1].text = jsondata["monday_two_end_break"]??"";
          }
          if(jsondata["monday_three_start_break"] != null && jsondata["monday_three_start_break"]!="00:00:00"){
            print("hlelo yes coolled");
            if(n[0]<3)
              n[0]++;
            mon[2].text = jsondata["monday_three_start_break"]??"";
            monC[2].text = jsondata["monday_three_end_break"]??"";
          }
          if(jsondata["tuesday_one_start_break"] != null){
            tues[0].text = jsondata["tuesday_one_start_break"]??"";
            tuesC[0].text = jsondata["tuesday_one_end_break"]??"";
          }
          if(jsondata["tuesday_two_start_break"] != null && jsondata["tuesday_two_start_break"]!="00:00:00"){
            if(n[1]<2)
              n[1]++;
            tues[1].text = jsondata["tuesday_two_start_break"]??"";
            tuesC[1].text = jsondata["tuesday_two_end_break"]??"";
          }
          if(jsondata["tuesday_three_start_break"] != null && jsondata["tuesday_three_start_break"]!="00:00:00"){
            if(n[1]<3)
              n[1]++;
            tues[2].text = jsondata["tuesday_three_start_break"]??"";
            tuesC[2].text = jsondata["tuesday_three_end_break"]??"";
          }
          if(jsondata["wednesday_one_start_break"] != null){
            wed[0].text = jsondata["wednesday_one_start_break"]??"";
            wedC[0].text = jsondata["wednesday_one_end_break"]??"";
          }
          if(jsondata["wednesday_two_start_break"] != null && jsondata["wednesday_two_start_break"]!="00:00:00"){
            if(n[2]<2)
              n[2]++;
            wed[1].text = jsondata["wednesday_two_start_break"]??"";
            wedC[1].text = jsondata["wednesday_two_end_break"]??"";
          }
          if(jsondata["wednesday_three_start_break"] != null && jsondata["wednesday_three_start_break"]!="00:00:00"){
            if(n[2]<3)
              n[2]++;
            wed[2].text = jsondata["wednesday_three_start_break"]??"";
            wedC[2].text = jsondata["wednesday_three_end_break"]??"";
          }
          if(jsondata["thursday_one_start_break"] != null ){
            th[0].text = jsondata["thursday_one_start_break"]??"";
            thC[0].text = jsondata["thursday_one_end_break"]??"";
          }
          if(jsondata["thursday_two_start_break"] != null && jsondata["thursday_two_start_break"]!="00:00:00"){
            if(n[3]<2)
              n[3]++;
            th[1].text = jsondata["thursday_two_start_break"]??"";
            thC[1].text = jsondata["thursday_two_end_break"]??"";
          }
          if(jsondata["thursday_three_start_break"] != null && jsondata["thursday_three_start_break"]!="00:00:00"){
            if(n[3]<3)
              n[3]++;
            th[2].text = jsondata["thursday_three_start_break"]??"";
            thC[2].text = jsondata["thursday_three_end_break"]??"";
          }
          if(jsondata["friday_one_start_break"] != null){
            fri[0].text = jsondata["friday_one_start_break"]??"";
            friC[0].text = jsondata["friday_one_end_break"]??"";
          }
          if(jsondata["friday_two_start_break"] != null && jsondata["friday_two_start_break"]!="00:00:00"){
            if(n[4]<2)
              n[4]++;
            fri[1].text = jsondata["friday_two_start_break"]??"";
            friC[1].text = jsondata["friday_two_end_break"]??"";
          }
          if(jsondata["friday_three_start_break"] != null && jsondata["friday_three_start_break"]!="00:00:00"){
            if(n[4]<3)
              n[4]++;
            fri[2].text = jsondata["friday_three_start_break"]??"";
            friC[2].text = jsondata["friday_three_end_break"]??"";
          }
          if(jsondata["saturday_one_start_break"] != null){
            sat[0].text = jsondata["saturday_one_start_break"]??"";
            satC[0].text = jsondata["saturday_one_end_break"]??"";
          }
          if(jsondata["saturday_two_start_break"] != null && jsondata["saturday_two_start_break"]!="00:00:00"){
            if(n[5]<2)
              n[5]++;
            sat[1].text = jsondata["saturday_two_start_break"]??"";
            satC[1].text = jsondata["saturday_two_end_break"]??"";
          }
          if(jsondata["saturday_three_start_break"] != null && jsondata["saturday_three_start_break"]!="00:00:00"){
            if(n[5]<3)
              n[5]++;
            sat[2].text = jsondata["saturday_three_start_break"]??"";
            satC[2].text = jsondata["saturday_three_end_break"]??"";
          }
          if(jsondata["sunday_one_start_break"] != null){
            sun[0].text = jsondata["sunday_one_start_break"]??"";
            sunC[0].text = jsondata["sunday_one_end_break"]??"";
          }
          if(jsondata["sunday_two_start_break"] != null && jsondata["sunday_two_start_break"]!="00:00:00"){
            if(n[6]<2)
              n[6]++;
            sun[1].text = jsondata["sunday_two_start_break"]??"";
            sunC[1].text = jsondata["sunday_two_end_break"]??"";
          }
          if(jsondata["sunday_three_start_break"] != null && jsondata["sunday_three_start_break"]!="00:00:00") {
            if (n[6] < 3)
              n[6]++;
            sun[2].text = jsondata["sunday_three_start_break"] ?? "";
            sunC[2].text = jsondata["sunday_three_end_break"] ?? "";
          }
          if(jsondata["slot_time"] != null)
            selectedItem="${jsondata["slot_time"]} min";

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
    print("split string is ${itemList[0].split(" ")[0]}");
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
      body: scheduleData==null?Center(child: CircularProgressIndicator(color: Color(0xFF118743),)):SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Select Slot Duration",style: GoogleFonts.rubik(fontWeight: FontWeight.w400,fontSize: 18,),),
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,

                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                        isExpanded: true,

                        style: TextStyle(fontSize: 14, color: Colors.black),
                        hint: Text("   Select", style: TextStyle(color: Colors.grey)),
                        value: selectedItem,
                        onChanged: (selectedItem) {
                          setState(() {
                            this.selectedItem = selectedItem!;
                          });
                        },
                        items: itemList
                            .map((String item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                scheduleBuild("Monday", 0, _open, _close,mon,monC),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Tuesday", 1, _openTu, _closeTu,tues,tuesC),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Wednesday", 2, _openWed, _closeWed,wed,wedC),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Thursday", 3, _openTh, _closeTh,th,thC),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Friday", 4, _openFri, _closeFri,fri,friC),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Saturday", 5, _openSat, _closeSat,sat,satC),
                SizedBox(
                  height: 10,
                ),
                scheduleBuild("Sunday", 6, _openSun, _closeSun,sun,sunC),
                SizedBox(height: 15),
                Container(
                    width: double.infinity,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
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

  Widget scheduleBuild(var day,var option , TextEditingController open ,TextEditingController close,List<TextEditingController> bopen,var bclose){
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
                      print("hello its selected optioen valure $value");
                      selectOption[option] = value!;
                      print("hello its selected option valure ${selectOption[option]}");
                      print("hello its selected option valure ${option}");
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
                      print("hello its selected option value $value");
                      print("hello its selected option value ${selectOption[option]}");
                      print("hello its selected option value ${option}");
                    });
                  },
                ),
              ),
            ),
          ],
        ),
        if(selectOption[option]==1)
          Column(
            children: [
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
              SizedBox(
                height: 10,
              ),
              for(int i=0;i<n[option];i++)
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
                                  child: Text("Break Start Time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
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
                            controller: bopen[i],
                            keyboardType: TextInputType.text,
                            onTap: ()async{
                              await _selectTimeOpen(context,bopen[i]);
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
                                  child: Text("Break End Time",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 14),),
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
                            controller: bclose[i],
                            keyboardType: TextInputType.text,
                            onTap: ()async{
                              await _selectTime(context,bclose[i]);
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
              SizedBox(
                height: 10,
              ),
              if(n[option] < 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    if(n[option] >1)
                      Container(
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.red,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            onPressed: () {
                              setState(() {
                                if(n[option] > 1) {
                                  bopen[n[option]-1].clear();
                                  bclose[n[option]-1].clear();
                                  n[option]--;
                                }
                              });
                            },
                            child: Text(
                              "Remove",
                              style: GoogleFonts.rubik(
                                  color: Colors.white, fontSize: 12),
                            ),
                          )),
                    Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF118743),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            setState(() {
                              if(n[option] < 3) {
                                n[option]++;
                              }
                            });
                          },
                          child: Text(
                            "Add more",
                            style: GoogleFonts.rubik(
                                color: Colors.white, fontSize: 12),
                          ),
                        )),
                  ],
                ),
              if(n[option] == 3)
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.red,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20))),
                          onPressed: () {
                            setState(() {
                              if(n[option] > 1) {
                                n[option]--;
                              }
                            });
                          },
                          child: Text(
                            "Remove",
                            style: GoogleFonts.rubik(
                                color: Colors.white, fontSize: 12),
                          ),
                        )),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}
