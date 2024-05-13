import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/single.dart';
import 'package:fac/welcome/choose.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class Ratingss extends StatefulWidget {
  const Ratingss({super.key});

  @override
  State<Ratingss> createState() => _RatingssState();
}

class _RatingssState extends State<Ratingss> {
  var rateme = "";
  String? rati = "";
  TextEditingController ratingcontroller = TextEditingController();

  Future<bool> _onWillPop() async {

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Single()));

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Color(0xFFfafafd),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text("Ratings", style: GoogleFonts.rubik()),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
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
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Rate The Candidate",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w600, fontSize: 17),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "Your Experience:",
                      style: GoogleFonts.rubik(),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    RatingBar.builder(
                      initialRating: 0,
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                      itemBuilder: (context, _) => Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {
                        print(rating);
                        setState(() {
                          rateme = rating.toString();
                          print("------->>");
                          print(rateme);
                          print("------->>");

                        });
                      },
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        Text(
                          "Write Review",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600, fontSize: 17),
                        ),
                        Text(
                          "*",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w600,
                              fontSize: 17,
                              color: Colors.red),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      minLines: 4,
                      maxLines: 10,
                      controller: ratingcontroller,
                      cursorColor: Color(0xFF118743),
                      onChanged: (text) {
                        setState(() {
                          rati = text;
                        });
                      },
                      style: GoogleFonts.rubik(),
                      // validator: (value) {
                      //   if (value!.isEmpty) {
                      //     return 'This field is required';
                      //   }
                      //   return null;
                      // },
                      //autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
                        hintText: "Write a Review..",
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.2,
                    ),
                    Container(
                        width: double.infinity,
                        height: 50,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF118743),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Rateee(context);
                          },
                          child: Text(
                            "Next",
                            style: GoogleFonts.rubik(
                                color: Colors.white, fontSize: 17),
                          ),
                        )),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        bottomNavigationBar: Bottom(),
      ),
    );
  }

  Rateee(context) async {
    HashMap<String, String> map = HashMap();
    print("****-----*****");
    map["updte"] = "1";
    map["jop_id"] = app_id;
    map["user_id"] = uuser;
    map["user_type"] = "Employer";
    map["employer_id"] = user_id;
    map["review"] = ratingcontroller.text;
    map["rating"] = rateme.toString();
    print("i harleen here  $map");


    var res = await http.post(Uri.parse("$mainurl/send_review.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                  height: 300,
                  width: 50,
                  child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image(image: AssetImage("assets/Done.png")),
                          SizedBox(height: 10,),
                          Text(
                            "Review Posted Successfully",
                            style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 17),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ))),
            ));
        Future.delayed(const Duration(seconds: 2), () {
         _onWillPop();
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"],style: GoogleFonts.rubik(),),
            duration: Duration(seconds: 2),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    }
  }
}
