import 'dart:collection';
import 'dart:convert';

import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:http/http.dart' as http;

class Reseted with ChangeNotifier {
  bool isLoading = false;
  setloadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setloadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  Future reseted(
      BuildContext context, String passcontroller, String for_uid) async {
    setloadingTrue();
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["password"] = passcontroller;
    map["user_id"] = for_uid;
    try {
      var res = await http.post(Uri.parse("$mainurl/update_password.php"),
          body: jsonEncode(map));
      print(res.body);
      dynamic jsondata = jsonDecode(res.body);
      print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
      print(jsondata);

      if (res.statusCode == 200) {
        if (jsondata["error"] == 0) {
          Future.delayed(const Duration(seconds: 3), () {
            setloadingFalse();
            Navigator.pushNamed(context, "login");
          });
          setloadingFalse();
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                backgroundColor: Colors.white,
                content: SizedBox(
                  height: 350,
                  width: 50,
                  child: Center(
                    child: Column(
                      children: [
                        Center(
                          child: SizedBox(
                              height: 120,
                              width: 120,
                              child: Image.asset("assets/thumbb.png")),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Password Updated",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        Text(
                          "Sucessfully",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w500, fontSize: 20),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          "Your password has been updated sucessfully",
                          style: GoogleFonts.rubik(color: Colors.grey),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.all(10),
                          child: SizedBox(
                              width: 200,
                              child: TextButton(
                                onPressed: () {
                                  Navigator.pushNamed(context, "login");
                                },
                                style: TextButton.styleFrom(
                                    backgroundColor: const Color(0xFF118743),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(10))),
                                child: Text(
                                  "Back To Login",
                                  style: GoogleFonts.rubik(color: Colors.white),
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
          setloadingFalse();
        } else {
          setloadingFalse();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something Went Wrong"),
              duration: Duration(seconds: 2),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      } else {
        setloadingFalse();

        print('error');
      }
    } catch (e) {
      setloadingFalse();
    }

    setloadingFalse();
  }
}