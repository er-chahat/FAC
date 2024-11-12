import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/bottom.dart';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/employeer/emphome.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../home/de.dart';
class Empss extends StatefulWidget {
  const Empss({super.key});

  @override
  State<Empss> createState() => _EmpssState();
}

class _EmpssState extends State<Empss> {


  var rowww="";
  List<dynamic> peoplist = [];

  @override
  void initState() {
    searchhere(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Recommended List", style: GoogleFonts.rubik()),
      ),
      body: ListView.builder(
        itemCount: peoplist.length,
        itemBuilder: (context, index) {
          return peopleContainer(peoplist[index], context);
        },
      ),
      bottomNavigationBar: Bottom(),
    );
  }
  searchhere(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["search"] = riteshsinghh.toString();



    var res = await http.post(Uri.parse("$mainurl/search_job_employer.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        rowww=jsondata["rows"].toString();

        if(jsondata["row"]!=null||jsondata["rows"]!=0) {
          setState(() {
            peoplist = jsondata["jop_vacancy"];
          });
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

}
Widget peopleContainer(dynamic peoplist, BuildContext context) {
  return Container(
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

                child:ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image(
                      image: NetworkImage("$photo/${peoplist["profile_img"]}"),
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
                      height: 65,width: 65,fit: BoxFit.cover,)),

              ),
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("${peoplist["user_name"] ?? ""}",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 15),)),

                  Container(
                      width: MediaQuery.of(context).size.width/2,
                      child: Text("Skill: ${peoplist["skills"] ?? ""}",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 13),)),


                ],
              ),
              Spacer(flex: 2,),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, "applicants");
                  iid=peoplist["user_id"];
                  iddname=peoplist["user_name"];
                  iddem=peoplist["email_id"];
                  iddimg=peoplist["profile_img"];

                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xFFEDF9F0),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: IconButton(onPressed: (){
                    Navigator.pushNamed(context, "applicants");
                    iid=peoplist["user_id"];
                    iddname=peoplist["user_name"];
                    iddem=peoplist["email_id"];
                    iddimg=peoplist["profile_img"];

                  }, icon: Icon(Icons.mail,color: Colors.green,),),
                ),
              )
            ],
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Container(
                  width:MediaQuery.of(context).size.width * 0.35 ,
                  height: 35,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                          side: BorderSide.none,)),
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>De(cate: "",user_id: "",)));
                       //Navigator.pushNamed(context, "de");
                       iid=peoplist["user_id"];
                    },
                    child: Text(
                      "See Details",
                      style: GoogleFonts.rubik(
                          color: Color(0xFF118743), fontSize: 15),
                    ),
                  )),
            ],
          )
        ],
      ),
    ),
  );
}

