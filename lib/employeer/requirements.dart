import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/emphome.dart';
import 'package:http/http.dart'as http;
import 'package:fac/employeer/vacancyjob.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Requirements extends StatefulWidget {
  const Requirements({super.key});

  @override
  State<Requirements> createState() => _RequirementsState();
}

class _RequirementsState extends State<Requirements> {

var item_no="";
final GlobalKey<FormState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();
    fetchData();
   }

  Future<void> fetchData() async {
    await Joblist(context);
  }


  List<dynamic> requirementsList = [];
  String? req="";
  TextEditingController reqcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vacancy",style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
      ),
      body: RefreshIndicator(
        onRefresh:fetchData,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          width:MediaQuery.of(context).size.width * 0.42 ,
                          height: 45,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xFF118743)),)),
                            onPressed: () {
                              Navigator.pushNamed(context, "vj");
                            },
                            child: Text(
                              "Job Details",
                              style: GoogleFonts.rubik(
                                  color: Color(0xFF118743), fontSize: 15),
                            ),
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(5),
                      child: Container(
                          width:MediaQuery.of(context).size.width * 0.42 ,
                          height: 45,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF118743),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  )),
                            onPressed: () {
                              Navigator.pushNamed(context, "req");
                            },
                            child: Text(
                              "Requirements",
                              style: GoogleFonts.rubik(
                                  color: Colors.white, fontSize: 15),
                            ),
                          )),
                    ),
                  ],
                ),
                SizedBox(height: 50),
                Container(
                    width: double.infinity,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                            side: BorderSide(color: Color(0xFF118743)),)),
                      onPressed: () {
                        requ();
                      },
                      child: Text(
                        "+ Add Requirements",
                        style: GoogleFonts.rubik(
                            color: Color(0xFF118743), fontSize: 15),
                      ),
                    )),

                SizedBox(height: 20,),
                for (var item in requirementsList)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 10),
                    padding: EdgeInsets.only(left: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (item is Map<String, dynamic>) ? item["requirement"] : item,
                          style: GoogleFonts.rubik(),
                        ),
                        IconButton(
                          onPressed: () {
                            if (item is Map<String, dynamic>) {
                              print("Job Vacancy ID: ${item["job_vacancy_id"]}");
                              setState(() {
                                item_no=item["job_vacancy_id"];

                              });

                              Jobdel(context);


                            }
                          },
                          icon: Icon(Icons.cancel),
                        )
                      ],
                    ),
                  ),

                SizedBox(height: MediaQuery.of(context).size.height / 1.5,),
                Container(
                    width: MediaQuery.of(context).size.width / 1.2,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.pushNamed(context, "application");
                      },
                      child: Text(
                        "Done",
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontSize: 15),
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void requ() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Form(
                          key: _key,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Add Your Requirements",
                                style: GoogleFonts.rubik(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Enter your requirements ",
                                style: GoogleFonts.rubik(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextFormField(
                                  controller: reqcontroller,
                                  cursorColor: Color(0xFF118743),
                                  onChanged: (text) {
                                    setState(() {
                                      req = text;
                                    });
                                  },
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return 'This field is required';
                                    }
                                    return null;
                                  },
                                  style: GoogleFonts.rubik(),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      // Set the border color
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      // Set the border color
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    hintText: "Requirements",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                    width: double.infinity,
                                    height: 45,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF118743),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                      onPressed: () {
                                        if(_key.currentState!.validate()){
                                          JobReq(context);
                                          // Navigator.pushNamed(context, "req");
                                        }
                                      },
                                      child: Text(
                                        "+ADD",
                                        style: GoogleFonts.rubik(
                                            color: Colors.white, fontSize: 15),
                                      ),
                                    )),
                              ),

                            ]
                          ),
                        )),
                  ),
                );
              },
            ),
          ),
        );
      },
    ).whenComplete(() {
      reqcontroller.clear();
    });
  }

  JobReq(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;
    map["jop_vacancy_id"] = app_id;
    map["requirements"] = reqcontroller.text;


    var res = await http.post(Uri.parse("$mainurl/add_job_details_requirements.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Information Saved Successfully"),
            duration: Duration(seconds: 5 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        setState(() {
        reqcontroller.clear();
        Joblist(context);
        fetchData();
        Navigator.pop(context);
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

  Joblist(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;
    map["jop_vacancy_id"] = app_id;


    var res = await http.post(Uri.parse("$mainurl/job_details_requirements_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        setState(() {
          requirementsList.clear();
          for (var requirement in jsondata["jop_vacancy_requirements"]) {
            requirementsList.add({
              "requirement": requirement["requirements"],
              "job_vacancy_id": requirement["jop_vacancy_requirements_id"],
            });
          }
          }
        );
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


  Jobdel(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;
    map["jop_vacancy_requirements_id"] = item_no;


    var res = await http.post(Uri.parse("$mainurl/job_details_requirements_list_delete.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("deleted:::::::::::::$map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Requirement Deleted"),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        Navigator.pushNamed(context, "req");
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


