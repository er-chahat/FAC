import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Cp extends StatefulWidget {
  const Cp({super.key});

  @override
  State<Cp> createState() => _CpState();
}

class _CpState extends State<Cp> {

  bool _isObscur = true;
  bool _isObscuree = true;
  bool _isObscureee = true;
  String pas = "";
  String pass = "";
  String passs = "";
  TextEditingController pascontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();
  TextEditingController passscontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Change Password",
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
      body: GestureDetector(
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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                            "Change Password",
                            style: GoogleFonts.rubik(
                                fontSize: 24, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Set the new password for your account so you can login and access all the features.",
                            style: GoogleFonts.rubik(color: Colors.grey),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Column(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: passscontroller,
                                  obscureText: _isObscuree,
                                  cursorColor: Color(0xFF2c444e),
                                  onChanged: (text) {
                                    setState(() {
                                      passs = text;
                                    });
                                  },
                                  style: GoogleFonts.montserrat(),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      // Remove border color
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscuree
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscuree = !_isObscuree;
                                        });
                                      },
                                    ),
                                    hintText: "Old-Password",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: pascontroller,
                                  obscureText: _isObscuree,
                                  cursorColor: Color(0xFF2c444e),
                                  onChanged: (text) {
                                    setState(() {
                                      pas = text;
                                    });
                                  },
                                  style: GoogleFonts.montserrat(),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      // Remove border color
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscuree
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscuree = !_isObscuree;
                                        });
                                      },
                                    ),
                                    hintText: "New Password",
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 8),
                                child: TextField(
                                  controller: passcontroller,
                                  obscureText: _isObscur,
                                  cursorColor: Color(0xFF2c444e),
                                  onChanged: (text) {
                                    setState(() {
                                      pass = text;
                                    });
                                  },
                                  style: GoogleFonts.montserrat(),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding:
                                    EdgeInsets.symmetric(horizontal: 16),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      // Remove border color
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    border: OutlineInputBorder(
                                      borderSide:
                                      BorderSide(color: Colors.white),
                                      borderRadius: BorderRadius.circular(
                                          25.0), // Set the border radius
                                    ),
                                    suffixIcon: IconButton(
                                      icon: Icon(
                                        _isObscur
                                            ? Icons.visibility_off_outlined
                                            : Icons.visibility_outlined,
                                        color: Colors.grey,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _isObscur = !_isObscur;
                                        });
                                      },
                                    ),
                                    hintText: "Re-enter New Password",
                                  ),
                                ),
                              ),
                              if (pas.isNotEmpty && pass.isNotEmpty && pas != pass)
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: Text(
                                    "Passwords do not match",
                                    style: TextStyle(color: Colors.red),
                                  ),
                                ),
                              SizedBox(height: 300,),
                              Container(
                                  width: double.infinity,
                                  height: 45,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFF118743),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10))),
                                    onPressed: () {
                                      cpp(context);
                                    },
                                    child: Text(
                                      "Change Password",
                                      style: GoogleFonts.rubik(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  )),
                            ],
                          ),
                        ],
                      )),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

  cpp(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["password"] = passscontroller.text ;
    map["new_password"] = passcontroller.text;



    var res = await http.post(Uri.parse("$mainurl/change_password.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Password updated"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        Future.delayed(Duration(seconds: 2),(){
          Navigator.pushNamed(context, "drawer");
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"].toString()),
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
