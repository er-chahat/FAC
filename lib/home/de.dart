import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/home/detailed_result.dart';
import 'package:fac/home/result.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/emphome.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

class De extends StatefulWidget {
  var cate;
  var user_id;
  De({required this.cate,required this.user_id});

  @override
  State<De> createState() => _DeState();
}

class _DeState extends State<De> {
  var errormsgg = "";
  var name = "";
  var user_education;
  var user_port;
  var result;
  var email = "";
  var no = "";
  var add = "";
  var con = "";
  var ab = "";
  var gg = "";
  var recent_data;
  var test_score;
  var cl="";
  double ratinggg=0.0;
  bool _isLoading = true;



  var membert="";
  Future _getresult() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/test_percentage.php");

      Map mapdata = {
        "updte":"1",
        "user_id": widget.user_id,
        "category_id":widget.cate,
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");
      print("your data 2 mesg data is : wertyuio HIIIIIIIIIIIIIIIII$data");
      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIII");
        if(data["error"]==0){
          setState(() {
            result=data;
            // percent = total/atmpt;
          });
          return  data;
        }else{
          setState(() {
            result=[];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("${data["error_msg"]}"),
              duration: Duration(seconds: 2 ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      }else{
        setState(() {
          result=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went Wrong"),
            duration: Duration(seconds: 2 ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

      }

    }catch(e){
      setState(() {
        result=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
  Future _recentTest() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/user_test_detials.php");
      Map mapdata = {
        "updte":"1",
        "user_id": applicant_id.toString(),
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII${data["tests"]}");
        if(data["error"]==0){
          setState(() {
            recent_data=data["tests"];
            // percent = total/atmpt;
          });
          return  data;
        }else{
          setState(() {
            recent_data=[];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went Wrong"),
              duration: Duration(seconds: 2 ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      }else{
        setState(() {
          recent_data=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went Wrong"),
            duration: Duration(seconds: 2 ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }

    }catch(e){
      setState(() {
        recent_data=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
  Future _testScore() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/user_test_detials.php");
      Map mapdata = {
        "updte":"1",
        "user_id": applicant_id.toString(),
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII${data["tests"]}");
        if(data["error"]==0){
          setState(() {
            test_score=data["tests"];
            // percent = total/atmpt;
          });
          return  data;
        }else{
          setState(() {
            test_score=[];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went Wrong"),
              duration: Duration(seconds: 2 ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      }else{
        setState(() {
          test_score=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went Wrong"),
            duration: Duration(seconds: 2 ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }

    }catch(e){
      setState(() {
        test_score=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
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
    if(widget.cate != null && widget.cate != ""){
      print("hello its your its ${widget.cate}");
      _getresult();
    }
    //_recentTest();
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
        child: CircularProgressIndicator(color: Color(0xFF118743),),
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
                                              child: Text("${user_port[i]["portfolio_description"]}",softWrap: true,maxLines:2,overflow: TextOverflow.ellipsis,))
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
              if (userSkills == null || userSkills.isEmpty && (recent_data ==null || recent_data.length ==0))
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
              SizedBox(height: 15),
              // if(recent_data !=null && recent_data.length >0)
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.2),
              //         spreadRadius: 2,
              //         blurRadius: 2,
              //       ),
              //     ],
              //     color: Colors.white,
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text("Test Taken",
              //             style: GoogleFonts.rubik(
              //                 fontWeight: FontWeight.w500)),
              //         SizedBox(height: 15),
              //         for(int i =0;i<recent_data.length;i++)
              //             InkWell(
              //               onTap: (){
              //                 if(recent_data[i]["completed_percentage"] == 100) {
              //                   Navigator.push(context, MaterialPageRoute(
              //                       builder: (context) =>
              //                           ResultQuestion(cate: recent_data[i]["category_name"], callback: callback_mem)));
              //                 }
              //               },
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: Color(0xFFF8F7F9),
              //                 ),
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment: MainAxisAlignment.center,
              //                         children: [
              //                           // Container(
              //                           //   height: 87,
              //                           //   width: 93,
              //                           //   child: SvgPicture.asset(
              //                           //       gen_iq
              //                           //   ),
              //                           // ),
              //                         ],
              //                       ),
              //                       Column(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Container(
              //                               width: MediaQuery.of(context).size.width/2.4,
              //                               child: Text("${recent_data[i]["category_name"]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),softWrap: true,overflow: TextOverflow.ellipsis,)),
              //                           SizedBox(
              //                             height: 4,
              //                           ),
              //                           Row(
              //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Text("Completed",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),),
              //                               Text("${recent_data[i]["completed_percentage"]} %",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.green),),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 4,
              //                           ),
              //                           LinearPercentIndicator(
              //                             padding: EdgeInsets.zero,
              //                             animation: true,
              //                             animationDuration: 1000,
              //                             lineHeight: 6.0,
              //                             percent: recent_data[i]["completed_percentage"]/100,
              //
              //                             linearStrokeCap: LinearStrokeCap.roundAll,
              //                             barRadius: Radius.circular(10),
              //                             progressColor: Colors.green,
              //                           ),
              //                         ],
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //       ],
              //     ),
              //   ),
              // ),
              SizedBox(height: 15),
              if(result !=null && result.length >0)
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
                        Text("Applied job Test Result",
                            style: GoogleFonts.rubik(
                                fontWeight: FontWeight.w500)),
                        SizedBox(height: 15),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFFF8F7F9),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      // Container(
                                      //   height: 87,
                                      //   width: 93,
                                      //   child: SvgPicture.asset(
                                      //       gen_iq
                                      //   ),
                                      // ),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                          width: MediaQuery.of(context).size.width/2.4,
                                          child: Text("${result["category_name"]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),softWrap: true,overflow: TextOverflow.ellipsis,)),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Percentage : ',
                                          style:TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),
                                          children: [
                                            WidgetSpan(
                                                child: SizedBox(
                                                  width: 60, // your of space
                                                )),
                                            TextSpan(text: '${result["total_correct_ans"]} %', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Color(0xFF118743))),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Test Completed in :',
                                          style:TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),
                                          children: [
                                            WidgetSpan(
                                                child: SizedBox(
                                                  width: 20, // your of space
                                                )),
                                            TextSpan(text: '${result["total_test_hours"]=="0"?"":"${result["total_test_hours"]} H , "} ${result["total_test_minutes"]=="0"?"":"${result["total_test_minutes"]}min ,"} ${result["total_test_seconds"]=="0"?"":"${result["total_test_seconds"]}sec"}', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Color(0xFF118743))),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      ),

                                      SizedBox(
                                        height: 8,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Correct Answer :',
                                          style:TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),
                                          children: [
                                            WidgetSpan(
                                                child: SizedBox(
                                                  width: 38, // your of space
                                                )),
                                            TextSpan(text: '${result["total_correct_ans"]} %', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Color(0xFF118743))),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Wrong Answer :',
                                          style:TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),
                                          children: [
                                            WidgetSpan(
                                                child: SizedBox(
                                                  width: 43, // your of space
                                                )),
                                            TextSpan(text: '${result["total_wrong_ans"]} %', style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Color(0xFF118743))),
                                          ],
                                        ),
                                        textAlign: TextAlign.left,
                                      ),
                                      SizedBox(
                                        height: 8,
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        SizedBox(height: 15),
                        InkWell(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailResult(heading: "${result["category_name"]}", show: false, cor:int.parse( result["total_correct_ans"]), wrong: int.parse(result["total_wrong_ans"]),userId: widget.user_id,)));
                          },
                          child: Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2,color: Color(0xFF118743))
                            ),
                            child: Center(child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("See Details",style: TextStyle(color: Color(0xFF118743),fontWeight: FontWeight.w600),),
                            )),
                          ),
                        )
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
    map["user_apply_jop_id"] = iid.toString();
    map["user_id"] = applicant_id.toString();

    var res = await http.post(
        Uri.parse("$mainurl/user_applied_jops_details_show.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          name = jsondata["user_name"]??"";
          email = jsondata["email_id"]??"";
          no = jsondata["mobile_number"]??"";
          add = jsondata["address"]??"";
          con = jsondata["country"]??"";
          ab = jsondata["about_me"]??"";
          gg = jsondata["profile_img"]??"";
          cl=jsondata["cover_later"]??"";

          ratinggg = jsondata["rating"].toDouble()??"";

          if (jsondata['user_skills'] != null) {
            List<Map<String, dynamic>> skills =
                List<Map<String, dynamic>>.from(jsondata['user_skills']);
            setState(() {
              userSkills = skills;
            });
          }
          if (jsondata['user_education'] != null) {
            setState(() {
              user_education = jsondata['user_education']??"";
            });
          }
          if (jsondata['user_portfolio'] != null) {
            setState(() {
              user_port = jsondata['user_portfolio']??"";
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
