import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/bottom.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/employeer/subsub.dart';
import 'package:fac/home/subb.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/welcome/choose.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var current_subscription="";
var userdes_em="";

class Subscription extends StatefulWidget {
  final Function(String) callback;
  Subscription({required this.callback});

  @override
  State<Subscription> createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {
  List<Color> borderColorList = [];
  List<dynamic> allsub = [];
  bool _isLoading = true;
  var showsub = false;

  Future<void> showSub(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(Uri.parse("$mainurl/subscription_switch.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("::::::::::::::::$jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if(jsondata["user_subscription"]!="Off" && type == "User"){
          setState(() {
            showsub=true;
          });
        }else if(jsondata["employers_subscription"] != "Off" && type != "User"){
          setState(() {
            showsub=true;
          });
        }else if(jsondata["employers_subscription"] != "Off" && jsondata["user_subscription"]!="Off" ){
          setState(() {
            showsub=true;
          });
        }else{
          setState(() {
            showsub=false;
          });
        }

      } else {
        // if(userPorti.isNotEmpty){
        //   userPorti.clear();
        //   portfolioImages.clear();
        // }
      }
    } else {
      print('error');
    }
  }

  void callback(String s){
    setState(() {
      sublist(context);
    });
  }


  @override
  void initState() {
    showSub(context);
    print("hellow :::::: :::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::");
    sublist(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          showsub==true?"Subscription":"",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            setState(() {
              widget.callback("");
            });
            Navigator.pop(context);
          },
        ),
      ),
      body: showsub==true?_isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          :Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Choose your plan",
                  style: GoogleFonts.rubik(
                      fontSize: 24, fontWeight: FontWeight.w500),
                ),
                SizedBox(height: 10),
                Text(
                  "Choose a subscription plan to unlock all the functionality of the application.",
                  style: GoogleFonts.rubik(color: Colors.grey, fontSize: 15),
                ),
                SizedBox(
                  height: 25,
                ),
                Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: allsub.length,
                    itemBuilder: (context, index) {
                      var subscription = allsub[index];

                      while (borderColorList.length <= index) {
                        borderColorList.add(Colors.grey);
                      }
                      bool isSelected = subscription['subscription_id'] == current_subscription;
                      Color containerColor = isSelected ? Colors.green : Colors.transparent;
                      Color textColor=isSelected ? Colors.white :Colors.black;
                      Color dayColor=isSelected? Colors.white:Colors.green;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            resetBorders();
                            borderColorList[index] = Color(0xff118743);
                            print(subscription['subscription_id']);
                            sub_id=subscription['subscription_id'];
                            setState(() {
                              if(sub_id!=""||sub_id!=null){
                                userdes_em=subscription["ud"];
                                //Navigator.pushNamed(context, "uss");
                                //Navigator.push(context, MaterialPageRoute(builder: (context)=>Usersubsub(callback:callback)));
                              }
                            });
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 16.0),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: borderColorList[index], width: 2),
                            borderRadius: BorderRadius.circular(20.0),
                            color: containerColor,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5,right: 15,top: 15,bottom: 15),
                            child: Row(
                              children: [
                                Container(
                                  child: Image(
                                    image: NetworkImage(
                                        "$photos${subscription['image']}"),
                                    errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                      return Container(
                                        height: 55,
                                        width: 55,
                                        decoration: BoxDecoration(
                                          color: Colors.grey[200], // Placeholder background color
                                          borderRadius: BorderRadius.circular(8), // Adjust as needed
                                        ),
                                        child: Icon(
                                          Icons.photo_library, // Placeholder icon, you can use any icon or asset
                                          size: 30,
                                          color: Colors.grey[400],
                                        ),
                                      );
                                    },
                                    height: 90,
                                    width: 90,
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width:MediaQuery.of(context).size.width/2,
                                      child: Text(
                                        "${subscription['subscription_description']}",
                                        softWrap: true,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                        style: GoogleFonts.rubik(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 17,color: textColor),
                                      ),
                                    ),
                                   Row(
                                     crossAxisAlignment: CrossAxisAlignment.end,
                                     children: [
                                       if(subscription['price']=="Free")
                                         Text("${subscription['price']}",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,color: textColor),),
                                       if(subscription['price']!="Free")
                                         Text("\$${subscription['price']}",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,color: textColor),),
                                       Text("/${subscription['days']} Days",style: GoogleFonts.rubik(color: dayColor,fontSize: 10,),)
                                     ],
                                   ),
                                    SizedBox(height: 5,),
                                    if(subscription["ud"]!="Current")
                                      Container(
                                          decoration: BoxDecoration(
                                            color: Colors.amber,
                                            borderRadius: BorderRadius.circular(10), // Set border radius here
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(
                                              subscription["ud"],
                                              style: GoogleFonts.rubik(
                                                  color: Colors.white, fontSize: 15),
                                            ),
                                          )),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height:20),
                Container(
                    width: double.infinity,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        setState(() {
                          if(sub_id!=""||sub_id!=null){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Subsub(callback:callback)));
                            //Navigator.pushNamed(context, "subsub");
                          }
                        });
                      },
                      child: Text(
                        "Continue",
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontSize: 15),
                      ),
                    )),
              ],
            ),
          ):Center(child: Text("All Functionalities are Free to Use",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.green),)),
      bottomNavigationBar: Bottom(),
    );
  }

  void resetBorders() {
    setState(() {
      borderColorList = List.filled(borderColorList.length, Colors.grey);
    });
  }

  sublist(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]=user_id.toString();
    if(type.toString()=="Employer")
      map["user_type"]="Employers";
    if(type.toString()=="User")
      map["user_type"]="Job Seekers";
    print("your map data is ::::: : ::: ${map}");
    var res = await http.post(Uri.parse("$mainurl/subscription_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        setState(() {
          allsub = jsondata["user_skills"];
          current_subscription=jsondata["current_subscription"];
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      print('error');
    }
  }
  // sublist(context) async {
  //   try{
  //     HashMap<String, String> map = HashMap();
  //     map["updte"] = "1";
  //     print("Hello its inside :::::::::::::::::::::::::::::::");
  //     if(type.toString()=="Employer")
  //       map["user_type"]="Employers";
  //     if(type.toString()=="User")
  //       map["user_type"]="Job Seekers";
  //     print("Hello its inside :::::::::::::::::::::::::::::::");
  //     var res = await http.post(Uri.parse("$mainurl/subscription_list.php"),
  //         body: jsonEncode(map));
  //     print(res.body);
  //     dynamic jsondata = jsonDecode(res.body);
  //     print("Mapped:::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::$map");
  //     print("its your subscript list data ::::::::::::::::::::::::::::::::::::::::::::::::: ${jsondata}");
  //
  //     if (res.statusCode == 200) {
  //       if (jsondata["error"] == 0) {
  //         print("hello you are inside the error ::::::::::::::::::::::::::::::::::::::0");
  //         setState(() {
  //           allsub = jsondata["user_skills"];
  //           _isLoading = false;
  //         });
  //       } else {
  //         ScaffoldMessenger.of(context).showSnackBar(
  //           SnackBar(
  //             content: Text("Something went wrong"),
  //             duration: Duration(seconds: 2),
  //             shape:
  //             RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
  //           ),
  //         );
  //       }
  //     } else {
  //       print('Your problem is ::::::::::::::::::::::::::::::::::::::::: ${res.statusCode} && ${res}');
  //     }
  //   }catch(e){
  //     print("Your exception is :::::::::::::::::::::::::::::::::::::::: $e ");
  //   }
  // }


}
