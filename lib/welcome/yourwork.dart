import 'dart:collection';
import 'dart:convert';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/signup.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';

class YourWork extends StatefulWidget {
  const YourWork({super.key});

  @override
  State<YourWork> createState() => _YourWorkState();
}

class _YourWorkState extends State<YourWork> {
  late Future<List<Map<String, String>>> userSkills;

  List<String> selectedCities = [];
  List<String> userLocations = [];
  var DelLoc="";


  @override
  void initState() {
    super.initState();
    userSkills = fetchUserSkills();

  }

  String sal = "";
  String work = "";
  TextEditingController salController = TextEditingController();
  TextEditingController workController = TextEditingController();

  Future<List<Map<String, String>>> fetchUserSkills() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/location_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);

    if (res.statusCode == 200) {
      final List<dynamic> data = json.decode(res.body)['user_skills'];
      return List<Map<String, String>>.from(data.map((dynamic item) {
        return Map<String, String>.from(item);
      }));
    } else {
      throw Exception('Failed to load user skills');
    }
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
        title: Text("Work Preferences", style: GoogleFonts.rubik()),
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
                "Your Work Preferences",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                "Help us match you to the best career opportunities based on your preferences.",
                style: GoogleFonts.rubik(fontSize: 14),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Preferred annual salary",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 17),
              ),
              SizedBox(
                height: 15,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: salController,
                      cursorColor: Color(0xFF118743),
                      onChanged: (text) {
                        setState(() {
                          sal = text;
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
                          hintText: "",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey)),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                      ],
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Per Year",
                    style: GoogleFonts.rubik(),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: Text(
                  "Please make sure you’ve entered the correct salary",
                  style: GoogleFonts.rubik(color: Colors.red, fontSize: 10.5),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Preferred Work Location",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 17),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                height: 50,
                color: Colors.white,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side: BorderSide(
                      color: Colors.grey,
                      width: 1,
                    ),
                  ),
                  onPressed: () {
                    loc();
                  },
                  child: Text(
                    "Location",
                    style: GoogleFonts.rubik(
                      color: Colors.grey,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Wrap(
                spacing: 16.0,
                runSpacing: 16.0,
                children: List.generate(userLocations.length, (index) {
                  return Container(
                    width: (MediaQuery.of(context).size.width - 60 -1 * 16.0) / 2,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                      color: Colors.white38,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          userLocations[index],
                          style: GoogleFonts.rubik(),
                          textAlign: TextAlign.center,
                        ),
                        IconButton(onPressed: () {

                          setState(() {
                            DelLoc=userLocations[index];
                            print(DelLoc);
                          });

                          dell(context);
                        }, icon:Icon(Icons.cancel_rounded,color: Colors.red),)
                      ],
                    ),
                  );
                }),
              ),

              SizedBox(height: 150),
              Container(
                width: double.infinity,
                height: 50,
                child: TextButton(
                  style: TextButton.styleFrom(
                      backgroundColor: Color(0xFF118743),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    setState(() {
                      // withloc(context);
                      Navigator.pushNamed(context, "about");
                    });
                  },
                  child: Text(
                    "Next",
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
    String cityName,
    bool isSelected,
    Function(bool) onChanged,
  ) {
    return InkWell(
      onTap: () {
        onChanged(!isSelected);
      },
      child: Container(
        child: Row(
          children: [
            Container(
              width: 24,
              height: 50,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Colors.green : Colors.white,
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey,
                  width: 2,
                ),
              ),
              child: isSelected
                  ? Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            SizedBox(width: 8),
            Text(
              cityName,
              style: GoogleFonts.rubik(fontWeight: FontWeight.w400),
            ),
          ],
        ),
      ),
    );
  }

  void loc() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return Column(
          children: [
            FutureBuilder<List<Map<String, String>>>(
              future: userSkills,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Text('No data available');
                } else {
                  return StatefulBuilder(builder: (context, setState) {
                    return Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Container(
                        height: 400,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Preferred work location (Max 10)",
                                  style: GoogleFonts.rubik(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600),
                                )),
                            SizedBox(height: 10,),
                            Expanded(
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, index) {
                                  return buildCheckboxContainer(
                                    snapshot.data![index]['city']!,
                                    selectedCities.contains(
                                        snapshot.data![index]['city']),
                                    (value) {
                                      setState(() {
                                        if (value &&
                                            selectedCities.length < 10) {
                                          selectedCities.add(
                                              snapshot.data![index]['city']!);
                                        } else if (!value) {
                                          selectedCities.remove(
                                              snapshot.data![index]['city']!);
                                        }
                                      });
                                    },
                                  );
                                },
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                withloc(context);
                                setState(() {
                                  selectedCities.clear();
                                });
                              },
                              child: Text(
                                "Done",
                                style: GoogleFonts.rubik(
                                  color: Colors.white,
                                  fontSize: 17,
                                ),
                              ),
                              style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF118743),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
                }
              },
            ),
          ],
        );
      },
    );
  }

  withloc(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["annual_salary"] = salController.text;
    map["location"] = selectedCities.join(',');

    var res = await http.post(Uri.parse("$mainurl/work_preferences.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {

        if (jsondata['user_location'] != null) {
          List<String> locationNames = List<String>.from(
            jsondata['user_location'].map((locationData) => locationData['location']),
          );

          setState(() {
            userLocations = locationNames;
          });
          print(locationNames);
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
    } else {
      print('error');
    }
  }

  dell(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["location"]=DelLoc;

    var res = await http.post(Uri.parse("$mainurl/location_delete.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        seeloc(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something Went wrong! Try Again"),
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

  seeloc(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/user_location_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        userLocations.clear();
        if (jsondata['user_location'] != null) {
          List<String> locationNames = List<String>.from(
            jsondata['user_location'].map((locationData) => locationData['location']),
          );

          setState(() {
            userLocations = locationNames;
          });
          print(locationNames);
        }

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something Went wrong! Try Again"),
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

}
