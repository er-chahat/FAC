import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/subb.dart';
import 'package:fac/welcome/login.dart';
import 'package:http/http.dart' as http;
import 'package:fac/home/Userbottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userdrwa extends StatefulWidget {
  const Userdrwa({super.key});

  @override
  State<Userdrwa> createState() => _UserdrwaState();
}

class _UserdrwaState extends State<Userdrwa> {
  var showsub = false;
  void callback_mem(var data){
    setState(() {
      membershipDetails(context);
    });
  }
  Future<void> membershipDetails(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/prosnal_info.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          membertype=jsondata["membership_type"];
        });
      } else {
        // if(userPorti.isNotEmpty){
        //   userPorti.clear();
        //   portfolioImages.clear();
        // }
      }
    } else {
      print('error');
    }
  }
  Future<void> Delete(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/delete_user.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          logout();
        });
      } else {
        // if(userPorti.isNotEmpty){
        //   userPorti.clear();
        //   portfolioImages.clear();
        // }
      }
    } else {
      print('error');
    }
  }
  Future<void> showSub(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(Uri.parse("$mainurl/subscription_switch.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("::::::::::::::::$jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if(jsondata["user_subscription"]!="Off"){
          setState(() {
            showsub=true;
          });
        }else{
          setState(() {
            showsub=false;
          });
        }

      } else {
        // if(userPorti.isNotEmpty){
        //   userPorti.clear();
        //   portfolioImages.clear();
        // }
      }
    } else {
      print('error');
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    showSub(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Menu",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: Text("")
      ),
      body: WillPopScope(
        onWillPop: ()async{
          return false;
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "wel");
                  },
                  child: Padding(
                    padding: EdgeInsets.all(5),
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEDF9F0),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/person.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Profile",
                            style: GoogleFonts.rubik(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "usermsg");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEDF9F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/contact.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Applications",
                            style: GoogleFonts.rubik(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                if(showsub==true)
                Divider(),
                if(showsub==true)
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEDF9F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/sub.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Subscription",
                            style: GoogleFonts.rubik(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "drawres");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEDF9F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/tnc.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Resumes",
                            style: GoogleFonts.rubik(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "cp");
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFEDF9F0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/key.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Change Password",
                            style: GoogleFonts.rubik(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                   delete();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF9EDED),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Icon(Icons.delete, color: Color(0xFFD31212),),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Delete Account",
                            style: GoogleFonts.rubik(
                                fontSize: 18,
                                color: Color(0xFFD31212),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Divider(),
                GestureDetector(
                  onTap: () {
                    openHere();
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Container(
                      width: double.infinity,
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Color(0xFFF9EDED),
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                width: 35,
                                height: 35,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: AssetImage("assets/exit.png"),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          Text(
                            "Log Out",
                            style: GoogleFonts.rubik(
                                fontSize: 18,
                                color: Color(0xFFD31212),
                                fontWeight: FontWeight.w500),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Userbottom(),
    );
  }

  void openHere() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
            height: 50,
            width: 50,
            child: Center(
                child: Text(
                  "Are You Sure?",
                  style: GoogleFonts.baloo2(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "mp");
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743)),
                    )),
                Spacer(
                  flex: 2,
                ),
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        logout();
                      },
                      child: Text(
                        "Logout",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                      ),
                    )),
              ],
            ),
          )
        ],
      ));

  void delete() => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
            height: 50,
            width: 50,
            child: Center(
                child: Text(
                  "Are You Sure? You Want to Delete Your Account",
                  style: GoogleFonts.baloo2(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                       Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743)),
                    )),
                Spacer(
                  flex: 2,
                ),
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        Delete(context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                      ),
                    )),
              ],
            ),
          )
        ],
      ));

  Future<void> logout() async {
    Map<String, String> map = Map();
    map["updte"] = "1";
    map["session"] = session_id;
    map["user_id"] = user_id;

    final response = await http.post(
      Uri.parse('$mainurl/logout.php'),
      body: jsonEncode(map),
    );

    print(map);

    if (response.statusCode == 200) {
      var pref = await SharedPreferences.getInstance();
      var here = json.decode(response.body);
      print("logout Map Data=============>>>>>>$map");
      print("LOGOUT SUCESSUFULLLLL============>>>>>>$here");
      setState(() {
        user_id = "";
      });
      pref.clear();
      UserbottomState.resetIndex();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Logged out ",
            style: GoogleFonts.baloo2(),
          ),
          duration: Duration(seconds: 1),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => Choose(),
          ),
              (route) => false);
    } else {
      print("Error: Failed to remove item from cart.");
    }
  }
}