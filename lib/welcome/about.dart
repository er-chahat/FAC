import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class About extends StatefulWidget {
  final Function(String) callback;
  About({required this.callback});
  @override
  State<About> createState() => _AboutState();
}

class _AboutState extends State<About> {
  String ab="";
  TextEditingController abcontroller=TextEditingController();

  @override
  void initState() {
    super.initState();
    viewabout(context);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            if(Navigator.canPop(context)){
              setState(() {
                widget.callback("");
              });
              Navigator.pop(context);
            }

          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("About Me", style: GoogleFonts.rubik()),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "About Me",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w500, fontSize: 20),
              ),

              SizedBox(
                height: 10,
              ),
              Text("Resume headline is what recruiters read first about you. Add your own.",
                  style: GoogleFonts.rubik(fontSize: 14)),
              SizedBox(
                height: 30,
              ),
              Text(
                "About Me",
                style: GoogleFonts.rubik(
                    fontWeight: FontWeight.w400, fontSize: 17),
              ),
              SizedBox(height: 15,),
              TextField(
                controller: abcontroller,
                maxLines: 7,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    ab = text;
                  });
                },
                style: GoogleFonts.rubik(),
                decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(16),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: "About me",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey)),
              ),



              SizedBox(height: 250),
              Container(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      abb(context);
                    //  Navigator.pushNamed(context, "rnp");
                    },
                    child: Text(
                      "Next",
                      style: GoogleFonts.rubik(color: Colors.white,fontSize: 17),
                    ),

                  )),
            ],
          ),
        ),
      ),
    );
  }

  abb(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["about_me"] = abcontroller.text;


    var res = await http.post(Uri.parse("$mainurl/about_me.php"),
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
         // Navigator.pushNamed(context, "wel");
        }
        else if(inside==false){
          setState(() {
            widget.callback("");
          });
          Navigator.pop(context);
          //Navigator.pushNamed(context, "social");
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

  viewabout(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/user_about_me.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        abcontroller.text=jsondata["about_me"];
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
