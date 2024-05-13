import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/post_chat.dart';
import 'package:fac/home/Userbottom.dart';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

var love="";
var ccname="";
var ccemail="";
var ccstatus="";
var cclogo="";
var userer="";
var job_id="";
var empp_id="";

class Usermsg extends StatefulWidget {
  const Usermsg({Key? key}) : super(key: key);

  @override
  State<Usermsg> createState() => _UsermsgState();
}

class _UsermsgState extends State<Usermsg> {
  List<dynamic> peoplist = [];
  List<dynamic> postPeoplist = [];
  Color textColor = Colors.black;
  List tabs =[
    "Vacancy Chat",
    "Post Chat"
  ];
  var selected = 0;

  Timer? timers;
  Timer? timersPost;

  @override
  void initState() {
    Fetchdata();
    clearall();
    timers = Timer.periodic(Duration(seconds:5 ), (timer) {
      Fetchdata();
    });

    super.initState();
  }
  @override
  void deactivate() {
    timers?.cancel();
    timersPost?.cancel();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,

      child: Scaffold(
        backgroundColor: Color(0xFFfafafd),
        appBar: AppBar(
          leading:Navigator.canPop(context)?IconButton(
            onPressed: () {
              if(Navigator.canPop(context))
                Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ):Container(),
          centerTitle: true,
          title: Text("Job Status", style: GoogleFonts.rubik()),
        ),
        body: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      for(int i =0;i<2;i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: tab(tabs[i], i),
                        )
                      // SizedBox(
                      //   width: 10,
                      // ),
                      // tab("Mental Health Test", 2),
                    ],
                  ),
                ),
              ],
            ),
            //SizedBox(height: 10,),
            if(selected == 0)
              companies(),
            if(selected == 1)
              postComp()
          ],
        ),

        bottomNavigationBar: Userbottom(),
      ),
    );
  }
  Widget tab(var text , var index){
    return InkWell(
      onTap: (){
        setState(() {
          selected=index;
          if(index == 0){
            timersPost?.cancel();
          }else{
            FetchPost();
            timersPost = Timer.periodic(Duration(seconds:5 ), (timer) {
              FetchPost();
            });
            timers?.cancel();
          }
        });
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border:Border.all(width: 1,color: index!=selected?Colors.black12:Colors.transparent),
          gradient:  index==selected?LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.green.shade800,
              Color(0xFF6E9677),
            ],
          ):LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomLeft,
            colors: [
              Colors.transparent,
              Colors.transparent,
            ],
          ),

        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Text(text,style: TextStyle(fontSize: 16,fontWeight: index==selected?FontWeight.w500:FontWeight.w400,color: index==selected?Colors.white:Colors.black54),),
        ),
      ),
    );
  }
  Widget companies(){
    return userer=="1"?Center(child: Text("No Job Applied Yet!")):Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if(userer=="0")
                Text("Companies",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500, fontSize: 17,color: Colors.black)),
              SizedBox(
                height: 20,
              ),
              for (var ohmsg in peoplist)
                peopleContainer(ohmsg, context),
            ],
          ),
        ),
      ),
    );
  }
  Widget postComp(){
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                Text("Companies",
                    style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500, fontSize: 17,color: Colors.black)),
              SizedBox(
                height: 20,
              ),
              for (var ohmsg in postPeoplist)
                postList(ohmsg, context),
            ],
          ),
        ),
      ),
    );
  }
  Fetchdata() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(
        Uri.parse("$mainurl/user_applied_jop_list.php"),
        body: jsonEncode(map));

    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      setState(() {
        userer=jsondata["error"].toString();
      });

      print("::::::::::::::::::::::::::::::::      ::::::::::::::::::::::::: ${userer}");
      if (jsondata["error"] == 0) {
        if (jsondata["user_applied_jop"] != null) {
          setState(() {
            peoplist = jsondata["user_applied_jop"];
          });
        }
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("You have applied no-where yet"),
        //     duration: Duration(seconds: 2),
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(40)),
        //   ),
        // );
        // Future.delayed(Duration(seconds: 1),(){
        //  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
        //  // Navigator.pop(context);
        // });

      }
    } else {
      print('Error: ${res.statusCode}');
    }
  }
  FetchPost() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(
        Uri.parse("$mainurl/job_seeker_messages_list.php"),
        body: jsonEncode(map));

    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {

      print("::::::::::::::::::::::::::::::::      ::::::::::::::::::::::::: ${userer}");
      if (jsondata["error"] == 0) {
        if (jsondata["user_applied_jop"] != null) {
          setState(() {
            postPeoplist = jsondata["user_applied_jop"];
          });
        }
      } else {
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(
        //     content: Text("You have applied no-where yet"),
        //     duration: Duration(seconds: 2),
        //     shape: RoundedRectangleBorder(
        //         borderRadius: BorderRadius.circular(40)),
        //   ),
        // );
        // Future.delayed(Duration(seconds: 1),(){
        //  // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
        //  // Navigator.pop(context);
        // });

      }
    } else {
      print('Error: ${res.statusCode}');
    }
  }

  Widget peopleContainer(dynamic ohmsg, BuildContext context) {
    double ratingggg = ohmsg["rating"].toDouble();

    if(ohmsg["status"]=="Selected"){
      setState(() {
        textColor=Colors.green;
      });
    }
    if(ohmsg["status"]=="Rejected"){
      setState(() {
        textColor=Colors.red;
      });
    }
    if(ohmsg["status"]=="Applied"){
      setState(() {
        textColor=Colors.grey;
      });
    } if(ohmsg["status"]=="Interview"){
      setState(() {
        textColor=Colors.blueAccent;
      });
    }if(ohmsg["status"]=="Shortlisted"){
      setState(() {
        textColor=Colors.amber;
      });
    }
    print("oooooo");

    if (peoplist.isEmpty || userer == "1") {
      print("Displaying 'Nothing Yet'");
      return Container(
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
        child: Text("Nothing Yet",style:GoogleFonts.rubik(),textAlign:TextAlign.center,),
      );
    }

    return GestureDetector(
      onTap: (){
        //Navigator.pushNamed(context, "usermain");

        setState(() {
          love=ohmsg["user_apply_jop_id"];
          ccname=ohmsg["company_name"];
          ccemail=ohmsg["email_id"];
          ccstatus=ohmsg["status"];
          cclogo=ohmsg["company_logo"];
          con_id=ohmsg["jop_vacancy_id"];
          cname=ohmsg["company_name"];
          c = Colors.greenAccent.shade200;
        });
        Navigator.pushNamed(context, "rjj");
        print("*");
        print(love);
        print("*");


      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
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
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: NetworkImage("$photo/${ohmsg["company_logo"]}"),
                        height: 65,
                        width: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/3,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(ohmsg["open_position"] != null)
                          Text(
                            ohmsg["open_position"],
                            style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 12),
                          ),
                        SizedBox(height: 2),
                        if(ratingggg>0)
                          RatingBarIndicator(
                            rating: ratingggg,
                            itemBuilder: (context, index) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 15,
                            direction: Axis.horizontal,
                          ),
                        if (ohmsg["company_name"] != null)
                          Text(
                            ohmsg["company_name"],
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w500, fontSize: 11),
                          ),
                        SizedBox(height: 2),
                        if(ohmsg["email_id"] != null)
                          Text(
                            ohmsg["email_id"],
                            style: GoogleFonts.rubik(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2,),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 2,),
                          Row(
                            children: [
                              if(ohmsg["total_messages"]!="0")
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    ohmsg["total_messages"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              if(ohmsg["rating"]==0)
                                if(ohmsg["status"]=="Selected"||ohmsg["status"]=="Rejected")
                                  GestureDetector(
                                    onTap: (){
                                      setState(() {
                                        job_id=ohmsg["jop_vacancy_id"];
                                        empp_id=ohmsg["employer_id"];
                                      });
                                      Navigator.pushNamed(context, "ratingsinuser");
                                      print("=======>>>");

                                    },
                                    child: Container(
                                      margin: EdgeInsets.all(5),
                                      child: Icon(Icons.star_border,color: Colors.yellow,),
                                    ),
                                  ),
                            ],
                          ),
                        SizedBox(height: 2,),
                        Text( ohmsg["status"],
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w500, fontSize: 12,color: textColor),),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget postList(dynamic ohmsg, BuildContext context) {
    if (postPeoplist.isEmpty) {
      print("Displaying 'Nothing Yet'");
      return Container(
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
        child: Text("Nothing Yet",style:GoogleFonts.rubik(),textAlign:TextAlign.center,),
      );
    }

    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostChat(jobPostId: ohmsg["job_seeker_post_id"], name: ohmsg["company_name"], emp: null, profile: ohmsg["company_logo"],isEmployer: false,)));
        //Navigator.pushNamed(context, "usermain");
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
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
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: NetworkImage("$photo/${ohmsg["company_logo"]}"),
                        height: 65,
                        width: 65,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width/2.6,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if(ohmsg["company_name"] != null)
                          Text(
                            ohmsg["company_name"],
                            style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 14),
                          ),
                        if (ohmsg["company_user_name"] != null)
                          Text(
                            ohmsg["company_user_name"],
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w500, fontSize: 12),
                          ),
                        SizedBox(height: 2),
                        if(ohmsg["company_email_id"] != null)
                          Text(
                            ohmsg["company_email_id"],
                            style: GoogleFonts.rubik(fontSize: 12),
                          ),
                      ],
                    ),
                  ),
                  Spacer(flex: 2,),
                  Container(
                    child: Column(
                      children: [
                        SizedBox(height: 2,),
                          Row(
                            children: [
                              if(ohmsg["total_messages"]!="0")
                                Container(
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  constraints: BoxConstraints(
                                    minWidth: 16,
                                    minHeight: 16,
                                  ),
                                  child: Text(
                                    ohmsg["total_messages"],
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 10,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                            ],
                          ),
                        SizedBox(height: 2,),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
  Future clearall() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id":user_id,
    };
    final response = await http.post(
      Uri.parse('$mainurl/read_notification.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("nn");
    print(jsondata);

      if (jsondata["error"] ==0) {
        print("okkkkkk");

        print("okkkkkk");
      }
      else {
        print(jsondata["error"]);
      }

  }

}

