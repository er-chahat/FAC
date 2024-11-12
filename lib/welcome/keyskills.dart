import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/wel.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:fac/welcome/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String selectedText = '';
var ski;

class Keyskills extends StatefulWidget {
  final Function(String) callback;
  Keyskills({required this.callback});

  @override
  State<Keyskills> createState() => _KeyskillsState();
}

class _KeyskillsState extends State<Keyskills> {
  String skill = "";
  TextEditingController skillController = TextEditingController();
  List<String> okk = [];
  var currskill="";

  Color radioColor = Colors.grey;
  String selectedOption = 'No';
  Color radioColorr = Colors.grey;
  String selectedOptionn = 'No';
  Color radioColorrr = Colors.grey;
  String selectedOptionnn = 'No';

  @override
  void initState() {
    super.initState();
    viewskills(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if(Navigator.canPop(context)) {
              setState(() {
                widget.callback("");
              });
              Navigator.pop(context);
            }
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Key Skills", style: GoogleFonts.rubik()),
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
                "Key Skills",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "Recruiters look for candidates with specific key skills to hire for your roles. Add them here.",
                  style: GoogleFonts.rubik(fontSize: 14)),
              SizedBox(
                height: 14,
              ),
              Text(
                "Your Skills",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 17),
              ),
              SizedBox(
                height: 15,
              ),
              TextField(
                controller: skillController,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    skill = text;
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
                    hintText: "Eg. Sales ",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey)),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                    "Avoid typing keywords such as hardworking, honest, etc.",
                    style: GoogleFonts.rubik(color: Colors.red)),
              ),
              SizedBox(
                height: 20,
              ),
              buildCheckboxContainer(
                "assets/icom.png",
                "Beginner",
                selectedOption,
                (value) {
                  updateSelectedOptions(value, 'No', 'No');
                },
              ),
              SizedBox(
                height: 10,
              ),
              buildCheckboxContainer(
                "assets/icomm.png",
                "Intermediate",
                selectedOptionn,
                (value) {
                  updateSelectedOptions('No', value, 'No');
                },
              ),
              SizedBox(
                height: 10,
              ),
              buildCheckboxContainer(
                "assets/icomm.png",
                "Proficient",
                selectedOptionnn,
                (value) {
                  updateSelectedOptions('No', 'No', value);
                },
              ),
              SizedBox(
                height: 20,
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.43,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      if(skillController.text!=""&&skillController.text!=null &&ski!=null &&ski!=""){
                        print("your inside is : $inside && ${okk.length}");
                        if(inside==false){
                          Skill(context);
                          // if (okk.length == 3) {
                          //   Navigator.pushNamed(context, "mp");
                          // }else{
                          //   Skill(context);
                          // }
                        }
                        if(inside==true){
                          Skill(context);
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Enter skill properly"),
                            duration: Duration(seconds: 2),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40)),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "+Add",
                      style:
                          GoogleFonts.rubik(color: Colors.white, fontSize: 17),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              if(okk.length != 0)
              Wrap(
                spacing: 20.0,
                runSpacing: 16.0,
                children: List.generate((okk.length / 2).ceil(), (index) {
                  int startIndex = index * 2;
                  int endIndex = (index + 1) * 2;
                  endIndex = endIndex > okk.length ? okk.length : endIndex;

                  return Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ...okk
                          .sublist(startIndex, endIndex)
                          .map(
                            (skill) => Stack(
                                clipBehavior: Clip.none,
                              children: [
                                Container(
                                  width: MediaQuery.of(context).size.width * 0.39,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey.withOpacity(0.2),
                                        spreadRadius: 2,
                                        blurRadius: 2,
                                      ),
                                    ],
                                    color: Colors.white38,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text(
                                      skill,
                                      textAlign: TextAlign.center,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2, // Adjust maxLines as needed
                                    ),
                                  ),
                                ),
                                Positioned(
                                  top: -10,
                                  right: 3,
                                  child: GestureDetector(
                                    onTap:(){
                                      print(skill);
                                      setState(() {
                                        currskill=skill;
                                      });
                                      delskills(context);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 7, right: 7, top: 2, bottom: 2),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(5),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.grey.withOpacity(0.2),
                                            spreadRadius: 2,
                                            blurRadius: 2,
                                          ),
                                        ],
                                        color: Colors.red[100],
                                      ),
                                      child: Icon(Icons.cancel_outlined,color: Colors.red,)
                                    ),
                                  ),
                                ),
                              ]
                            ),

                      )
                          .expand((widget) => [
                        widget,
                        SizedBox(width: 20),
                      ]),

                    ],
                  );
                }),
              ),

              SizedBox(height: 80),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF118743),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    print("INside is true or false ::::::::::::::::: $inside");
                    //  Skill(context);
                    if (inside != true) {
                      setState(() {
                        widget.callback("");
                        inside = true;
                      });
                      Navigator.pop(context);
                      // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wel(),), (route) => false);
                      //Navigator.pushNamed(context, "wel");
                    } else if(inside!=false){
                      setState(() {
                        inside = false;
                      });
                     // Navigator.canPop(context);
                      Navigator.pushReplacementNamed(context, "mp");
                    }
                  },
                  child: Text(
                    "Nexts",
                    style: GoogleFonts.rubik(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCheckboxContainer(
    String imagePath,
    String text,
    String selectedValue,
    Function(String) onChanged,
  ) {
    return Container(
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
        padding:
            const EdgeInsets.only(left: 20, top: 10, bottom: 10, right: 20),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Image(image: AssetImage(imagePath)),
            ),
            Text(
              text,
              style:
                  GoogleFonts.rubik(fontSize: 17, fontWeight: FontWeight.w400),
            ),
            Spacer(
              flex: 2,
            ),
            Checkbox(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              value: selectedValue == 'Yes',
              activeColor: Color(0xFF118743),
              onChanged: (bool? value) {
                onChanged(value! ? 'Yes' : 'No');

                if (value == true) {
                  selectedText = 'Yes';
                } else {
                  selectedText = 'No';
                }
                onChanged(selectedText);
                print('Selected option: $selectedText');
                if (selectedText == 'Yes') {
                  print('Selected skill level: $text');
                  ski = text;
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  void updateSelectedOptions(
      String beginner, String intermediate, String proficient) {
    setState(() {
      selectedOption = beginner;
      selectedOptionn = intermediate;
      selectedOptionnn = proficient;
    });
  }

  Skill(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["skills"] = skillController.text;
    map["experience"] = ski.toString();

    var res = await http.post(Uri.parse("$mainurl/user_skills.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Added Sucessfully"),
            duration: Duration(seconds: 2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        //Navigator.pushNamed(context, "keyskills");
        setState(() {
          viewskills(context);
          skillController.clear();
          selectedOption = 'No';
          selectedOptionn = 'No';
          selectedOptionnn = 'No';
          ski.clear();
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
    } else {
      print('error');
    }
  }

  viewskills(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/user_skills_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if(jsondata["user_skills"] != null) {
          setState(() {
            List<Map<String, dynamic>> skillsDataList =
            List<Map<String, dynamic>>.from(jsondata["user_skills"]);
            if (okk.length > 0) {
              okk.clear();
            }
            for (var skillsData in skillsDataList) {
              okk.add(skillsData["skills"]);
            }

            print("okk list: $okk");
          });
        }else{
          okk.clear();
        }
      } else {}
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

  delskills(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["skills"]=currskill.toString();


    var res = await http.post(Uri.parse("$mainurl/skill_delete.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          viewskills(context);
        });
       //Navigator.pushNamed(context, "keyskills");
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

}
