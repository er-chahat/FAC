import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/main.dart';
import 'package:fac/welcome/fetchdata.dart';
import 'package:fac/welcome/login.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Signupp extends StatefulWidget {
  const Signupp({super.key});

  @override
  State<Signupp> createState() => _SignuppState();
}

class _SignuppState extends State<Signupp> {



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

  var otp="";

  bool vertical = false;
  String selectedValues = '';
  bool saveOrNot = false;
  List<String> _options =[];
  List<String>  _option2 =[];
  String codepin = '';
  final TextEditingController _serchController = TextEditingController();

  Color radioColor = Colors.grey;
  String selectedOption = 'No';
  bool _isObscur = true;
  bool _isObscure = true;
  String name = "";
  String pword = "";
  String email = "";
  String num = "";
  String dob ="";
  String pass = "";
  String cp = "";
  String comadd = "";
  String est = "";
  TextEditingController cpcontroller = TextEditingController();
  TextEditingController estcontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController comaddcontroller = TextEditingController();
  TextEditingController numcontroller = TextEditingController();
  TextEditingController emcontroller = TextEditingController();
  TextEditingController namecontroller = TextEditingController();
  TextEditingController dobcontroller = TextEditingController();
  TextEditingController pwordcontroller = TextEditingController();

  List<String> userSkillss = [];
  String? pinselected;
  List<String> userSkills = [];
  String? locselected;

  String? selectedValue;
  TextEditingController dateInput = TextEditingController();
  TextEditingController datein = TextEditingController();

  Future<void> fcm() async {
    final _firebaseMessaging = FirebaseMessaging.instance;
    final fcmtoken = await _firebaseMessaging.getToken();
    print("Token: $fcmtoken");
    token = fcmtoken.toString();
    print("\n\n\n\nTemp Token in signup::::::::$token\n\n\n\n\n\n");
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
    dateInput.text = "";
    datein.text = "";
    fcm();
    locations(context);
    super.initState();
  }

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
              padding: const EdgeInsets.only(left: 10,right: 10,top: 80),
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
                    SizedBox(height: 40,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: namecontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            name = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          hintText: "Company Name",
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
                        controller: cpcontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            cp = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          hintText: "Person InCharge Name",
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
                        controller: dobcontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            dob = text;
                          });
                        },

                        style: GoogleFonts.rubik(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
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
                          hintText: "Position",
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          hintText: "Company Email",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
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
                          hintText: "Company Phone",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                          counterText: "",
                        ),
                        initialCountryCode: 'AU',
                        onChanged: (phone) {
                          if(num.isEmpty){
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Fill This Out",
                                style: TextStyle(color: Colors.red),
                              ),
                            );
                          }
                          print(phone.completeNumber); // Handle phone number changes
                        },
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: comaddcontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            comadd = text;
                          });
                        },

                        style: GoogleFonts.rubik(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
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
                          hintText: "Company Address",
                          hintStyle: GoogleFonts.rubik(color: Colors.grey),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
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
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 8,right: 8),
                    //   child: TextFormField(
                    //     readOnly: true,
                    //     decoration: InputDecoration(
                    //       filled: true,
                    //       fillColor: Colors.white,
                    //       contentPadding: EdgeInsets.symmetric(horizontal: 16),
                    //       enabledBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       focusedBorder: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       border: OutlineInputBorder(
                    //         borderSide: BorderSide(color: Colors.grey),
                    //         borderRadius: BorderRadius.circular(10),
                    //       ),
                    //       suffixIcon: Padding(
                    //         padding: const EdgeInsets.only(left: 15),
                    //         child: DropdownButton<String>(
                    //           isExpanded: true,
                    //
                    //           style: TextStyle(fontSize: 14, color: Colors.black),
                    //           hint: Text("Suburb", style: TextStyle(color: Colors.grey)),
                    //           value: pinselected,
                    //           onChanged: (selectedItem) {
                    //             setState(() {
                    //               this.pinselected = selectedItem!;
                    //               print(selectedItem);
                    //             });
                    //           },
                    //           items: userSkillss
                    //               .map((String item) => DropdownMenuItem(
                    //             value: item,
                    //             child: Text(item),
                    //           ))
                    //               .toList(),
                    //           icon: Padding(
                    //             padding: EdgeInsets.only(left: 20),
                    //             child: Icon(
                    //               Icons.keyboard_arrow_down,
                    //               color: Colors.grey,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                   SizedBox(height: 10,),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: TextFormField(
                        controller: pwordcontroller,
                        obscureText: _isObscure,
                        cursorColor: Color(0xFF118743),

                        onChanged: (text) {
                          setState(() {
                            pword = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'This field is required';
                          }
                          return null;
                        },
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                          shape:RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)) ,
                          value: selectedOption == 'Yes',
                          activeColor: Color(0xFF118743),
                          onChanged: (bool? value) {
                            setState(() {
                              selectedOption = value! ? 'Yes' : 'No';
                              radioColor = selectedOption == 'Yes' ? Color(0xFF118743) : Colors.grey;
                              print(selectedOption);
                            });
                          },
                        ),
                        Text("I agree with the ",style: GoogleFonts.rubik(fontSize: 12,color: Colors.grey),),
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "tnc");
                          },
                            child: Text("Terms of Service ",style: GoogleFonts.rubik(color: Color(0xFF118743),fontSize: 12),)),
                        Text("& ",style: GoogleFonts.rubik(fontSize: 12,color: Colors.grey),),
                        GestureDetector(
                            onTap: (){
                              Navigator.pushNamed(context, "pp");
                            },
                            child: Text("Privacy Policy",style: GoogleFonts.rubik(color: Color(0xFF118743),fontSize: 12),))
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
                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                            onPressed: () {
                              if(pword.isNotEmpty && pass.isNotEmpty && pword != pass){
                                print("ohhhh");

                              }else{
                                if (validateForm()&& _formKey.currentState!.validate()) {
                                  Sign(context);
                                }
                              }
                            },
                            child: Text(
                              "Sign Up",
                              style: GoogleFonts.rubik(color: Colors.white,fontSize: 15),
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

    if (cp.isEmpty=="" &&
        est.isEmpty=="" &&
        pass.isEmpty=="" &&
        pword.isEmpty=="" &&
        comadd.isEmpty=="" &&
        num.isEmpty==""&&
        email.isEmpty==""&&
        name.isEmpty==""&&
        dob.isEmpty==""&&
        selectedOption=="No"
    ) {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Please fill out all the fields"),
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }
    if (name=="") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Enter Name"),
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }

    if (dobcontroller=="") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Fill date of birth"),
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }

    if (pass != pword) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Passwords do not match"),
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }
    if (selectedOption=="No") {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Accept the terms and conditions"),
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
      );
      return false;
    }
    return true;

  }
  Sign(context) async{
    print("hello i am call $codepin && and $selectedValues");
    List<String> parts = pinselected!.split('(');
    String name = parts[0];
    String code = parts[1].replaceAll(')', '');
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["company_name"] = namecontroller.text;
    map["person_charge"] = cpcontroller.text;
    map["position"] = dobcontroller.text;
    map["company_email"] = emcontroller.text;
    map["company_phone"] = numcontroller.text;
    map["company_address"] = comaddcontroller.text;
    map["privacy_policy"] = selectedOption.toString();
    map["password"] = passcontroller.text;
    map["state"]=locselected.toString();
    map["city"]=selectedValues;
    map["pincode"]=codepin;
    map["user_type"]=type.toString();
    map["fcm_token"]=token.toString();

    var res = await http.post(Uri.parse("$mainurl/signup.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("harleen $map");
    print(jsondata);
    user_id=jsondata["user_id"].toString();
    print(user_id);
    var er = jsondata["error"];
    if (res.statusCode == 200) {

      if(er==0){
        cont();
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Email or Mobile already have an account"),
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
            // This ensures that tapping on the modal sheet itself doesn't dismiss it.
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

                        child:
                        Column(
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
                            SizedBox(height: 10,),
                            Text(
                              "Enter 4 digit code that you have recieved on your email.",
                              style: GoogleFonts.rubik(color: Colors.grey),
                            ),
                            SizedBox(height: 20,),
                            Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.center,
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
                                                width: MediaQuery.of(context).size.width / 7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(
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
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                        border: InputBorder.none,
                                                      ),

                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:  MediaQuery.of(context).size.width / 7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(
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
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:  MediaQuery.of(context).size.width / 7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(
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
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width:  MediaQuery.of(context).size.width / 7,
                                                child: Card(
                                                  color: Color.fromARGB(
                                                      255, 208, 208, 208),
                                                  elevation: 0,
                                                  child: Padding(
                                                    padding: EdgeInsets.fromLTRB(
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
                                                      keyboardType: TextInputType.number,
                                                      decoration: InputDecoration(
                                                          border: InputBorder.none),

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
                            SizedBox(height: 30,),
                            Padding(
                              padding: const EdgeInsets.all(15),
                              child: Container(
                                  width: double.infinity,
                                  height: 45,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFF118743),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10))),
                                    onPressed: () {
                                      print("Controller 1: ${controller1.text}");
                                      print("Controller 2: ${controller2.text}");
                                      print("Controller 3: ${controller3.text}");
                                      print("Controller 4: ${controller4.text}");
                                      print("${controller1.text}${controller2.text}${controller3.text}${controller4.text}");
                                      otp="${controller1.text}${controller2.text}${controller3.text}${controller4.text}";
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
                        )

                    ),
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

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        print("Ritesh Singh");
        var pref = await SharedPreferences.getInstance();
        pref.setString(LoginState.SESSIONID, jsondata["session"]);
        pref.setString(LoginState.USERID, jsondata["user_id"]);
        pref.setString(LoginState.USERTYPE, jsondata["user_type"]);
        await fetchData();
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => Emphome()),
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
          });
          if(pinselected=="" || pinselected==null){
            PinCode(context);
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
