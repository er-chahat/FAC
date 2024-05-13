import 'dart:collection';
import 'dart:convert';

import 'package:fac/employeer/subscription.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class DeTalent extends StatefulWidget {
  String user_id;
  DeTalent({required this.user_id});

  @override
  State<DeTalent> createState() => _DeTalentState();
}

class _DeTalentState extends State<DeTalent> {
  var errormsgg = "";
  var name = "";
  var user_education;
  var user_port;
  var email = "";
  var no = "";
  var add = "";
  var con = "";
  var ab = "";
  var gg = "";
  var cl="";
  double ratinggg=0.0;
  bool _isLoading = true;
  var membert="";
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
          membert=jsondata["membership_type"];
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


  List<Map<String, dynamic>> userSkills = [];

  @override
  void initState() {
    viewdetails(context);
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
        title: Text("Details", style: GoogleFonts.rubik()),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  if (gg != "")
                    Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            image: NetworkImage("$photo/$gg"),
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover,
                          )),
                    ),
                  if (gg == "")
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage("assets/person.png"),
                          height: 65,
                          width: 65,
                          fit: BoxFit.cover,
                        )),
                  SizedBox(
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500, fontSize: 15),
                      ),
                      Text(
                        email,
                        style:
                        GoogleFonts.rubik(color: Colors.grey, fontSize: 13),
                      ),
                      GestureDetector(
                        onTap: (){
                          Navigator.pushNamed(context, "sre");
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
                    ],
                  ),

                ],
              ),
              SizedBox(
                height: 10,
              ),
              Divider(),
              SizedBox(
                height: 10,
              ),
              if (userSkills != null && userSkills.isNotEmpty)
                Column(
                  children: [
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Personal Information",
                                style:
                                GoogleFonts.rubik(fontWeight: FontWeight.w500)),
                            SizedBox(height: 15),
                            Row(
                              children: [
                                Icon(
                                  Icons.person,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 20),
                                Text("$name")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 20),
                                Text("$no")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.mail,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 20),
                                Text("$email")
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            if(add!="")
                              Row(
                                children: [
                                  Icon(
                                    Icons.home_outlined,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 20),
                                  Text("$add")
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Education",
                                style:
                                GoogleFonts.rubik(fontWeight: FontWeight.w500)),
                            SizedBox(height: 15),
                            user_education==null?Center(child: Text("No Data Found")):Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text("Univesity :"),
                                    SizedBox(width: 20),
                                    Expanded(child: Text("${user_education[0]["university_Institute_name"]}",softWrap: true,overflow: TextOverflow.ellipsis,))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Degree :"),
                                    SizedBox(width: 20),
                                    Expanded(child: Text("${user_education[0]["degree"]}",softWrap: true,overflow: TextOverflow.ellipsis,))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: [
                                    Text("Course :"),
                                    SizedBox(width: 20),
                                    Expanded(child: Text("${user_education[0]["course"]}",softWrap: true,overflow: TextOverflow.ellipsis,))
                                  ],
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Portfolio",
                                style:
                                GoogleFonts.rubik(fontWeight: FontWeight.w500)),
                            SizedBox(height: 15),
                            user_port==null?Center(child: Text("No Data Found")):Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                for(int i=0;i<user_port.length;i++)
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.0),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey.withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                ),
                                              ],
                                              color: Colors.white,
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.stretch,
                                              children: [
                                                Expanded(
                                                  child: Image.network(
                                                    "$photo/${user_port[i]["portfolio_image"]}",
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("${user_port[i]["portfolio_title"]}"),
                                            SizedBox(width: 20),
                                            Container(
                                              width: MediaQuery.of(context).size.width/1.8,
                                                child: Text("${user_port[i]["portfolio_description"]}",softWrap: true,overflow: TextOverflow.ellipsis,maxLines: 2,))
                                          ],
                                        ),

                                      ],
                                    ),
                                  ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
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
                        padding: const EdgeInsets.all(20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("My Skills",
                                    style: GoogleFonts.rubik(
                                        fontWeight: FontWeight.w500)),
                              ],
                            ),
                            SizedBox(height: 20),
                            if (userSkills != null && userSkills.isNotEmpty)
                              Wrap(
                                spacing: 20.0,
                                runSpacing: 16.0,
                                children: List.generate(
                                  (userSkills.length / 2).ceil(),
                                      (index) {
                                    int startIndex = index * 2;
                                    int endIndex = (index + 1) * 2;
                                    endIndex = endIndex > userSkills.length
                                        ? userSkills.length
                                        : endIndex;

                                    return Row(
                                      children: [
                                        ...userSkills
                                            .sublist(startIndex, endIndex)
                                            .map(
                                              (skill) => Stack(
                                            clipBehavior: Clip.none,
                                            children: [
                                              Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                    0.34,
                                                padding: EdgeInsets.all(8),
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                  BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                    ),
                                                  ],
                                                  color: Colors.white38,
                                                ),
                                                child: Text(skill["skills"],
                                                  textAlign: TextAlign.center,softWrap: true,overflow: TextOverflow.ellipsis,),
                                              ),
                                              Positioned(
                                                top: -10,
                                                right: 3,
                                                child: Container(
                                                  padding: EdgeInsets.only(
                                                      left: 7,
                                                      right: 7,
                                                      top: 2,
                                                      bottom: 2),
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                    BorderRadius.circular(5),
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                    color: Color(0xFF118743),
                                                  ),
                                                  child: Text(
                                                    skill["experience"],
                                                    style: GoogleFonts.rubik(
                                                        color: Colors.white,
                                                        fontSize: 8),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                            .expand((widget) => [
                                          widget,
                                          SizedBox(width: 20),
                                        ]),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            if (userSkills == null && userSkills.isEmpty)
                              Text(
                                "No Data",
                                style: GoogleFonts.rubik(),
                                textAlign: TextAlign.center,
                              )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(cl!="")
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
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Cover Letter",
                                  style:
                                  GoogleFonts.rubik(fontWeight: FontWeight.w500)),
                              SizedBox(height: 15),
                              Text(
                                "$cl",
                                style: GoogleFonts.rubik(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                    SizedBox(
                      height: 20,
                    ),
                    if(ab!="")
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
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("About",
                                  style:
                                  GoogleFonts.rubik(fontWeight: FontWeight.w500)),
                              SizedBox(height: 15),
                              Text(
                                "$ab",
                                style: GoogleFonts.rubik(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              if (userSkills == null || userSkills.isEmpty)
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
                        Text(
                          "No data Found",
                          style: GoogleFonts.rubik(
                              color: Colors.black,
                              fontSize: 17,
                              fontWeight: FontWeight.w400),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  viewdetails(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = widget.user_id;
    print("helllo ::::::::::::::::::::::::::::::::::::::::::::::::::::       $map");

    var res = await http.post(
        Uri.parse("$mainurl/user_details_show.php"),
        body: jsonEncode(map));
    print(res.body);
    print("helllo ::::::::::::::::::::::::::::::::::::::::::::::::::::       $map");
    dynamic jsondata = jsonDecode(res.body);
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          name = jsondata["user_name"]??"No data";
          email = jsondata["email_id"]??"No data";
          no = jsondata["mobile_number"]??"No data";
          add = jsondata["address"]??"No data";
          con = jsondata["country"]??"No data";
          ab = jsondata["about_me"]??"No data";
          gg = jsondata["profile_img"]??"No data";
          cl=jsondata["cover_later"]??"No data";

          ratinggg = jsondata["rating"].toDouble();

          if (jsondata['user_skills'] != null) {
            List<Map<String, dynamic>> skills =
            List<Map<String, dynamic>>.from(jsondata['user_skills']);
            setState(() {
              userSkills = skills;
            });
          }
          if (jsondata['user_education'] != null) {
            setState(() {
              user_education = jsondata['user_education'];
            });
          }
          if (jsondata['user_portfolio'] != null) {
            setState(() {
              user_port = jsondata['user_portfolio'];
            });
          }
          _isLoading=false;
        });
        errormsgg = jsondata["error_msg"];
      } else {
        setState(() {
          errormsgg = jsondata["error_msg"];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription(callback: callback_mem)));
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
