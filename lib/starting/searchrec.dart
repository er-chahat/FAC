import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/subb.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/welcome/login.dart';
import 'package:http/http.dart'as http;
import 'package:fac/home/mainprofile.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Searchrec extends StatefulWidget {
  const Searchrec({super.key});

  @override
  State<Searchrec> createState() => _SearchrecState();
}

class _SearchrecState extends State<Searchrec> {
  List<Widget> jobWidgets = [];
  List<Color> colors = [Color(0xffd1b3ff), Color(0xffdf9fdf), Color(0xffff99cc)];
  int colorIndex = 0;
  void callback_mem(var data){
    setState(() {
      membershipDetails(context);
    });
  }

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
        title: Text("Recommended Jobs", style: GoogleFonts.rubik()),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => Searchrec()));
          },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: jobWidgets,
            ),
          ),
        ),
      ),
    );
  }

  searchhere(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["search"] = riteshsingh.toString();



    var res = await http.post(Uri.parse("$mainurl/search_job.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          jobWidgets = jsondata["jop_vacancy"].map<Widget>((jobData) {
            colorIndex = (colorIndex + 1) % colors.length;
            return buildJobWidget(jobData, colors[colorIndex]);
          }).toList();
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No Jobs Related to your search"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        Future.delayed(Duration(seconds: 2),(){
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
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
  }

  Widget buildJobWidget(Map<String, dynamic> jobData,Color containerColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          con_id = jobData["jop_vacancy_id"];
          cname = jobData["company_name"];
          c = containerColor;
        });
        ohhh();
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: containerColor,
          image: DecorationImage(
            image: AssetImage("assets/back.png"),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      image: DecorationImage(
                        image: AssetImage("assets/back.png"),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(
                          10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 35,
                        height: 35,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("$photo/${jobData["jop_image"]}"),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(jobData["open_position"],style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 18,color: Colors.white),),
                      SizedBox(height: 2),
                      Text(jobData["company_name"],style: GoogleFonts.rubik(fontWeight: FontWeight.w300,fontSize: 15,color: Colors.white),)

                    ],
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(
                          10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(jobData["open_position"],style: GoogleFonts.rubik(fontSize: 12),),
                    ),
                  ),
                  Spacer(flex: 3,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(
                          10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(jobData["type"],style: GoogleFonts.rubik(fontSize: 12),),
                    ),
                  ),
                  Spacer(flex: 3,),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white38,
                      borderRadius: BorderRadius.circular(
                          10.0),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text(jobData["experience"],style: GoogleFonts.rubik(fontSize: 12),),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                children: [
                  Text(jobData["salary"],style: GoogleFonts.rubik(color: Colors.white,fontSize: 15),),
                  Spacer(flex: 2,),
                  Text("${jobData["location"]},""Australia",style: GoogleFonts.rubik(color: Colors.white,fontSize: 15),)

                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Future ohhh() async {
    Map<String, String> map = {
      "updte": "1",
      "jop_vacancy_id": con_id,
      "user_id":user_id
    };
    final response = await http.post(
      Uri.parse('$mainurl/recommended_jobs_description.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("nn");
    print(jsondata);
    try {
      if (jsondata["error"] ==0) {
        print("okkkkkk");
        ritesh=jsondata["error"].toString();
        Navigator.pushNamed(context, "rjj");
      }
      else {
        print(jsondata["error"]);
        setState(() {
          ritesh=jsondata["error"].toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback: callback_mem)));
      }
    } catch (e) {
      print('Error while fetching profile: $e');

    }
  }

  Future<void> membershipDetails(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/prosnal_info.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          membertype=jsondata["membership_type"];
        });
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

}



