import 'dart:collection';
import 'dart:convert';

import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/login.dart';
import 'package:fac/welcome/reset.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;

class VerifyFg with ChangeNotifier {
  bool isLoading = false;
  setloadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setloadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  Future verify_fg(context, String em, String otpp) async {
    setloadingTrue();
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["email_id"] = em;
    map["email_otp"] = otpp;

    try {
      var res = await http.post(Uri.parse("$mainurl/forget_email_verify.php"),
          body: jsonEncode(map));
      print(res.body);

      dynamic jsondata = jsonDecode(res.body);

      for_uid = jsondata["user_id"];
      print(for_uid);
      if (res.statusCode == 200) {
        if (jsondata["error"] == 0) {
          Navigator.pop(context);
          print("i am here nnnnnnnnnnnnh $map");
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Reset(),
              ));
          setloadingFalse();
        } else {
          print("YOU ARE HEREEEEEEEEEEEEEEEEEE");
          Fluttertoast.showToast(msg: "Invalid OTP");
          setloadingFalse();

          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("Wrong Otp"),
          //     duration: Duration(seconds: 2),
          //     shape:
          //         RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          //   ),
          // );
        }
      } else {
        Fluttertoast.showToast(msg: "Invalid OTP");
        setloadingFalse();
        print('error');
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "Invalid OTP");
      setloadingFalse();
    }
  }
}