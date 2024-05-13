import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class Education extends StatefulWidget {
  final Function(String) callback;
  Education({required this.callback});

  @override
  State<Education> createState() => _EducationState();
}

class _EducationState extends State<Education> {
  List<String> selectedTexts = List.generate(6, (index) => "");
  int selectedContainerIndex = -1;


  var ed="";

  String uni = "";
  String course = "";
  String sp = "";
  String start = "";
  String end = "";
  TextEditingController unicontroller = TextEditingController();
  TextEditingController coursecontroller = TextEditingController();
  TextEditingController startcontroller = TextEditingController();
  TextEditingController endcontroller = TextEditingController();
  TextEditingController spcontroller = TextEditingController();



  @override
  void initState() {
    super.initState();

    educationinfo();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            setState(() {
              widget.callback("");
            });
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Education", style: GoogleFonts.rubik()),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Education",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 15),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildContainer(0, "Doctorate"),
                  buildContainer(1, "Post Graduate"),
                  buildContainer(2, "Graduate"),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildContainer(3, "Class XII"),
                  buildContainer(4, "Class X"),
                  buildContainer(5, "Below Class X"),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Text("University/Institute Name",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 15)),
              SizedBox(
                height: 14,
              ),
              TextField(
                controller: unicontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    uni = text;
                  });
                },
                style: GoogleFonts.rubik(),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "University/Institute name",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey)),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Course",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 15)),
              SizedBox(
                height: 14,
              ),
              TextField(
                controller: coursecontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    course = text;
                  });
                },
                style: GoogleFonts.rubik(),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Your Course",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey)),
              ),
              SizedBox(
                height: 15,
              ),
              Text("Specification",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 15)),
              SizedBox(
                height: 14,
              ),
              TextField(
                controller: spcontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    sp = text;
                  });
                },
                style: GoogleFonts.rubik(),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Specifications",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey)),
              ),
              SizedBox(
                height: 15,
              ),

              Text("Course Duration",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 15)),
              SizedBox(
                height: 14,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 45,
                    child: TextField(
                      controller: startcontroller,
                      cursorColor: Color(0xFF118743),
                      onChanged: (text) {
                        setState(() {
                          start = text;
                        });
                      },
                      style: GoogleFonts.rubik(),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Starting Year",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey)),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(4),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.43,
                    height: 45,
                    child: TextField(
                      controller: endcontroller,
                      cursorColor: Color(0xFF118743),
                      onChanged: (text) {
                        setState(() {
                          end = text;
                        });
                      },
                      style: GoogleFonts.rubik(),
                      decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Ending Year",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey)),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        LengthLimitingTextInputFormatter(4),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 70),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if(ed!=null&&ed!=""&&unicontroller.text!=null&&unicontroller.text!=""&&coursecontroller.text!=""&&spcontroller.text!=""&&startcontroller.text!=""&&endcontroller!=""){
                        Edu(context);
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Fill the form properly"),
                            duration: Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Next",
                      style: GoogleFonts.rubik(color: Colors.white,fontSize: 17),
                    ),

                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContainer(int index, String text) {
    return Container(
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color:
          selectedContainerIndex == index ? Color(0xFF118743) : Colors.grey,
        ),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: selectedContainerIndex == index
              ? Color(0xFF118743)
              : Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        onPressed: () {
          setState(() {
            selectedContainerIndex = index;
            selectedTexts[index] = text;
            ed=text;
            print(text);
          });
        },
        child: Text(
          text,
          style: GoogleFonts.rubik(
            color:
            selectedContainerIndex == index ? Colors.white : Colors.black54,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Edu(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;
    map["degree"] = ed.toString();
    map["university_Institute_name"] = unicontroller.text;
    map["course"] = coursecontroller.text;
    map["specialization"] = spcontroller.text;
    map["starting_year"] = startcontroller.text;
    map["ending_year"] = endcontroller.text;


    var res = await http.post(Uri.parse("$mainurl/education_user.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if(er==0){
        print("hello its nind inside $inside");
        if(inside==true){
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wel(),), (route) => false);
          setState(() {
            widget.callback("");
          });
          Navigator.pop(context);

        //  Navigator.pushNamed(context, "wel");
        }
        else if (inside==false){
          Navigator.pushNamed(context, "keyskills");
        }
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something Went wrong"),
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

  Future educationinfo() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse('$mainurl/user_education_list.php'),
        body: jsonEncode(map),
      );
      print(map);
      dynamic jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200) {
        setState(() {
          unicontroller.text=jsondata["university_Institute_name"];
          coursecontroller.text=jsondata["course"];
          spcontroller.text=jsondata["specialization"];
          startcontroller.text=jsondata["starting_year"];
          endcontroller.text=   jsondata["ending_year"];
          ed = jsondata["degree"]??"";
          switch (jsondata["degree"]) {
            case "Doctorate":
              selectedContainerIndex = 0;
              break;
            case "Post Graduate":
              selectedContainerIndex = 1;
              break;
            case "Graduate":
              selectedContainerIndex = 2;
              break;
            case "Class XII":
              selectedContainerIndex = 3;
              break;
            case "Class X":
              selectedContainerIndex = 4;
              break;
            case "Below Class X":
              selectedContainerIndex = 5;
              break;
            default:
              selectedContainerIndex = -1; // Set a default value for unknown degree
          }

        });

      } else {
        throw Exception("Failed to load profile data");
      }
    } catch (e) {
      print('Error while fetching profile: $e');
    }
  }


}
