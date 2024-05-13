import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/Userbottom.dart';
import 'package:fac/home/question_cat.dart';
import 'package:fac/home/subb.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/welcome/login.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var con_id;
var c;
var cname="";
var ritesh = "";
var riteshsingh = "";
var mr_navtej="";

class Mainprofile extends StatefulWidget {
  const Mainprofile({super.key});

  @override
  State<Mainprofile> createState() => _MainprofileState();
}

class _MainprofileState extends State<Mainprofile> {
  var name;
  var st;
  var username;
  var ig;
  List<Map<String, dynamic>> jobDataList = [];
  List<Map<String, dynamic>> jobDataListt = [];
  bool _isLoading = true;


  String search = "";
  TextEditingController searchController = TextEditingController();

  void callback_mem(var data){
    setState(() {
      membershipDetails(context);
    });
  }
  @override
  void initState() {
    Fetching(context);
    fetchProfile();
    fetchrec(context);
    super.initState();
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: Color(0xFFfafafd),
        body:  _isLoading
            ? Center(
          child: CircularProgressIndicator(color: Colors.green[700],),
        )
            :RefreshIndicator(
          onRefresh: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Mainprofile()));
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back!",
                            style: GoogleFonts.rubik(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "$username",
                            style: GoogleFonts.rubik(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      if (ig != "")
                        Stack(
                          children: [
                            // Your existing GestureDetector and CircleAvatar
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "wel");
                              },
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.transparent,
                                backgroundImage: NetworkImage("$photo/$ig"),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  foregroundDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (membertype == "Paid")
                              Positioned(
                                top: 0,
                                right: 3,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amberAccent,
                                    border: Border.all(
                                      color: Colors.amber,
                                      // Set your desired border color
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.auto_awesome_outlined,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      if (ig == "")
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(context, "wel");
                              },
                              child: CircleAvatar(
                                radius: 45,
                                backgroundColor: Colors.transparent,
                                backgroundImage: AssetImage("assets/img.png"),
                                child: Container(
                                  height: 100,
                                  width: 100,
                                  foregroundDecoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                      color: Colors.white,
                                      width: 2.0,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            if (membertype == "Paid")
                              Positioned(
                                top: 0,
                                right: 3,
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.amberAccent,
                                    border: Border.all(
                                      color: Colors.amber,
                                      // Set your desired border color
                                      width: 2.0,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.auto_awesome_outlined,
                                    color: Colors.orange,
                                  ),
                                ),
                              ),
                          ],
                        )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
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
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Search a job or position',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
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
                                onPressed: () {
                                  setState(() {
                                    riteshsingh = "${searchController.text}";
                                  });
                                  if (riteshsingh == "") {
                                    print("herei am;");
                                  } else if (riteshsingh != "") {
                                    print("oh no");

                                    Navigator.pushNamed(context, "searched");
                                    searchController.clear();
                                  }
                                },
                                child: Text(
                                  "Search",
                                  style: GoogleFonts.baloo2(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 5),
                            decoration: BoxDecoration(
                              color: Colors.grey[200],
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Container(
                              height: 25,
                              width: 100,
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.green[700],
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.pushNamed(context, "advance");
                                },
                                child: Text(
                                  "Advance",
                                  style: GoogleFonts.baloo2(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                  // Row(
                  //   children: [
                  //     SizedBox(
                  //       width: MediaQuery.of(context).size.width * 0.65,
                  //     ),
                  //     Container(
                  //       decoration: BoxDecoration(
                  //         color: Colors.grey[200],
                  //         borderRadius: BorderRadius.circular(10.0),
                  //       ),
                  //       child: Container(
                  //         height: 25,
                  //         width: 100,
                  //         child: ElevatedButton(
                  //           style: ElevatedButton.styleFrom(
                  //             backgroundColor: Colors.green[700],
                  //             shape: RoundedRectangleBorder(
                  //               borderRadius: BorderRadius.circular(20.0),
                  //             ),
                  //           ),
                  //           onPressed: () {
                  //             Navigator.pushNamed(context, "advance");
                  //           },
                  //           child: Text(
                  //             "Advance",
                  //             style: GoogleFonts.baloo2(color: Colors.white),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Know your strength ",
                            style: GoogleFonts.rubik(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 0),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[700],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                ),
                              ),
                              onPressed: () {
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsScreen()));
                              },
                              child: Text(
                                "Take Test",
                                style: GoogleFonts.baloo2(color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pushNamed(context, "mp");
                    },
                    child: Text(
                      "Featured Jobs",
                      style: GoogleFonts.rubik(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Column(
                    children: [
                      if (jobDataList.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: jobDataList.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> jobData = entry.value;
                              List<Color> colors = [
                                Colors.green,
                                Colors.blue,
                                Colors.pink
                              ];
                              Color containerColor = colors[index % colors.length];
                              return GestureDetector(
                                onTap: () {
                                  print(
                                      "jop_vacancy_id: ${jobData["jop_vacancy_id"]}");
                                  setState(() {
                                    con_id = jobData["jop_vacancy_id"];
                                    cname = name;
                                    c = containerColor;
                                  });
                                  onfeat();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.0),
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
                                          crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                image: DecorationImage(
                                                  image:
                                                  AssetImage("assets/back.png"),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(8.0),
                                                child: Container(
                                                  width: 35,
                                                  height: 35,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(
                                                          "$photo/${jobData["jop_image"]}"),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  jobData["open_position"],
                                                  style: GoogleFonts.rubik(
                                                      fontWeight: FontWeight.w500,
                                                      fontSize: 18,
                                                      color: Colors.white),
                                                ),
                                                SizedBox(height: 2),
                                                Text(
                                                  "$name",
                                                  style: GoogleFonts.rubik(
                                                      fontWeight: FontWeight.w300,
                                                      fontSize: 15,
                                                      color: Colors.white),
                                                )
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
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(jobData["open_position"]),
                                              ),
                                            ),
                                            SizedBox(
                                              width: 10,
                                            ),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(jobData["type"]),
                                              ),
                                            ),
                                            SizedBox(width: 10),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: Colors.white38,
                                                borderRadius:
                                                BorderRadius.circular(10.0),
                                              ),
                                              child: Padding(
                                                padding: const EdgeInsets.all(10.0),
                                                child: Text(jobData["experience"]),
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 30),
                                        Row(
                                          children: [
                                            Text(
                                              jobData["salary"],
                                              style: GoogleFonts.rubik(
                                                  color: Colors.white, fontSize: 15),
                                            ),
                                            SizedBox(
                                              width: 50,
                                            ),
                                            Text(
                                              "${jobData["location"]}," "Australia",
                                              style: GoogleFonts.rubik(
                                                  color: Colors.white, fontSize: 15),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      if(jobDataList.isEmpty)
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
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      //  Navigator.pushNamed(context, "mp");
                    },
                    child: Text(
                      "Recommended Jobs",
                      style: GoogleFonts.rubik(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(height: 20),
                  Column(
                    children: [
                      if(jobDataListt.isNotEmpty)
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: jobDataListt.asMap().entries.map((entry) {
                              int index = entry.key;
                              Map<String, dynamic> jobData = entry.value;
                              List<Color> colors = [
                                Color(0xffe9bcf7),
                                Color(0xfffad9f7),
                                Color(0xfff5c4e4)
                              ];
                              Color containerColor = colors[index % colors.length];
                              return GestureDetector(
                                onTap: () {
                                  print(
                                      "jop_vacancy_id: ${jobData["jop_vacancy_id"]}");
                                  setState(() {
                                    con_id = jobData["jop_vacancy_id"];
                                    cname = name;
                                    c = containerColor;
                                  });
                                  onjob();
                                },
                                child: Container(
                                  margin: EdgeInsets.only(right: 10.0),
                                  width: 165,
                                  decoration: BoxDecoration(
                                    color: containerColor,
                                    borderRadius: BorderRadius.circular(10.0),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        ClipRRect(
                                            borderRadius: BorderRadius.circular(75),
                                            child: Image(
                                              image: NetworkImage(
                                                  "$photo/${jobData["jop_image"]}"),
                                              height: 50,
                                              width: 50,
                                            )
                                        ),
                                        Text(
                                          jobData["open_position"],
                                          style: GoogleFonts.rubik(
                                              fontSize: 15,
                                              fontWeight: FontWeight.w500),
                                          textAlign: TextAlign.center,
                                        ),
                                        Text(
                                          "$name",
                                          style: GoogleFonts.rubik(
                                              color: Colors.blueGrey),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          jobData["salary"],
                                          style: GoogleFonts.rubik(),
                                          textAlign: TextAlign.center,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      if(jobDataListt.isEmpty)
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
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Userbottom(),
      ),
    );
  }

  Widget post(){
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
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
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Know your strength ",
              style: GoogleFonts.rubik(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            Container(
              margin: EdgeInsets.only(top: 0),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsScreen()));
                },
                child: Text(
                  "Take Test",
                  style: GoogleFonts.baloo2(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> Fetching(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/featured_jobs.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    if (res.statusCode == 200) {
      List<dynamic> jobsDynamic = jsondata["jop_vacancy"];
      List<Map<String, dynamic>> jobs =
          List<Map<String, dynamic>>.from(jobsDynamic);

      setState(() {
        jobDataList = jobs;
        name = jsondata["company_name"];
        if (jsondata["country"] != "" || jsondata["country"] != null) {
          st = jsondata["country"];
        } else {
          st = "";
        }
      });
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

  Future<void> fetchrec(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/recommended_jobs.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("ikkkkkkkkkkkkkkkk$map");
    print(jsondata);

    if (res.statusCode == 200) {

        List<dynamic> jobsDynamic = jsondata["jop_vacancy"];
        List<Map<String, dynamic>> jobs =
            List<Map<String, dynamic>>.from(jobsDynamic);
        setState(() {
          jobDataListt = jobs;
          name = jsondata["company_name"];
          if (jsondata["country"] != "" || jsondata["country"] != null) {
            st = jsondata["country"];
          } else {
            st = "";
          }
        });
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

  Future fetchProfile() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id.toString(),
    };

      final response = await http.post(
        Uri.parse('$mainurl/prosnal_info.php'),
        body: jsonEncode(map),
      );
      print(map);
      dynamic jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200) {
        print("okkkkkk");
        setState(() {
          username = jsondata["user_name"];

          if (jsondata["membership_type"] != null ||
              jsondata["membership_type"] !=
                  "") if (jsondata["profile_image"] == "" ||
              jsondata["profile_image"] == null) {
            setState(() {
              ig = "";
            });
          } else {
            setState(() {
              ig = jsondata["profile_image"];
            });
          }

          membertype = jsondata["membership_type"];
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print(membertype);
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          _isLoading = false;

        });
      } else {
        throw Exception("Failed to load profile data");
      }
  }

  Future onjob() async {
    Map<String, String> map = {
      "updte": "1",
      "jop_vacancy_id": con_id,
      "user_id": user_id
    };
    final response = await http.post(
      Uri.parse('$mainurl/recommended_jobs_description.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("nn");
    print(jsondata);
    if (response.statusCode == 200) {
      if (jsondata["error"] == 0) {
        print("okkkkkk");
        ritesh = jsondata["error"].toString();
        Navigator.pushNamed(context, "rjj");
      } else {
        print(jsondata["error"]);
        setState(() {
          ritesh = jsondata["error"].toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
      }
    } else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsondata["Something Went Wrong, Try Again Later."]),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
    }
  }

  Future onfeat() async {
    Map<String, String> map = {
      "updte": "1",
      "jop_vacancy_id": con_id,
      "user_id": user_id
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
      if (jsondata["error"] == 0) {
        print("okkkkkk");
        ritesh = jsondata["error"].toString();
        Navigator.pushNamed(context, "job");
      } else {
        print(jsondata["error"]);
        setState(() {
          ritesh = jsondata["error"].toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
      }
    }else{
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(jsondata["Something Went Wrong, Try Again Later."]),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
    }

  }
}

