import 'dart:collection';
import 'dart:convert';
import 'package:fac/welcome/cont.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:fac/starting/splashscreen.dart';

class Forgot with ChangeNotifier {
  bool isLoading = false;
  setLoadingTrue() {
    isLoading = true;
    notifyListeners();
  }

  setLoadingFalse() {
    isLoading = false;
    notifyListeners();
  }

  Future forgot(context, String email) async {
    setLoadingTrue();
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["email_id"] = email;
    var res = await http.post(Uri.parse("$mainurl/forget_password.php"),
        body: jsonEncode(map));
    print("####################\n\n\n");
    print(map);
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        setLoadingFalse();
        Navigator.pop(context);
        showModalBottomSheet<void>(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.0),
          ),
          context: context,
          builder: (BuildContext context) {
            return Cont(
              emcontroller: email,
            );
          },
        );
      } else {
        setLoadingFalse();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("${jsondata["error_msg"]}"),
            duration: const Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
      setLoadingFalse();
    } else {
      setLoadingFalse();
      print('error');
    }
    setLoadingFalse();
  }
}