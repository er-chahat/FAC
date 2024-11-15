import 'dart:collection';
import 'dart:convert';
import 'package:fac/welcome/adsearched.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var jobpost="";
var joblocat="";
var jobtype="";
var jobex="";
var jobcity="";

class Advance extends StatefulWidget {
  const Advance({super.key});

  @override
  State<Advance> createState() => _AdvanceState();
}

class _AdvanceState extends State<Advance> {

  List<String> userSkillss = [];
  String? pinselected;

  String selectedValues = '';
  List<String> _options =[];
  List<String>  _option2 =[];
  String codepin = '';
  final TextEditingController _serchController = TextEditingController();

  String role = "";
  TextEditingController rolecontroller = TextEditingController();

  List<String> itemList = ['Full-Time', 'Part-Time', 'Casual'];
  String? selectedItem ;

  List<String> itemListtt = ["Beginner", "Intermediate", "Proficient"];
  String? selectedItemmm;

  List<String> userSkills = [];
  String? locselected;

  void callback(String s){
    setState(() {
      print("hello call back is called");
      var jobpost="";
      var joblocat="";
      var jobtype="";
      var jobex="";
      var jobcity="";
      rolecontroller.clear();
      if(userSkills.isNotEmpty)
        userSkills.clear();

      if(userSkillss.isNotEmpty)
        userSkillss.clear();
      locations(context);
    });
  }

  searchapi(String value, String? state) async{
    HashMap<String, dynamic> map = HashMap();
    map["updte"] = "1";
    map["state"] = state!;
    map["city"] = value;

    var res = await http.post(Uri.parse("$mainurl/location_city_search.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("harleen $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      print("hello api search data is $jsondata");
      //List<dynamic> skillsList = jsondata["user_skills"];
      //           setState(() {
      //             userSkills = skillsList.map((skill) => skill["state"].toString()).toList();
      //             locselected=userSkills[0];
      //           });
      if(er==0){
        List<dynamic> all = jsondata["location"] ;
        setState(() {
          _options = all.map((alldat)=> alldat["city"].toString()).toList();
          _option2 = all.map((alldat)=> alldat["pincode"].toString()).toList();
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went worng"),
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


  @override
  void initState() {
   locations(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Advance Search",
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
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: TextField(
                  controller: rolecontroller,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      role = text;
                    });
                  },
                  style: GoogleFonts.rubik(),
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding:
                    EdgeInsets.symmetric(horizontal: 16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Set the border color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey), // Set the border color
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "Role or Position",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey),

                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: TextFormField(
                  readOnly: true,
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                        isExpanded: true,

                        style: TextStyle(fontSize: 14, color: Colors.black),
                        hint: Text("Job-Type", style: TextStyle(color: Colors.grey)),
                        value: selectedItem,
                        onChanged: (selectedItem) {
                          setState(() {
                            this.selectedItem = selectedItem!;
                          });
                        },
                        items: itemList
                            .map((String item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: TextFormField(
                  readOnly: true,
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                        isExpanded: true,

                        style: TextStyle(fontSize: 14, color: Colors.black),
                        hint: Text("State", style: TextStyle(color: Colors.grey)),
                        value: locselected,
                        onChanged: (selectedItem) {
                          setState(() {
                            this.locselected = selectedItem!;
                            this.pinselected = null;
                            PinCode(context);
                          });
                        },
                        items: userSkills
                            .map((String item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: Container(
                  height: 50,
                  child: TextFormField(
                    controller: _serchController,
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
                      suffixIcon: Autocomplete<String>(
                        optionsBuilder: (TextEditingValue textEditingValue) async {
                          if (textEditingValue.text.isEmpty) {
                            return const Iterable<String>.empty();
                          }
                          await searchapi(textEditingValue.text, locselected);
                          return _options;
                        },
                        onSelected: (String selection) {
                          setState(() {
                            _serchController.text = selection;
                            pinselected=selection;
                            int index = _options.indexOf(selection);
                            selectedValues = selection;
                            codepin = _option2[index];
                          });
                          print('You selected: $selection');
                        },
                        fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                          return TextFormField(
                            controller: controller,
                            focusNode: focusNode,
                            style: GoogleFonts.rubik(),
                            decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.white,
                              contentPadding: EdgeInsets.symmetric(horizontal: 16),
                              hintText: "Search Suburb",
                              hintStyle: GoogleFonts.rubik(color: Colors.grey),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.grey),
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            onFieldSubmitted: (value) {
                              onFieldSubmitted();
                            },
                          );
                        },
                        optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                          return Align(
                            alignment: Alignment.topLeft,
                            child: Material(
                              elevation: 4.0,
                              child: Container(
                                height: 200.0,
                                color: Colors.white,
                                child: ListView.builder(
                                  padding: EdgeInsets.all(8.0),
                                  itemCount: options.length,
                                  itemBuilder: (BuildContext context, int index) {
                                    final String option = options.elementAt(index);
                                    return GestureDetector(
                                      onTap: () {
                                        onSelected(option);
                                      },
                                      child: ListTile(
                                        title: Text("$option (${_option2[index]})"),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Padding(
                padding: const EdgeInsets.only(left: 8,right: 8),
                child: TextFormField(
                  readOnly: true,
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                        isExpanded: true,

                        style: TextStyle(fontSize: 14, color: Colors.black),
                        hint: Text("Experience", style: TextStyle(color: Colors.grey)),
                        value: selectedItemmm,
                        onChanged: (selectedItem) {
                          setState(() {
                            this.selectedItemmm = selectedItem!;
                          });
                        },
                        items: itemListtt
                            .map((String item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.47,
              ),
              Container(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF118743),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  onPressed: () {
                    setState(() {
                      jobpost = rolecontroller.text ?? "" ;
                      joblocat = locselected?.toString() ?? "";
                      jobtype = selectedItem?.toString() ?? "";
                      jobex = selectedItemmm?.toString() ?? "";
                      jobcity = pinselected?.toString() ?? "";
                      pinselected="";
                    });
                      //Navigator.pushNamed(context, "asd");
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Adsearched(callback: callback)));

                      userSkills.clear();
                      userSkillss.clear();


                  },
                  child: Text(
                    "Search",
                    style: GoogleFonts.baloo2(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  locations(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(
        Uri.parse("$mainurl/location_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if (jsondata.containsKey("user_skills")) {
          List<dynamic> skillsList = jsondata["user_skills"];
          setState(() {
            userSkills = skillsList.map((skill) => skill["state"].toString()).toList();
            locselected=userSkills[0];
            print("location selected :::: $locselected");
          });
          print("sleected value is for pin is :::::::::: :$pinselected");
          if(pinselected=="" || pinselected==null){
            print("sleected value is for pin is :::::::::: :$pinselected");
            setState(() {
              PinCode(context);
            });
          }
        }
        print("User Skills: $userSkills");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went Wrong"),
            duration: Duration(seconds: 2),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    }
  }

  PinCode(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["state"]=locselected.toString();

    var res = await http.post(
        Uri.parse("$mainurl/location_city_pincode_list.php"),
        body: jsonEncode(map));
    dynamic jsondata = jsonDecode(res.body);
    print(map);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      print(jsondata);
      if (er == 0) {
        setState(() {
          if (jsondata.containsKey("user_skills")) {
            List<dynamic> skillsList = jsondata["user_skills"];
            userSkillss = skillsList.map((skill) => "${skill["city"]}(${skill["pincode"]})").toList();
            pinselected=userSkillss[0];
          }
        });
        print("pincodes************: $userSkillss");

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went Wrong"),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

      }
    }
  }




}
