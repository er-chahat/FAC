import 'dart:convert';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/single.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';
class SeeReviewsEmp extends StatefulWidget {
  const SeeReviewsEmp({super.key});

  @override
  State<SeeReviewsEmp> createState() => _SeeReviewsEmpState();
}

class _SeeReviewsEmpState extends State<SeeReviewsEmp> {
  List<Map<String, dynamic>> reviews = [];
  bool _isLoading = true;


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
      body:  _isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          :reviews.length>0?SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
             if(reviews.isNotEmpty||reviews!=null)
               for (var review in reviews)
                 Padding(
                   padding: const EdgeInsets.all(10.0),
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
                                           height: 40,
                                           width: 40,
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
              if(reviews.isEmpty)
                Container(
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
                    child: Text(
                      "No Reviews yet",
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500,
                          color: Colors.grey,
                          fontSize: 17),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ):Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
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
                child: Text(
                  "Nothing Yet",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500,
                      color: Colors.grey,
                      fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> seeehere() async {
    Map<String, String> map = {
      "updte": "1",
      "user_type": "Candidate",
      "user_id":applicant_id,
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
        if(jsondata["rows"]>0)
          reviews = List.from(jsondata['reviews']);
        _isLoading=false;
      });
    } else {
      print(jsondata["error"]);
    }
  }
}
