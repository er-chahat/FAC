import 'dart:collection';
import 'dart:convert';

import 'package:fac/employeer/emphome.dart';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/fetchdata.dart';
import 'package:fac/welcome/login.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Vlogin with ChangeNotifier {
  bool isLoading = false;
  setloadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setloadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  Future V_login(context, String email, String otp) async {
    setloadingTrue();
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["email_id"] = email;
    map["email_otp"] = otp;

    var res = await http.post(Uri.parse("$mainurl/signin_verify.php"),
        body: jsonEncode(map));
    print(res.body);
    print(otp);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        // Navigator.pushNamed(context, "wel");
        var pref = await SharedPreferences.getInstance();
        pref.setBool(LoginState.LOGIN ,true );
        pref.setString(LoginState.USERID, jsondata["user_id"]);
        pref.setString(LoginState.USERTYPE, jsondata["user_type"]);
        pref.setString(LoginState.SESSIONID, jsondata["session"]);
        await fetchData();
        if (type == "User") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Mainprofile(),
              ),
                  (route) => false);
        } else if (type == "Employer") {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(
                builder: (context) => Emphome(),
              ),
                  (route) => false);
        }

        session_id = jsondata["session"];

        print(session_id);
        setloadingFalse();
      } else {
        setloadingFalse();
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
      setloadingFalse();
      print('error');
    }
    setloadingFalse();
  }
}