import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Analysis extends StatefulWidget {
  const Analysis({super.key});

  @override
  State<Analysis> createState() => _AnalysisState();
}

class _AnalysisState extends State<Analysis> {


  var tiname="";
  var tiem="";
  List<dynamic> vacancies = [];

  @override
  void initState() {
   viewpro(context);
   activevacancies(context);
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Analysis",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF9F0),
                      borderRadius: BorderRadius.circular(50),
                    ),
                    child: Image(
                      image: AssetImage("assets/looo.png",),
                      height: MediaQuery.of(context).size.height * 0.17,
                      width: MediaQuery.of(context).size.width * 0.3,
                    ),
                  ),
                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tiname,style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 22),),
                      Text(tiem,style: GoogleFonts.rubik(color: Colors.grey),),
                      Text("Australia",style: GoogleFonts.rubik(color: Colors.grey),)

                    ],
                  )
                ],
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Active vacancy",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 16),),
                  GestureDetector(
                      onTap: (){
                        Navigator.pushNamed(context, "active");
                      },
                      child: Text("View all",style: GoogleFonts.rubik(color: Colors.green),))
                ],
              ),
              SizedBox(height: 20,),
              if (vacancies.isNotEmpty)
                vacancyContainer(vacancies[0]),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Who's applied",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 16),),
                  Text("View all",style: GoogleFonts.rubik(color: Colors.green),)
                ],
              ),
              SizedBox(height: 20,),

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
                          Container(

                            child:Image(image: AssetImage("assets/ritesh.png"),height: 65,width: 50,),

                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ritesh Singh",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 15),),

                              Text("UI/UX Designer",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 13),),


                            ],
                          ),
                          Spacer(flex: 2,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "applicants");

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEDF9F0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(onPressed: (){
                                Navigator.pushNamed(context, "applicants");

                              }, icon: Icon(Icons.mail,color: Colors.green,),),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                width:MediaQuery.of(context).size.width * 0.35 ,
                                height: 35,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF118743),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "sr");
                                  },
                                  child: Text(
                                    "See Resume",
                                    style: GoogleFonts.rubik(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                width:MediaQuery.of(context).size.width * 0.35 ,
                                height: 35,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Color(0xFF118743)),)),
                                  onPressed: () {

                                  },
                                  child: Text(
                                    "See Details",
                                    style: GoogleFonts.rubik(
                                        color: Color(0xFF118743), fontSize: 15),
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),

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
                          Container(

                            child:Image(image: AssetImage("assets/ritesh.png"),height: 65,width: 50,),

                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ritesh Singh",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 15),),

                              Text("UI/UX Designer",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 13),),


                            ],
                          ),
                          Spacer(flex: 2,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "applicants");

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEDF9F0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(onPressed: (){
                                Navigator.pushNamed(context, "applicants");

                              }, icon: Icon(Icons.mail,color: Colors.green,),),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                width:MediaQuery.of(context).size.width * 0.35 ,
                                height: 35,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF118743),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "sr");
                                  },
                                  child: Text(
                                    "See Resume",
                                    style: GoogleFonts.rubik(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                width:MediaQuery.of(context).size.width * 0.35 ,
                                height: 35,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Color(0xFF118743)),)),
                                  onPressed: () {

                                  },
                                  child: Text(
                                    "See Details",
                                    style: GoogleFonts.rubik(
                                        color: Color(0xFF118743), fontSize: 15),
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),

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
                          Container(

                            child:Image(image: AssetImage("assets/ritesh.png"),height: 65,width: 50,),

                          ),
                          SizedBox(width: 10,),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Ritesh Singh",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 15),),

                              Text("UI/UX Designer",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 13),),


                            ],
                          ),
                          Spacer(flex: 2,),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "applicants");

                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEDF9F0),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: IconButton(onPressed: (){
                                Navigator.pushNamed(context, "applicants");

                              }, icon: Icon(Icons.mail,color: Colors.green,),),
                            ),
                          )
                        ],
                      ),
                      Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                width:MediaQuery.of(context).size.width * 0.35 ,
                                height: 35,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF118743),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10))),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "sr");
                                  },
                                  child: Text(
                                    "See Resume",
                                    style: GoogleFonts.rubik(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5),
                            child: Container(
                                width:MediaQuery.of(context).size.width * 0.35 ,
                                height: 35,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Color(0xFF118743)),)),
                                  onPressed: () {

                                  },
                                  child: Text(
                                    "See Details",
                                    style: GoogleFonts.rubik(
                                        color: Color(0xFF118743), fontSize: 15),
                                  ),
                                )),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),


            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

  viewpro(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/employer_profile_view.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {

          tiname=jsondata["company_name"];
          tiem=jsondata["email_id"];
        });

      } else {

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

  activevacancies(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;


    var res = await http.post(Uri.parse("$mainurl/active_vacancies.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {

        setState(() {
          vacancies = jsondata["user_skills"];
        });

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      print('error');
    }

  }


}

Widget vacancyContainer(dynamic vacancy) {
  bool isActive = vacancy["is_active"] == "1";

  return Container(
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
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(10),
            ),
            child: Image(
              image: AssetImage("assets/comp.png"),
              height: 65,
              width: 50,
            ),
          ),
          SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vacancy["open_position"],
                style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
              ),
              SizedBox(height: 10),
              Text(
                vacancy["location"],
                style: GoogleFonts.rubik(),
              ),
              Text(
                "${vacancy["type"]}",
                style: GoogleFonts.rubik(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
          Spacer(flex: 2),
          Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: isActive ? Color(0xFFEDF9F0) : Color(0xFFF9EDED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    isActive ? "Active" : "Inactive",
                    style: GoogleFonts.rubik(color: isActive ? Color(0xFF00C152) : Color(0xFFC10000)),
                  ),
                ),
              ),
              SizedBox(height: 10),
              Text(
                "${vacancy["salary"]}/y",
                style: GoogleFonts.rubik(fontWeight: FontWeight.w400),
              ),
            ],
          ),
        ],
      ),
    ),
  );
}

