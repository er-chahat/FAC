import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/login.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future fetchData() async {
  var pref = await SharedPreferences.getInstance();
  user_id = pref.getString(LoginState.USERID) ?? "";
  session_id = pref.getString(LoginState.SESSIONID) ?? "";
  type = pref.getString(LoginState.USERTYPE) ?? "";
}