import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/subb.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/welcome/login.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:fac/home/mainprofile.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


var op;

class Job extends StatefulWidget {
  const Job({super.key});

  @override
  State<Job> createState() => _JobState();
}

class _JobState extends State<Job> {
  int selectedButtonIndex = 0;
  List<Map<String, dynamic>> jobVacancies = [];
  var sal;
  var loc;
  var type;
  var ex;
  var jd;
  var cd;
  var ey;
  var add;
  var st;
  var iggg;
  var errormsgg="";
  var ee="";
  var check="";
  var xyz="";
  double ratinggg=0.0;
  void callback_mem(var data){
    setState(() {
      membershipDetails(context);
    });
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
  @override
  void initState() {
    onjob();
    selectedButtonIndex = 0;

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (jobVacancies.isNotEmpty && jobVacancies!= null)
              Wrap(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage("assets/back.png"),
                            fit: BoxFit.cover,
                          ),
                          color: c,
                          borderRadius: BorderRadius.circular(35.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Center(
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Color(0xFFEDF9F0),
                                        borderRadius: BorderRadius.circular(75),
                                      ),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(75),
                                        child: Image(
                                          image: NetworkImage("$photo/$iggg"),
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
                                          height: 150,
                                          width: 150,
                                        ),
                                      ),
                                    ),

                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      "$op",
                                      style: GoogleFonts.rubik(
                                          color: Colors.white,
                                          fontSize: 22,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      cname,
                                      style: GoogleFonts.rubik(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                    if(ratinggg>0)
                                      GestureDetector(
                                        onTap: (){
                                          setState(() {
                                            mr_navtej= xyz;
                                            print(mr_navtej);

                                          });
                                          Navigator.pushNamed(context, "sru");
                                        },
                                        child: RatingBarIndicator(
                                          rating: ratinggg,
                                          itemBuilder: (context, index) => Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          itemCount: 5,
                                          itemSize: 25,
                                          direction: Axis.horizontal,
                                        ),
                                      ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(13.0),
                                      child: Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(op),
                                            ),
                                          ),
                                          Spacer(
                                            flex: 3,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(type),
                                            ),
                                          ),
                                          Spacer(
                                            flex: 3,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white38,
                                              borderRadius:
                                              BorderRadius.circular(10.0),
                                            ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Text(ex),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: 15),
                                    Row(
                                      children: [
                                        Text(
                                          sal,
                                          style: GoogleFonts.rubik(
                                              color: Colors.white, fontSize: 17),
                                        ),
                                        Spacer(
                                          flex: 2,
                                        ),
                                        Text(
                                          "$st," "Australia",
                                          style: GoogleFonts.rubik(
                                              color: Colors.white, fontSize: 17),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          elevation: 0.0,
                          leading: IconButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      buildTextButton(0, "Description"),
                      Spacer(
                        flex: 3,
                      ),
                      buildTextButton(1, "Requirements"),
                      Spacer(
                        flex: 3,
                      ),
                      buildTextButton(2, "About"),
                    ],
                  ),
                  IndexedStack(
                    index: selectedButtonIndex,
                    children: [
                      buildContainerForIndex(0),
                      buildContainerForIndex(1),
                      buildContainerForIndex(2),
                    ],
                  ),

                ],
              ),
            if (errormsgg=="Please Purchase Subscription")
              Column(
                children: [
                  SizedBox(height: 150),
                  Center(
                    child: Container(
                      padding: EdgeInsets.all(25),
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
                      child: Column(
                        children: [
                          Image(image: AssetImage("assets/error.png")),
                          Text(
                            "$errormsgg",
                            style: GoogleFonts.rubik(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
          ],
        ),
      ),
      bottomNavigationBar:
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF118743),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              if(check=="No")
              {
                if (errormsgg=="Please Purchase Subscription")
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                if (jobVacancies.isNotEmpty && jobVacancies!= null)
                  Navigator.pushNamed(context, "ja");
              }else if(check=="Yes"){

              }
            },
            child: Text(
              check == "Yes" ? "Already Applied" : "Next",
              style: GoogleFonts.baloo2(color: Colors.white,fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }

  TextButton buildTextButton(int index, String text) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedButtonIndex = index;
        });
        if (selectedButtonIndex == 1) {
        } else if (selectedButtonIndex == 2) {}
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedButtonIndex == index ? c : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            text,
            style: GoogleFonts.rubik(
              fontSize: 15,
              color: selectedButtonIndex == index ? c : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainerForIndex(int index) {
    // print("dl2: $dl");
    // print("pp2: $pp");
    // print("bc2: $bc");

    switch (index) {
      case 0:
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.black,
                            size: 10.0,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "Job Position: $op",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.black,
                            size: 10.0,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "Salary: $sal",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.black,
                            size: 10.0,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "Company Location: $loc",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.black,
                            size: 10.0,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "Job Type: $type",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: 10,),
                RichText(
                  text: TextSpan(
                    children: [
                      WidgetSpan(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Icon(
                            Icons.brightness_1,
                            color: Colors.black,
                            size: 10.0,
                          ),
                        ),
                      ),
                      TextSpan(
                        text: "Company Description: $cd",
                        style: TextStyle(
                          fontSize: 17.0,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10,),

              ],
            ),
          ),
        );
      case 1:
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                for (var vacancy in jobVacancies)
                  Container(
                    margin: EdgeInsets.only(bottom: 16.0),
                    child: RichText(
                      text: TextSpan(
                        children: [
                          WidgetSpan(
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.brightness_1,
                                color: Colors.black,
                                size: 10.0,
                              ),
                            ),
                          ),
                          TextSpan(
                            text: "Requirement: ${vacancy["requirements"]}",
                            style: TextStyle(
                              fontSize: 17.0,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

              ],
            ),
          ),
        );

      case 2:
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 4,
                  blurRadius: 2,
                ),
              ],
            ),
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Text(cd),
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Future onjob() async {
    Map<String, String> map = {
      "updte": "1",
      "jop_vacancy_id": con_id,
      "user_id":user_id
    };
    final response = await http.post(
      Uri.parse('$mainurl/featured_jobs_description.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("nn");
    print(jsondata);
      if (response.statusCode == 200) {
        print("okkkkkk");
        setState(() {
          op = jsondata["open_position"];
          sal = jsondata["salary"];
          loc = jsondata["location"];
          type = jsondata["type"];
          ex = jsondata["experience"];
          jd = jsondata["job_description"];
          cd = jsondata["company_description"];
          ey = jsondata["established_year"];
          add = jsondata["address"];
          st = jsondata["country"];
          iggg=jsondata["jop_image"];
          check=jsondata["applied"];
          xyz=jsondata["employer_id"];
          ratinggg = jsondata["rating"].toDouble();




          if (jsondata["rows"] != 0 && jsondata["jop_vacancy"] != null) {
            jobVacancies = List<Map<String, dynamic>>.from(jsondata["jop_vacancy"]);
          }

        });
        ee=jsondata["error"];
      }
      else {
        print(jsondata["error"]);
        setState(() {
          errormsgg = jsondata["error_msg"];
          ee=jsondata["error"];
        });
      }
  }
}
