import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Social extends StatefulWidget {
  final Function(String) callback;
  Social({required this.callback});

  @override
  State<Social> createState() => _SocialState();
}

class _SocialState extends State<Social> {

  String fb ="";
  String insta ="";
  String twit ="";
  String link ="";
  TextEditingController fbcontroller = TextEditingController();
  TextEditingController instacontroller = TextEditingController();
  TextEditingController twitcontroller = TextEditingController();
  TextEditingController linkcontroller = TextEditingController();


  @override
  void initState() {
    super.initState();
    view(context);
  }


  @override
  Widget build(BuildContext context) {
    return  Container(
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
            padding: const EdgeInsets.only(left: 10,right: 10,top: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "Add Social Media Profile",
                  style: GoogleFonts.rubik(
                      fontSize: 24, fontWeight: FontWeight.w600),
                ),
                // SizedBox(
                //   height: 20,
                // ),
                // Text(
                //   "Lorem Ipsum is simply dummy text of the printing and typesetting",
                //   style:
                //   GoogleFonts.rubik(fontSize: 15, color: Colors.grey),
                //   textAlign: TextAlign.center,
                // ),
                SizedBox(height: 100),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: instacontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            insta = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
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
                          hintText: "Instagram Profile Url",
                        ),
                      ),
                      Text("  Url Example:https://www.instagram.com/in/your_profile",style: GoogleFonts.rubik(fontSize: 10),)
                    ],
                  ),
                ),

                SizedBox(height: 25),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: linkcontroller,
                        cursorColor: Color(0xFF118743),
                        onChanged: (text) {
                          setState(() {
                            link = text;
                          });
                        },
                        style: GoogleFonts.rubik(),
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
                          hintText: "LinkedIn Profile Url",
                        ),
                      ),
                      Text("  Url Example:https://www.linkedin.com/in/your_profile",style: GoogleFonts.rubik(fontSize: 10),)
                    ],
                  ),
                ),


                SizedBox(height: 250),
                Padding(
                  padding: const EdgeInsets.all(25),
                  child: Container(
                      width: double.infinity,
                      height: 47,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF118743),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          so(context);
                        },
                        child: Text(
                          "Update",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 17),
                        ),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  so(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["instagram_url"] = instacontroller.text;
    map["linkedin_url"] = linkcontroller.text;



    var res = await http.post(Uri.parse("$mainurl/social_link_add.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if(inside==true){
          setState(() {
            widget.callback("");
          });
          Navigator.pop(context);
         // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Wel(),), (route) => false);
          //Navigator.pushNamed(context, "wel");
        }
        else if(inside==false){
          setState(() {
            widget.callback("");
          });
          Navigator.pop(context);
          //Navigator.pushNamed(context, "rnp");
        }

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
    } else {
      print('error');
    }
  }

  view(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/socail_media_view.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        instacontroller.text=jsondata["instagram_url"];
        linkcontroller.text= jsondata["linkedin_url"];
      } else {

      }
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


}
