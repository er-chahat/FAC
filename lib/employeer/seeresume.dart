import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/subscription.dart';
import 'package:http/http.dart'as http;
import 'package:fac/employeer/emphome.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class Seeresume extends StatefulWidget {
  const Seeresume({super.key});

  @override
  State<Seeresume> createState() => _SeeresumeState();
}

class _SeeresumeState extends State<Seeresume> {
  var errormsgg="";

  var rr = "";
  bool isLoading = true;
  var membert="";
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
          membert=jsondata["membership_type"];
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

  @override
  void initState() {
    seeresume(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "See Resume", style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body:  isLoading
          ? Center(
        child: Container(
          padding: EdgeInsets.all(25),
          width: double.infinity,
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
              ),
            ],
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Image(image: AssetImage("assets/error.png")),
              Text(
                "$errormsgg",
                style: GoogleFonts.rubik(color: Colors.black,fontSize: 17,fontWeight: FontWeight.w400),textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      )
          : (rr.isNotEmpty
          ? SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SfPdfViewer.network('$c_v/$rr')),
      )
          : Center(
        child: Text("No resume available"),
      )),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(10),
        child: Container(
            width: double.infinity,
            height: 45,
            child: TextButton(
              style: TextButton.styleFrom(
                  backgroundColor: Color(0xFF118743),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Back",
                style: GoogleFonts.rubik(
                    color: Colors.white, fontSize: 15),
              ),
            )),
      ),
    );
  }

  seeresume(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_apply_jop_id"] = iid.toString();
    map["user_id"]=user_id.toString();

    var res = await http.post(
        Uri.parse("$mainurl/user_applied_jops_resume_show.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          rr = jsondata["user_resume"];
          isLoading = false;
        });
        print("PDF URL: $c_v/${jsondata["user_resume"]}");
      } else {
        setState(() {
          errormsgg = jsondata["error_msg"];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription(callback: callback_mem)));


      }
    }
  }
}
