import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/post_chat.dart';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var lovee="";
var ccnamee="";
var ccemaile="";
var cclogoe="";
var riteshsinghh="";


bool ih=false;



class Messages extends StatefulWidget {
  const Messages({super.key});

  @override
  State<Messages> createState() => _MessagesState();
}

class _MessagesState extends State<Messages> {

  List<dynamic> peoplist = [];
  List<dynamic> postPeoplist = [];
  List tabs =[
    "Vacancy Chat",
    "Post Chat"
  ];
  var selected = 0;

  String search = "";
  TextEditingController searchController = TextEditingController();
  Timer? timers;
  Timer? timersPost;
  var oherror="";

  @override
  void initState() {
   Fetch();
   timers = Timer.periodic(Duration(seconds:8 ), (timer) {
     Fetch();
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
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Message",style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: Navigator.canPop(context)?GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            setState(() {

            });
            if(Navigator.canPop(context))
              Navigator.pop(context);
          } ,
        ):Container() ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      cursorColor: Color(0xFF118743),
                      onChanged: (text) {
                        setState(() {
                          search = text;
                        });
                      },
                      //controller: textEditingController,
                      //focusNode: focusNode,
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey[200],
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20.0),
                            borderSide: BorderSide.none,
                          ),
                          hintText: 'Name or Email to find..',
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey,

                          )),

                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(
                          10.0),
                    ),
                    child: Container(
                      height: 50,
                      width: 100,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green[700],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        ),
                        onPressed: () async {
                          setState(() {
                            riteshsinghh="${searchController.text}";
                          });

                          await Future.delayed(Duration.zero);

                          if (riteshsinghh == "") {
                              print("here I am;");
                            } else if (riteshsinghh != "") {
                              print("oh no");
                              seachhh();
                            }

                        },
                        child: Text(
                          "Search",
                          style: GoogleFonts.baloo2(color: Colors.white),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(height: 20,),
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
              SizedBox(height: 20,),
              if(selected == 0)
                vacancyChat(),
              if(selected == 1)
                for (var ohmsg in postPeoplist)
                  postChat(ohmsg,context)

            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
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
  Widget vacancyChat(){
    return Column(
      children: [
        if(oherror=="0")
          for (var ohmsg in peoplist)
            peopleContainer(ohmsg, context),
        if(oherror=="1")
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
              child: Text(
                "Nothing Yet",
                style: GoogleFonts.rubik(
                  color: Colors.grey,
                  fontWeight: FontWeight.w400,
                  fontSize: 20,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
  Widget postChat(dynamic ohmsg, BuildContext context){
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
        Navigator.push(context, MaterialPageRoute(builder: (context)=>PostChat(jobPostId: ohmsg["job_seeker_post_id"], name: ohmsg["user_name"], emp: null, profile: ohmsg["profile_img"],isEmployer: true,)));
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
                        image: NetworkImage("$photo/${ohmsg["profile_img"]}"),
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
                        if(ohmsg["user_name"] != null)
                          Text(
                            ohmsg["user_name"],
                            style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 14),
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
  Fetch() async {
  HashMap<String, String> map = HashMap();
  map["updte"] = "1";
  map["user_id"] = user_id;
  print("helllo ${map}");
  var res = await http.post(
      Uri.parse("$mainurl/people_applied_jops_list.php"),
      body: jsonEncode(map));

  print(res.body);
  dynamic jsondata = jsonDecode(res.body);
  print("Mapped::::::$map");
  print(jsondata);

  if (res.statusCode == 200) {
    if (jsondata["error"] == 0) {
      if(jsondata["rows"]!=null||jsondata["rows"]!=0) {
        setState(() {
          peoplist = jsondata["people_jop_applied_list"];
          oherror="0";
        });
        print(peoplist);
      }
    } else {
      setState(() {
        oherror="1";
      });
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

      //print("::::::::::::::::::::::::::::::::      ::::::::::::::::::::::::: ${userer}");
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

  seachhh() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["search"]= searchController.text;

    var res = await http.post(
        Uri.parse("$mainurl/people_applied_jops_list_search.php"),
        body: jsonEncode(map));

    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        
        if(jsondata["rows"]!=null||jsondata["rows"]!=0) {
          setState(() {
            peoplist.clear();
            peoplist = jsondata["people_jop_applied_list"];
          });


        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No data found"),
            duration: Duration(seconds: 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)),
          ),
        );
        setState(() {
          peoplist = [];

        });
        Navigator.pushNamed(context, "msg");
      }
    } else {
      print('Error: ${res.statusCode}');
    }
  }


  Widget peopleContainer(dynamic ohmsg, BuildContext context) {

    print("oooooo");

    return GestureDetector(
      onTap: (){
       setState(() {
         print("hello its fetch api :::::::::::::::::::::::::::::::::::::::::::::::::::::");
         Fetch();
       });
        Navigator.pushNamed(context, "msgg");
        setState(() {
           lovee=ohmsg["user_apply_jop_id"];
           ccnamee=ohmsg["name"];
           ccemaile=ohmsg["confirm_email"];
           cclogoe=ohmsg["profile_img"];
          // Fetch();
        });

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
                 if(ohmsg["profile_img"]!="")
                   Container(
                     child: ClipRRect(
                       borderRadius: BorderRadius.circular(50),
                       child: Image(
                         image: NetworkImage("$photo/${ohmsg["profile_img"]}"),
                         height: 65,
                         width: 65,
                         fit: BoxFit.cover,
                       ),
                     ),
                   ),
                  if(ohmsg["profile_img"]=="")
                    Container(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage("assets/pers.png"),
                          height: 65,
                          width: 65,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  SizedBox(
                    width: 15,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (ohmsg["name"] != null)
                        Text(
                          ohmsg["name"],
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w500, fontSize: 13),
                        ),
                      if(ohmsg["confirm_email"] != null)
                        Text(
                          ohmsg["confirm_email"],
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w300, fontSize: 11),
                        ),
                      if(ohmsg["city"] != null||ohmsg["location"] != null)
                        Text(
                          "${ohmsg["city"]},${ohmsg["location"]}",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w300, fontSize: 11),
                        ),
                      Row(
                        children: [
                          Text("For: ",style: GoogleFonts.rubik(fontSize: 11),),
                          Text(
                            ohmsg["open_position"],
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w500, fontSize: 11,),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(flex: 2,),
                  if(ohmsg["messages"]!="0")
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
                        ohmsg["messages"],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                        textAlign: TextAlign.center,
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

}
