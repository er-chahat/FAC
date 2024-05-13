import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/time_slot.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart'as http;
import 'package:fac/employeer/emphome.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Applicants extends StatefulWidget {
  const Applicants({super.key});

  @override
  State<Applicants> createState() => _ApplicantsState();
}

class _ApplicantsState extends State<Applicants> {

  bool idk=true;
  var timeSlot;

  String selectedStatus = '';

  var ttime="";
  Color borderColor = Colors.grey;
  Color textColor = Colors.black;
  TimeOfDay selectedTime = TimeOfDay(hour: 12, minute: 0);
  String? name="";
  String? date="";
  TextEditingController namecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController _time = TextEditingController();

  Future _showModal(var height,var width)async{
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MyModel(height,width);
      },
    );
  }

  void callback(String date , String time){
    setState(() {
      datecontroller.text=date;
      _time.text=time;
      send(context);
      print("your date and time is :::::::::::;${datecontroller.text} &&&& ${_time.text}");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Applicants",style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(iddname,style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 18),),

                              Text(iddem,style: GoogleFonts.rubik(color: Colors.grey,fontSize: 15),),


                            ],
                          ),
                          // Spacer(flex: 2,),
                          // GestureDetector(
                          //   onTap: (){
                          //     Navigator.pushNamed(context, "msgg");
                          //   },
                          //   child: Container(
                          //     decoration: BoxDecoration(
                          //       color: Color(0xFFEDF9F0),
                          //       borderRadius: BorderRadius.circular(10),
                          //     ),
                          //     child: IconButton(onPressed: (){
                          //       Navigator.pushNamed(context, "msgg");
                          //     }, icon: Icon(Icons.mail,color: Colors.green,),),
                          //   ),
                          // )
                        ],
                      ),
                      Divider(),

                      Column(
                        children: [
                          // if (selectedStatus == 'Interview')
                          //   Column(
                          //     children: [
                          //       Row(
                          //         children: [
                          //           Expanded(
                          //             child: TextFormField(
                          //               readOnly: true,
                          //               controller: datecontroller,
                          //               cursorColor: Color(0xFF118743),
                          //               onChanged: (text) {
                          //                 setState(() {
                          //                   date = text;
                          //                 });
                          //               },
                          //               style: GoogleFonts.rubik(),
                          //               validator: (value) {
                          //                 if (value!.isEmpty) {
                          //                   return 'This field is required';
                          //                 }
                          //                 return null;
                          //               },
                          //               autovalidateMode: AutovalidateMode.onUserInteraction,
                          //               onTap: () async {
                          //                 DateTime? pickedDate = await showDatePicker(
                          //                   context: context,
                          //                   initialDate: DateTime.now(),
                          //                   firstDate: DateTime.now(),
                          //                   lastDate: DateTime.now().add(Duration(days: 30)),
                          //                 );
                          //
                          //                 if (pickedDate != null) {
                          //                   String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                          //                   setState(() {
                          //                     datecontroller.text = formattedDate;
                          //                     timeSlots(formattedDate);
                          //                   });
                          //
                          //                 }
                          //               },
                          //               decoration: InputDecoration(
                          //                 filled: true,
                          //                 fillColor: Colors.white,
                          //                 contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          //                 enabledBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(color: Colors.grey),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 focusedBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(color: Colors.grey),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 border: OutlineInputBorder(
                          //                   borderSide: BorderSide(color: Colors.grey),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 hintText: "Date",
                          //               ),
                          //             ),
                          //           ),
                          //
                          //           SizedBox(width: 10,),
                          //           Expanded(
                          //             child: TextFormField(
                          //               readOnly: true,
                          //               controller: _time,
                          //               decoration: InputDecoration(
                          //                 filled: true,
                          //                 fillColor: Colors.white,
                          //                 contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          //                 enabledBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(color: Colors.grey),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 focusedBorder: OutlineInputBorder(
                          //                   borderSide: BorderSide(color: Colors.grey),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 border: OutlineInputBorder(
                          //                   borderSide: BorderSide(color: Colors.grey),
                          //                   borderRadius: BorderRadius.circular(10),
                          //                 ),
                          //                 hintText: "Time",
                          //               ),
                          //             ),
                          //           ),
                          //
                          //         ],
                          //       ),
                          //       SizedBox(height: 10,),
                          //       Divider(),
                          //     ],
                          //   ),
                          // SizedBox(height: 5),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Text("Message",style: GoogleFonts.rubik(),),
                                Text("*",style: GoogleFonts.rubik(color: Colors.red),)
                              ],
                            ),
                          ),
                          SizedBox(height: 5),

                          TextFormField(
                            controller: namecontroller,
                            cursorColor: Color(0xFF118743),
                            onChanged: (text) {
                              setState(() {
                                name = text;
                              });
                            },
                            style: GoogleFonts.rubik(),
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'This field is required';
                              }
                              return null;
                            },
                            autovalidateMode: AutovalidateMode.onUserInteraction,
                            minLines: 8,
                            maxLines: 1000,
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding:
                              EdgeInsets.symmetric(horizontal: 16,vertical: 16),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              border: OutlineInputBorder(
                                borderSide: BorderSide(color: borderColor),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              hintText: "Type a message...",
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.20),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (selectedStatus == 'Selected' && namecontroller.text.isNotEmpty)
                              ? Color(0xFF118743)
                              : Color(0xff8BD88A), // Adjust the colors as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Selected';
                            borderColor=Color(0xFF118743);
                          });
                         if(namecontroller.text.isNotEmpty){
                           send(context);
                         }
                        },
                        child: Text(
                          "Selected",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (selectedStatus == 'Rejected' && namecontroller.text.isNotEmpty)
                              ? Color(0xFFb30000)
                              : Color(0xffD88A8A), // Adjust the colors as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Rejected';
                            borderColor=Color(0xFFb30000);

                          });
                          if(namecontroller.text.isNotEmpty){
                            send(context);
                          }
                        },
                        child: Text(
                          "Rejected",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 10),

              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF0C5BC0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Interview';
                            borderColor = Color(0xFF0C5BC0);
                            // borderColor = (namecontroller.text != null && namecontroller.text.isNotEmpty)
                            //     ? Color(0xFF0C5BC0) :
                            // Color(0xFF6F97CA);
                          });
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) =>
                                  TimeSlots(callback: callback,)));
                          // if(namecontroller.text.isNotEmpty){
                          //   print("helllllllllllllllooooooooooooooooooooooooooooo:::::::::::::::::::::::::::");
                          //   Navigator.push(context, MaterialPageRoute(
                          //       builder: (context) =>
                          //           TimeSlots(callback: callback,)));
                          // }else{
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text("Please Enter Message"),
                          //       duration: Duration(seconds: 2),
                          //       shape:
                          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          //     ),
                          //   );
                          // }
                          // if((datecontroller.text.isEmpty && datecontroller.text == "") ||( _time.text.isEmpty && _time.text=="")) {
                          //
                          // }else{
                          //
                          // }

                          // if(datecontroller.text=="" && ttime==""){
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text("Enter the time and date"),
                          //       duration: Duration(seconds: 2),
                          //       shape:
                          //       RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          //     ),
                          //   );
                          //
                          // }else{
                          //   print("hellllllllllllllllloooooooooooooooooooo");
                          //   if(namecontroller.text.isNotEmpty &&datecontroller.text.isNotEmpty && ttime.isNotEmpty &&ttime!=""){
                          //     print("helllllllllllllllooooooooooooooooooooooooooooo:::::::::::::::::::::::::::");
                          //     send(context);
                          //   }
                          // }
                        },
                        child: Text(
                          "Interview",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Container(
                      height: 45,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: (selectedStatus == 'Shortlisted' && namecontroller.text.isNotEmpty)
                              ? Color(0xFFC0A20C)
                              : Color(0xffD8CB8A), // Adjust the colors as needed
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                        ),
                        onPressed: () {
                          setState(() {
                            selectedStatus = 'Shortlisted';
                            borderColor=Color(0xFFC0A20C);


                          });
                          if(namecontroller.text.isNotEmpty){
                            send(context);
                          }
                        },
                        child: Text(
                          "Shortlisted",
                          style: GoogleFonts.rubik(
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),

            ],
          ),
        ),
      ),
    );
  }

  send(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_apply_jop_id"] = iid.toString();
    map["status"]=selectedStatus;
    map["message"]=namecontroller.text;
    map["user_id"]= user_id.toString();
    map["schedule_date"]=datecontroller.text;
    map["schedule_time"]=_time.text;


    // if(selectedStatus=="Interview")
    //   map["schedule_date"]=datecontroller.text;
    // if(selectedStatus=="Interview")
    //   map["schedule_time"]=ttime.toString();


      var res = await http.post(Uri.parse("$mainurl/employer_user_applicants_status.php"),
        body: jsonEncode(map));
      print("*");
      print("its oyou slot map $map");
    print("*");
    print(res.body);
    print("*");

    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh chahat $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                  height: 300,
                  width: 50,
                  child: Center(
                      child: Column(
                        children: [
                          Image(image: AssetImage("assets/Done.png")),
                          SizedBox(height: 10,),
                          Text(
                            "Message sent",
                            style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 17),
                          ),
                        ],
                      ))),
            ));
        Future.delayed(Duration(seconds: 1),(){
          // Navigator.pushNamed(context, "single");
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Check the form and fill properly!"),
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
          timeSlot=jsondata["slotes"];
          _showModal(MediaQuery.of(context).size.height, MediaQuery.of(context).size.width);
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

  Widget MyModel(var height, var width)=>StatefulBuilder(
      builder:(BuildContext context,state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.6,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (_,controller) =>Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: timeSlot==null?Center(child: CircularProgressIndicator(color: Colors.green.shade500,)):Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Available time Slots",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.clear,color: Colors.black,size: 28,))
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: GridView.count(
                      crossAxisCount: 3 ,
                      children: List.generate(timeSlot.length,(index){
                        return Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: InkWell(
                            onTap: (){
                              if(timeSlot[index]["slot_available"]!="Slot Not available") {
                                state(() {
                                  setState(() {
                                    _time.text = "${timeSlot[index]["slots_timing"] ?? ""}";
                                  });
                                  Navigator.pop(context);
                                });
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
                  )
                ],
              ),
            ),
          ),
        );
      }
  );


}
