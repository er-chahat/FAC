import 'dart:collection';
import 'dart:convert';
import 'package:fac/main.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/contt.dart';
import 'package:fac/welcome/login.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginAPI with ChangeNotifier {
  bool isLoading = false;
  setloadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setloadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  Future logg(context, String password, String email) async {
    setloadingTrue();
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["password"] = password;
    map["email_id"] = email;
    map["fcm_token"] = token.toString();
    map["user_type"]=type;

    var res = await http.post(Uri.parse("$mainurl/signin.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here  $map");
    print(jsondata);
    var er = jsondata["error"];
    var er_msg = jsondata["error_msg"];
    if (res.statusCode == 200) {
      if (er == 0) {
        user_id = jsondata["user_id"];
        setloadingFalse();
        if(jsondata["user_type"]==type){
          return showModalBottomSheet<void>(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            context: context,
            builder: (BuildContext context) {
              return Contt(
                emailController: email,
              );
            },
          );
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Choose Type Correctly in Previous page"),
              duration: const Duration(seconds: 2),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      } else {
        setloadingFalse();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("$er_msg"),
            duration: const Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
      setloadingFalse();
    } else {
      setloadingFalse();
    }
    setloadingFalse();
  }
}