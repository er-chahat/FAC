import 'dart:convert';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class SeeReviewUser extends StatefulWidget {
  const SeeReviewUser({super.key});

  @override
  State<SeeReviewUser> createState() => _SeeReviewUserState();
}

class _SeeReviewUserState extends State<SeeReviewUser> {
  List<Map<String, dynamic>> reviews = [];


  @override
  void initState() {
    seeehere();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Reviews"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var review in reviews)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                      color: Colors.white,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              if(review["profile_img"]!="")
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: NetworkImage("$photo/${review["profile_img"]}"),
                                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200], // Placeholder background color
                                            borderRadius: BorderRadius.circular(8), // Adjust as needed
                                          ),
                                          child: Icon(
                                            Icons.photo_library, // Placeholder icon, you can use any icon or asset
                                            size: 30,
                                            color: Colors.grey[400],
                                          ),
                                        );
                                      },
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              if(review["profile_img"]=="")
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: AssetImage("assets/pers.png"),
                                      height: 45,
                                      width: 45,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              SizedBox(width: 20,),
                              Text("${review['user_name'] ?? ''}",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 17),),
                              Spacer(flex: 2,),
                              Column(
                                children: [
                                  RatingBarIndicator(
                                    rating: review["rating"].toDouble(),
                                    itemBuilder: (context, index) => Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                    ),
                                    itemCount: 5,
                                    itemSize: 20,
                                    direction: Axis.horizontal,
                                  ),
                                  Text("${review['review_date'] ?? ''}"),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Text("${review['review'] ?? ''}")
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> seeehere() async {
    Map<String, String> map = {
      "updte": "1",
      "user_type": "Employer",
      "user_id": mr_navtej.toString(),
    };
    final response = await http.post(
      Uri.parse('$mainurl/review_history.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print("nn");
    print(jsondata);
    if (response.statusCode == 200) {
      print("okkkkkk");
      setState(() {
        reviews = List.from(jsondata['reviews']);
      });
    } else {
      print(jsondata["error"]);
    }
  }
}
