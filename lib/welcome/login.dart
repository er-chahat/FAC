import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/fetchdata.dart';
import 'package:fac/welcome/keyskills.dart';
import 'package:http/http.dart'as http;
import 'package:fac/API/forgottenPass.dart';
import 'package:fac/API/loginAPI.dart';
import 'package:fac/main.dart';
import 'package:fac/welcome/choose.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

var for_uid = "";
var membertype="";

String prettyPrint(Map json) {
  JsonEncoder encoder = const JsonEncoder.withIndent('  ');
  String pretty = encoder.convert(json);
  return pretty;
}

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => LoginState();
}

class LoginState extends State<Login> {
  
  var fbname="";
  var fbemail="";
  var fbid="";
  void callback2(var data){
    setState(() {

    });
  }
  Map<String, dynamic>? _userData;
  AccessToken? _accessToken;
  bool _checking = true;
  static const String SESSIONID = "sessionId";
  static const String USERID = "userId";
  static const String USERTYPE = "userType";
  bool show = true;
  bool _isObscure = true;
  bool isTapped = true;
  bool isTappedd = false;
  String name = "";
  String pword = "";
  String email = "";
  TextEditingController emcontroller = TextEditingController();

  TextEditingController namecontroller = TextEditingController();
  TextEditingController pwordcontroller = TextEditingController();

  var otp = "";
  var otpp = "";
  String pas = "";
  String pass = "";
  TextEditingController pascontroller = TextEditingController();
  TextEditingController passcontroller = TextEditingController();

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

  final TextEditingController controller7 = TextEditingController();
  final TextEditingController controller8 = TextEditingController();
  final TextEditingController controller9 = TextEditingController();
  final TextEditingController controller10 = TextEditingController();
  final TextEditingController controller11 = TextEditingController();
  final TextEditingController controller12 = TextEditingController();

  final FocusNode focusNode7 = FocusNode();
  final FocusNode focusNode8 = FocusNode();
  final FocusNode focusNode9 = FocusNode();
  final FocusNode focusNode10 = FocusNode();
  final FocusNode focusNode11 = FocusNode();
  final FocusNode focusNode12 = FocusNode();

  Future<void> fcm() async {
    final _firebaseMessaging = FirebaseMessaging.instance;
    final fcmtoken = await _firebaseMessaging.getToken();

    print("Token: $fcmtoken");
    token = fcmtoken.toString();
    print("\n\n\n\nTemp Token::::::::$token\n\n\n\n\n\n");
  }

  @override
  void initState() {
    fcm();
    _checkIfIsLogged();
    super.initState();
  }

    Future<void> _checkIfIsLogged() async {
    final accessToken = await FacebookAuth.instance.accessToken;

    if (accessToken != null) {
      print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
      // now you can call to  FacebookAuth.instance.getUserData();
      final userData = await FacebookAuth.instance.getUserData();
      // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
      _accessToken = accessToken;
      setState(() {
        _userData = userData;
        _printCredentials();
      });
    }
  }

  Future<void> _login() async {
    final LoginResult result = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);

    if (result.status == LoginStatus.success) {
      _accessToken = result.accessToken;
      try {
        final userData = await FacebookAuth.instance.getUserData(fields: "name,email");
        _userData = userData;

      } catch (e) {
        print("Error fetching user data: $e");
      }
    } else {
      print(result.status);
      print(result.message);
    }
    _checkIfIsLogged();

  }

  loginme(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["facebook"] = "facebook";
    map["email_id"] = fbemail;
    map["name"] = fbname;
    map["id"] = fbid;
    map["user_type"] = type;
    map["fcm_token"] = token.toString();

    var res = await http.post(Uri.parse("http://103.99.202.191/fac/api/signin.php"),
        body: jsonEncode(map));
    print("=====infblogin======");
    print(map);
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var pref = await SharedPreferences.getInstance();
    if (res.statusCode == 200) {
      print("yuppsss");
      print(jsondata["session"]);
      print(jsondata["user_id"]);
      print(jsondata["user_type"]);
      pref.setString(LoginState.SESSIONID, jsondata["session"].toString());
      pref.setString(LoginState.USERID, jsondata["user_id"].toString());
      pref.setString(LoginState.USERTYPE, jsondata["user_type"].toString());
      fetchData();

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => Keyskills(callback: callback2,)),
              (route) => false);

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
  }


  void _printCredentials() {
    print("harleen---->");
    print(_userData);
    print("Access Token:");
    print(prettyPrint(_accessToken!.toJson()));
    print(_userData);
    if (_userData != null) {
      print("User Data:");
      print("Name: ${_userData!['name']}");
      print("Email: ${_userData!['email']}");
      print("Email: ${_userData!['id']}");
      setState(() {
        fbname=_userData!['name'];
        fbemail=_userData!['email'];
        fbid=_userData!['id'];

      });
      print("----hey-----");
      print(fbname);
      print(fbemail);
      print(fbid);
      print("-----bye-------");

      print(prettyPrint(_userData!));
      loginme(context);
    }
  }

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
          resizeToAvoidBottomInset: true,
          backgroundColor: Colors.transparent,
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 35, right: 35, top: 90),
                    child: Image(
                      image: const AssetImage("assets/logo.png"),
                      height: MediaQuery.of(context).size.height * 0.20,
                      width: MediaQuery.of(context).size.width * 0.7,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Welcome Back",
                    style: GoogleFonts.rubik(
                        fontSize: 24, fontWeight: FontWeight.w400),
                  ),
                  // const SizedBox(
                  //   height: 5,
                  // ),
                  // Text(
                  //   "You can search course, apply course and find scholarship for abroad studies",
                  //   style: GoogleFonts.rubik(fontSize: 15, color: Colors.grey),
                  //   textAlign: TextAlign.center,
                  // ),
                  const SizedBox(
                    height: 30,
                  ),
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //     children: [
                  //       Container(
                  //           width: MediaQuery.of(context).size.width * 0.43,
                  //           height: 45,
                  //           decoration: BoxDecoration(
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.2),
                  //                 spreadRadius: 2,
                  //                 blurRadius: 2,
                  //               ),
                  //             ],
                  //           ),
                  //           child: TextButton(
                  //             style: TextButton.styleFrom(
                  //                 backgroundColor: Colors.white,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(5))),
                  //             onPressed: () {},
                  //             child: Row(
                  //               mainAxisAlignment:
                  //               MainAxisAlignment.spaceEvenly,
                  //               children: [
                  //                 const Image(
                  //                     image: AssetImage("assets/goog.png")),
                  //                 Text(
                  //                   "Google",
                  //                   style: GoogleFonts.rubik(
                  //                       color: Colors.black54, fontSize: 17),
                  //                 ),
                  //               ],
                  //             ),
                  //           )),
                  //       Container(
                  //           width: MediaQuery.of(context).size.width * 0.43,
                  //           height: 45,
                  //           decoration: BoxDecoration(
                  //             boxShadow: [
                  //               BoxShadow(
                  //                 color: Colors.grey.withOpacity(0.2),
                  //                 spreadRadius: 2,
                  //                 blurRadius: 2,
                  //               ),
                  //             ],
                  //           ),
                  //           child: TextButton(
                  //             style: TextButton.styleFrom(
                  //                 backgroundColor: Colors.white,
                  //                 shape: RoundedRectangleBorder(
                  //                     borderRadius: BorderRadius.circular(5))),
                  //             onPressed: () {
                  //               print("login by fb---------->");
                  //             //  _login();
                  //             },
                  //             child: Row(
                  //               children: [
                  //                 const Image(
                  //                     image: AssetImage("assets/fb.png")),
                  //                 Text(
                  //                   "Facebook",
                  //                   style: GoogleFonts.rubik(
                  //                       color: Colors.black54, fontSize: 17),
                  //                 ),
                  //               ],
                  //             ),
                  //           )),
                  //     ],
                  //   ),
                  // ),
                  // const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: TextField(
                      controller: namecontroller,
                      cursorColor: const Color(0xFF118743),
                      onChanged: (text) {
                        setState(() {
                          name = text;
                        });
                      },
                      style: GoogleFonts.rubik(),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16),
                        enabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          // Set the border color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: const BorderSide(color: Colors.grey),
                          // Set the border color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        hintText: "User",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
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
                          borderSide: BorderSide(color: Colors.grey),
                          // Set the border color
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey),
                          // Set the border color
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
                      ),
                    ),
                  ),
                  SizedBox(height: 15),
                  Container(
                    width: MediaQuery.of(context).size.width / 1.3,
                    height: 45,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        await context.read<LoginAPI>().logg(
                            context, pwordcontroller.text, namecontroller.text);
                      },
                      child: Consumer<LoginAPI>(
                          builder: (context, loginProvider, child) {
                            return loginProvider.isLoading
                                ? const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            )
                                : Text(
                              "Login",
                              style: GoogleFonts.rubik(
                                  color: Colors.white, fontSize: 15),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          fg();
                        },
                        child: Text(
                          "Forgot Password",
                          style: GoogleFonts.rubik(color: Color(0xFF118743)),
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          print(type);
                          if (type == "User") {
                            Navigator.pushNamed(context, "signup");
                          } else if (type == "Employer") {
                            Navigator.pushNamed(context, "signupp");
                          }
                        },
                        child: Text(
                          "Don't have an account? Join us",
                          style: GoogleFonts.rubik(color: Color(0xFF118743)),
                        ),
                      )),
                ],
              ),
            ),
          ),
        ));
  }


  //forgot password process

  void fg() {
    showModalBottomSheet<void>(
      enableDrag: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      context: context,
      builder: (BuildContext context) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Container(
                padding: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.02),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16)),
                height: MediaQuery.of(context).size.height * 0.5,
                child: Scaffold(
                  extendBodyBehindAppBar: true,
                  body: SingleChildScrollView(
                    padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
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
                                  "Forgot Password",
                                  style: GoogleFonts.rubik(
                                      fontSize: 24,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  "Enter your email for the verification proccess,We will send 4 digits code to your email.",
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 8),
                                  child: TextField(
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
                                      contentPadding:
                                      const EdgeInsets.symmetric(
                                          horizontal: 16),
                                      enabledBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        // Set the border color
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      border: OutlineInputBorder(
                                        borderSide: const BorderSide(
                                            color: Colors.grey),
                                        // Set the border color
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      hintText: "Email",
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: SizedBox(
                                    width: double.infinity,
                                    height: 45,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor:
                                          const Color(0xFF118743),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                      onPressed: () async {
                                        await context
                                            .read<Forgot>()
                                            .forgot(context, emcontroller.text);
                                      },
                                      child: Consumer<Forgot>(
                                        builder:
                                            (context, forgotProvider, child) {
                                          return forgotProvider.isLoading
                                              ? const Center(
                                            child:
                                            CircularProgressIndicator(
                                              color: Colors.white,
                                            ),
                                          )
                                              : Text(
                                            "Continue",
                                            style: GoogleFonts.rubik(
                                                color: Colors.white,
                                                fontSize: 15),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    ).whenComplete(() {
      emcontroller.clear();
    });
  }
}