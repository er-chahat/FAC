import 'dart:collection';
import 'dart:convert';
import 'package:fac/main.dart';
import 'package:fac/welcome/building.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/education.dart';
import 'package:fac/welcome/fetchdata.dart';
import 'package:fac/welcome/keyskills.dart';
import 'package:fac/welcome/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shared_preferences/shared_preferences.dart';

const List<Widget> gender = <Widget>[
  Text('Male'),
  Text('Female'),
];

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final List<bool> _selectedgender = <bool>[true, false];

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();

  bool vertical = false;

  String selectedValues = '';
  List<String> _options =[];
  List<String>  _option2 =[];
  String codepin = '';
  final TextEditingController _serchController = TextEditingController();

  var otp = "";
  Color radioColor = Colors.grey;
  String selectedOption = 'No';
  bool _isObscur = true;
  bool _isObscure = true;
  String name = "";
  String pword = "";
  String email = "";
  String num = "";
  String dob = "";
  String pass = "";
  TextEditingController passcontroller = TextEditingController();
  TextEditingController numcontroller = TextEditingController();
  TextEditingController emcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController pwordcontroller = TextEditingController();

  var gen = "male";

  String? selectedValue;
  TextEditingController dateinput = TextEditingController();
  TextEditingController datein = TextEditingController();
  List<String> itemList = [
    'Full-Time',
    'Part-Time',
    'Casual',
  ];
  List<String> jobType = [];
  String? typeSelected;
  List<String> jobIdType = [];
  String? typeIdSelected;
  List<String> jobTypCont = [];
  List<String> subTypCont = [];
  List<String> jobSubType = [];
  String? typeSubSelected;

  List<String> userSkills = [];
  String? locselected;
  List<String> userSkillss = [];
  String? pinselected;
  String? selectedItem ;

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

  locations(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(
        Uri.parse("$mainurl/location_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if (jsondata.containsKey("user_skills")) {
          setState(() {
            List<dynamic> skillsList = jsondata["user_skills"];
            userSkills = skillsList.map((skill) => skill["state"].toString()).toList();
            locselected=userSkills[0];
            if(userSkillss.isEmpty || userSkillss == []){
              PinCode(context, "");
            }
            print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $locselected");
          });

        }
        print("User Skills: $userSkills");


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

  jobTypes(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(
        Uri.parse("$mainurl/jobs_category.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if (jsondata.containsKey("deta")) {
          setState(() {
            List<dynamic> jobtyp = jsondata["deta"];
            jobType = jobtyp.map((skill) => skill["job_type"].toString()).toList();
            jobIdType=jobtyp.map((skill) => skill["job_category_id"].toString()).toList();
            typeSelected=jobType[0];
            if(jobSubType.isEmpty || jobSubType == []){
              subType(context, jobIdType[0]);
            }
            print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $locselected");
          });

        }
        print("job type: $jobType");


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
  subType(context,var idSelected) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["job_category_id"]=idSelected.toString();

    var res = await http.post(
        Uri.parse("$mainurl/jobs_type_get.php"),
        body: jsonEncode(map));
    dynamic jsondata = jsonDecode(res.body);
    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::         :::::::::::::$map");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      print(jsondata);
      if (er == 0) {
        setState(() {
          if (jsondata.containsKey("deta")) {
            List<dynamic> skillsList = jsondata["deta"];
            jobSubType = skillsList.map((skill) => "${skill["job_name"]}").toList();
            typeSubSelected=jobSubType[0];
          }
        });
        print("pincodes************: $jobSubType");

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

  PinCode(context,var pin) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["state"]=locselected.toString();

    var res = await http.post(
        Uri.parse("$mainurl/location_city_pincode_list.php"),
        body: jsonEncode(map));
    dynamic jsondata = jsonDecode(res.body);
    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::         :::::::::::::$map");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      print(jsondata);
      if (er == 0) {
        setState(() {
          if (jsondata.containsKey("user_skills")) {
            List<dynamic> skillsList = jsondata["user_skills"];
            userSkillss = skillsList.map((skill) => "${skill["city"]}(${skill["pincode"]})").toList();
            pinselected=userSkillss[0];
            print("your locselected ::::::: $pinselected");
            if(pin !=""){
              pinselected=pin;
            }
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


  Future<void> fcm() async {
    final _firebaseMessaging = FirebaseMessaging.instance;
    final fcmtoken = await _firebaseMessaging.getToken();
    print("Token: $fcmtoken");
    token = fcmtoken.toString();
    print("\n\n\n\nTemp Token in signup::::::::$token\n\n\n\n\n\n");
  }

  @override
  void initState() {
    locations(context);
    jobTypes(context);
    dateinput.text = "";
    datein.text = "";
    fcm();
    super.initState();
  }


  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/bg.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10, top: 100),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Join us to start searching",
                      style: GoogleFonts.rubik(
                          fontSize: 24, fontWeight: FontWeight.w400),
                    ),
                    // SizedBox(
                    //   height: 5,
                    // ),
                    // Text(
                    //   "Lorem Ipsum is simply dummy text of the printing and typesetting",
                    //   style:
                    //   GoogleFonts.rubik(fontSize: 15, color: Colors.grey),
                    //   textAlign: TextAlign.center,
                    // ),
                    SizedBox(
                      height: 40,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: namecontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            name = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Name",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: emcontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            email = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.all(16),
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
                          hintText: "Confirm Email",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter an email';
                          }
                          final emailRegex = RegExp(
                              r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');

                          if (!emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email address';
                          }
                          return null;
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8, right: 8),
                      child: IntlPhoneField(
                        cursorColor: Color(0xFF118743),
                        controller: numcontroller,
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
                          counterText: "",
                        ),
                        initialCountryCode: 'AU',
                        onChanged: (phone) {
                          print(phone
                              .completeNumber); // Handle phone number changes
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        readOnly: true,
                        controller: dateinput,
                        style: GoogleFonts.rubik(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Date Of Birth",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                        ),
                        onTap: () async {
                          DateTime? pickedDate = await showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime(1950),
                              lastDate: DateTime.now());

                          if (pickedDate != null) {
                            print(pickedDate);
                            String formattedDate =
                            DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(formattedDate);
                            setState(() {
                              dateinput.text = formattedDate;
                            });
                            print(dateinput.text);
                          } else {
                            print("Date is not selected");
                          }
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ToggleButtons(
                      direction: vertical ? Axis.vertical : Axis.horizontal,
                      onPressed: (int index) {
                        setState(() {
                          for (int i = 0; i < _selectedgender.length; i++) {
                            _selectedgender[i] = i == index;
                            if (index == 0) {
                              gen = "male";
                            } else {
                              gen = "female";
                            }
                          }
                        });
                      },
                      borderRadius: const BorderRadius.all(Radius.circular(8)),
                      selectedBorderColor: Color(0xFF118743),
                      selectedColor: Colors.white,
                      fillColor: Color(0xFF118743),
                      color: Color(0xFF118743),
                      constraints: const BoxConstraints(
                        minHeight: 47.0,
                        minWidth: 160,
                      ),
                      isSelected: _selectedgender,
                      children: gender,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0,right: 8),
                      child: DropdownButtonFormField(
                        // isDense: true,
                        validator: (value){
                          if(value == null || value!.isEmpty){
                            return "Please select";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          hintText: "Preferred work state",
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
                        ),
                        value: locselected,
                        onChanged: (String? selectedItem) {
                          setState(() {
                            this.locselected = selectedItem!;
                            this.pinselected = null;
                            PinCode(context,"");
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
                    SizedBox(height: 10,),
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
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextField(
                        controller: pwordcontroller,
                        obscureText: _isObscure,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            pword = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                          hintText: "Password",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: passcontroller,
                        obscureText: _isObscur,
                        cursorColor: Color(0xFF2c444e),
                        onChanged: (text) {
                          setState(() {
                            pass = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscur
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscur = !_isObscur;
                              });
                            },
                          ),
                          hintText: "Re-enter Password",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                        ),
                      ),
                    ),
                    if (pword.isNotEmpty && pass.isNotEmpty && pword != pass)
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 8),
                        child: Text(
                          "Passwords do not match",
                          style: TextStyle(color: Colors.red),
                        ),
                      ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Checkbox(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          value: selectedOption == 'Yes',
                          activeColor: Color(0xFF118743),
                          onChanged: (bool? value) {
                            setState(() {
                              selectedOption = value! ? 'Yes' : 'No';
                              radioColor = selectedOption == 'Yes'
                                  ? Color(0xFF118743)
                                  : Colors.grey;
                              print(selectedOption);
                            });
                          },
                        ),
                        Text(
                          "I agree with the ",
                          style: GoogleFonts.rubik(
                              fontSize: 12, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "tnc");
                          },
                          child: Text(
                            "Terms of Service ",
                            style: GoogleFonts.rubik(
                                color: Color(0xFF118743), fontSize: 12),
                          ),
                        ),
                        Text(
                          "& ",
                          style: GoogleFonts.rubik(
                              fontSize: 12, color: Colors.grey),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "pp");
                          },
                          child: Text(
                            "Privacy Policy",
                            style: GoogleFonts.rubik(
                                color: Color(0xFF118743), fontSize: 12),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Container(
                          width: double.infinity,
                          height: 45,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF118743),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              print("your pin seledcted ${pinselected}");
                              if (pword.isNotEmpty &&
                                  pass.isNotEmpty &&
                                  pword != pass) {
                                // cont();
                                print("ohhhh");
                              } else {
                                if (validateForm() &&
                                    _formKey.currentState!.validate()) {
                                  Sign(context);
                                }
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.rubik(
                                  color: Colors.white, fontSize: 15),
                            ),
                          )),
                    ),
                    Container(
                        width: double.infinity,
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(context, "login");
                          },
                          child: Text(
                            "Have an account? Login",
                            style: GoogleFonts.rubik(color: Color(0xFF118743)),
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  bool validateForm() {
    print(namecontroller.text);

    if (name.isEmpty &&
        dob.isEmpty == "" &&
        email.isEmpty == "" &&
        num.isEmpty == "" &&
        pass.isEmpty == "" &&
        pword.isEmpty == "" &&
        selectedOption == "No") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill out all the fields"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }
    if (name == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter Name"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }

    if (dobcontroller == "") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Fill date of birth"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }

    if (pass != pword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }
    if (selectedOption == "No") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Accept the terms and conditions"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }
    return true;
  }

  void cont() {
    showModalBottomSheet<void>(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: SingleChildScrollView(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            child: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    child: Align(
                        alignment: Alignment.topLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 20,
                            ),
                            Text(
                              "Enter 4 Digit Code",
                              style: GoogleFonts.rubik(
                                  fontSize: 24, fontWeight: FontWeight.w500),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Enter 4 digit code that you have recieved on your email.",
                              style: GoogleFonts.rubik(color: Colors.grey),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 2, 2, 2),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        if (value.length == 1) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                              focusNode2);
                                                        }
                                                      },
                                                      controller: controller1,
                                                      focusNode: focusNode1,
                                                      keyboardType:
                                                      TextInputType.number,
                                                      decoration:
                                                      InputDecoration(
                                                        border:
                                                        InputBorder.none,
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 2, 2, 2),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        if (value.length == 1) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                              focusNode3);
                                                        }
                                                      },
                                                      controller: controller2,
                                                      focusNode: focusNode2,
                                                      keyboardType:
                                                      TextInputType.number,
                                                      decoration:
                                                      InputDecoration(
                                                          border:
                                                          InputBorder
                                                              .none),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 2, 2, 2),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        if (value.length == 1) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                              focusNode4);
                                                        }
                                                      },
                                                      controller: controller3,
                                                      focusNode: focusNode3,
                                                      keyboardType:
                                                      TextInputType.number,
                                                      decoration:
                                                      InputDecoration(
                                                          border:
                                                          InputBorder
                                                              .none),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                    7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding:
                                                    EdgeInsets.fromLTRB(
                                                        10, 2, 2, 2),
                                                    child: TextFormField(
                                                      onChanged: (value) {
                                                        if (value.length == 1) {
                                                          FocusScope.of(context)
                                                              .requestFocus(
                                                              focusNode5);
                                                        }
                                                      },
                                                      controller: controller4,
                                                      focusNode: focusNode4,
                                                      keyboardType:
                                                      TextInputType.number,
                                                      decoration:
                                                      InputDecoration(
                                                          border:
                                                          InputBorder
                                                              .none),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
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
                                      print(
                                          "Controller 1: ${controller1.text}");
                                      print(
                                          "Controller 2: ${controller2.text}");
                                      print(
                                          "Controller 3: ${controller3.text}");
                                      print(
                                          "Controller 4: ${controller4.text}");
                                      print(
                                          "${controller1.text}${controller2.text}${controller3.text}${controller4.text}");
                                      otp =
                                      "${controller1.text}${controller2.text}${controller3.text}${controller4.text}";
                                      print(otp);

                                      V_Sign(context);
                                      //Navigator.pushNamed(context, "social");
                                    },
                                    child: Text(
                                      "Verify Email",
                                      style: GoogleFonts.rubik(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ),
                );
              },
            ),
          ),
        );
      },
    ).then((result) {
      controller1.clear();
      controller2.clear();
      controller3.clear();
      controller4.clear();
    });
  }

  Sign(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_name"] = namecontroller.text;
    map["email_id"] = emcontroller.text;
    map["mobile_number"] = numcontroller.text;
    map["dob"] = dateinput.text;
    map["gender"] = gen.toString();
    map["privacy_policy"] = selectedOption.toString();
    map["password"] = passcontroller.text;
    map["user_type"] = type.toString();
    map["fcm_token"] = token.toString();
    map["city"] = "$selectedValues (${codepin})";
    map["state"] = locselected!;
    print("your singup map value is  $map");

    var res = await http.post(Uri.parse("$mainurl/signup.php"),
        body: jsonEncode(map));
    print(res.body);
    print(map);
    print("\n\n\n\nhrlnnnnn\n\n\n\n");
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    user_id = jsondata["user_id"].toString();
    print(user_id);
    if (res.statusCode == 200) {
      if (er == 0) {
        cont();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email or Mobile already have an account"),
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
  void callback2(var data){
    setState(() {

    });
  }
  V_Sign(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["email_id"] = emcontroller.text;
    map["email_otp"] = otp;

    var res = await http.post(Uri.parse("$mainurl/signup_veryfi.php"),
        body: jsonEncode(map));
    print(res.body);
    print(otp);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var pref = await SharedPreferences.getInstance();

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        pref.setString(LoginState.SESSIONID, jsondata["session"]);
        pref.setString(LoginState.USERID, jsondata["user_id"]);
        pref.setString(LoginState.USERTYPE, jsondata["user_type"]);
        fetchData();
        setState(() {
          inside = true;
        });
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Keyskills(callback:callback2,)),
                (route) => false);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Wrong Otp"),
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