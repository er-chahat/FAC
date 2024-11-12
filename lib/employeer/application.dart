import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/bottom.dart';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/interview.dart';
import 'package:fac/employeer/vacancyjob.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late List<bool> analyticsVisibilityList;
  var tot = "";
  var sel = "";
  var rej = "";
  var vie = "";
  bool forAndroid = false;
  List<dynamic> vacancies = [];
  bool _isLoading = true;
  bool _interLoading = true;
  var intData;

  interview_sh(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["employer_id"] = user_id;

    var res = await http.post(
        Uri.parse("$mainurl/interview_schedule_list.php"),
        body: jsonEncode(map));
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        if (jsondata["error_msg"] == "User Interview Schedule List Get Successful") {
          setState(() {
            intData = jsondata["user_interview_schedule_list"];
          });
          setState(() {
            _interLoading = false;
          });
        }else{
          setState(() {
            intData="no data";
          });
          setState(() {
            _interLoading=false;
          });
        }
      }
    } else {
      setState(() {
        intData="went wrong";
      });
      setState(() {
        _interLoading=false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    allvacancies(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Applications",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: Navigator.canPop(context)?GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            setState(() {

            });
            if(Navigator.canPop(context))
              Navigator.pop(context);
          } ,
        ):Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF118743),
              ),
              child: IconButton(
                onPressed: () {
                  setState(() {
                    app_id = "";
                    vacancy_id = "";
                    imggg = "";
                  });
                  Navigator.pushNamed(context, "vj");
                },
                icon: Icon(Icons.add, color: Colors.white),
              ),
            ),
          )
        ],
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TextField(
              //   decoration: InputDecoration(
              //     filled: true,
              //     fillColor: Colors.grey[200],
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(20.0),
              //       borderSide: BorderSide.none,
              //     ),
              //     hintText: 'Search',
              //     prefixIcon: Icon(
              //       Icons.search,
              //       color: Colors.grey,
              //     ),
              //   ),
              //   cursorColor: Colors.green[700],
              // ),
              //SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        onPressed: () {
                         // Navigator.pushNamed(context, "application");
                        },
                        child: Text(
                          "All Vacancies",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFEDF9F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide.none,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "active");
                        },
                        child: Text(
                          "Active",
                          style: GoogleFonts.rubik(
                              color: Color(0xFF118743), fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                      height: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFEDF9F0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                            side: BorderSide.none,
                          ),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, "in");
                        },
                        child: Text(
                          "Inactive",
                          style: GoogleFonts.rubik(
                              color: Color(0xFF118743), fontSize: 15),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text("Interviews :",style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700),),
                  SizedBox(
                    width: 10,
                  ),
                  Switch(
                    // thumb color (round icon)
                    activeColor: Colors.white,
                    activeTrackColor: Colors.green,
                    inactiveThumbColor: Colors.white,
                    inactiveTrackColor: Colors.black12,
                    splashRadius: 50.0,
                    // boolean variable value
                    value: forAndroid,
                    // changes the state of the switch
                    onChanged: (value) {

                      setState(() => forAndroid = value);
                      if(value==true){
                       setState(() {
                         interview_sh(context);
                       });
                      }
                    },
                  ),
                ],
              ),
              SizedBox(height: 10),
              if(forAndroid == false)
                if (vacancies.isNotEmpty)
                  for (var i = 0; i < vacancies.length; i++)
                    vacancyContainer(vacancies[i], context, i),
              if(forAndroid == true)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Scheduled Interviews :",
                      style: GoogleFonts.rubik(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              if(forAndroid == true)
                _interLoading==true?Center(
                  child: CircularProgressIndicator(color: Colors.green[700],),
                ):intData=="no data"?Center(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("No Data Found !!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                )):intData!="went wrong"?Column(
                  children: [
                    for(int i=0;i<intData.length;i++)
                      InterView(inter_data: intData[i],),
                  ],
                ):Center(child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text("Something Went Wrong !!",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500),),
                )),
              if(forAndroid != true)
              if (vacancies.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
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
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "No Jobs Yet",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

  allvacancies(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/all_vacancies.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        setState(() {
          if(jsondata["error_msg"]=="Employer Jop Vacancy know Get"){
            vacancies=[];
          }else{
          vacancies = jsondata["user_skills"];
          analyticsVisibilityList =
              List.generate(vacancies.length, (_) => false);}
         _isLoading = false;

        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      print('error');
    }
  }

  Widget vacancyContainer(
      dynamic vacancy, BuildContext context, int index) {
    bool isActive = vacancy["is_active"] == "1";

    return GestureDetector(
      onTap: () {
        print(vacancy["jop_vacancy_id"]);
        app_id = vacancy["jop_vacancy_id"];
        Navigator.pushNamed(context, "vj");
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage("$photo/${vacancy["jop_image"]}"),
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                            color: Colors.grey[100], // Placeholder background color
                            borderRadius: BorderRadius.circular(10), // Adjust as needed
                          ),
                          child: Icon(
                            Icons.photo_library, // Placeholder icon, you can use any icon or asset
                            size: 30,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                      height: 60,
                      width: 60,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width/3.6,
                        child: Text(
                          vacancy["open_position"],
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w400, fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 2),
                      Container(
                        width: MediaQuery.of(context).size.width/3.9,
                        child: Text(
                          vacancy["location"],
                          style: GoogleFonts.rubik(fontSize: 10),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/3.9,
                        child: Text(
                          "${vacancy["type"]}",
                          style: GoogleFonts.rubik(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width/4,
                        child: Text(
                          "${vacancy["salary"]=="/null"?"Not given":vacancy["salary"]}",
                          style: GoogleFonts.rubik(
                            color: Colors.grey,
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 2),
                  Column(
                    children: [
                      Row(
                        children: [
                          IconButton(
                              onPressed: () {
                                setState(() {
                                  analyticsVisibilityList[index] =
                                  !analyticsVisibilityList[index];
                                  app_id = vacancy["jop_vacancy_id"];
                                });
                                fetchplease(context);
                              },
                              icon: Icon(Icons.info_outline)),
                          Container(
                            decoration: BoxDecoration(
                              color: isActive
                                  ? Color(0xFFEDF9F0)
                                  : Color(0xFFF9EDED),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 10, right: 10, top: 8, bottom: 8),
                              child: Text(
                                isActive ? "Active" : "Inactive",
                                style: GoogleFonts.rubik(
                                    color: isActive
                                        ? Color(0xFF00C152)
                                        : Color(0xFFC10000)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 5),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.28,
                          height: 35,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xFF118743)),
                                )),
                            onPressed: () {
                              setState(() {
                                app_id = vacancy["jop_vacancy_id"];
                              });
                              Navigator.pushNamed(context, "single");
                            },
                            child: Text(
                              "Applicants",
                              style: GoogleFonts.rubik(
                                  color: Color(0xFF118743), fontSize: 12),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              if (analyticsVisibilityList[index])
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("People Applied: $tot",
                            style: GoogleFonts.rubik(
                                color: Colors.grey, fontSize: 11)),
                        Text("Selected: $sel",
                            style: GoogleFonts.rubik(
                                color: Colors.grey, fontSize: 11)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Rejected: $rej",
                            style: GoogleFonts.rubik(
                                color: Colors.grey, fontSize: 11)),
                        Text("Interviewed: $vie",
                            style: GoogleFonts.rubik(
                                color: Colors.grey, fontSize: 11)),
                      ],
                    )
                  ],
                )
            ],
          ),
        ),
      ),
    );
  }

  fetchplease(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["jop_vacancy_id"] = app_id;

    var res = await http.post(
        Uri.parse("$mainurl/employer_vacancy_user_count.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    if (res.statusCode == 200) {
      print(jsondata);
      setState(() {
        tot = jsondata["total_apply_jop"];
        sel = jsondata["total_selected"];
        rej = jsondata["total_rejected"];
        vie = jsondata["total_interviews"];
      });
    } else {
      print("something..wrong");
    }
  }
}
