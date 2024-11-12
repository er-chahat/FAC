import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../employeer/bottom.dart';
import '../starting/splashscreen.dart';

class UserFAQ extends StatefulWidget {
  const UserFAQ({super.key});

  @override
  State<UserFAQ> createState() => _UserFAQState();
}

class _UserFAQState extends State<UserFAQ> {

  List<Map<String, String>> faqList = [];

  bool what = false;
  bool how = false;
  bool safe = false;
  bool apply = false;
  bool tips = false;
  bool free = false;


  @override
  void initState() {
    ff(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "FAQ",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              for (var faqItem in faqList)
                FaqItem(
                  question: faqItem["question"] ?? "",
                  answer: faqItem["answer"] ?? "",
                ),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

  ff(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(Uri.parse("$mainurl/user_faq.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        setState(() {
          var employerFaqList = jsondata["employer_faq"] as List<dynamic>;
          faqList = employerFaqList
              .map((item) => Map<String, String>.from(item))
              .toList();
        });

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      print('error');
    }

  }

}
class FaqItem extends StatefulWidget {
  final String question;
  final String answer;

  const FaqItem({
    required this.question,
    required this.answer,
  });

  @override
  _FaqItemState createState() => _FaqItemState();
}

class _FaqItemState extends State<FaqItem> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 2,
          ),
        ],
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.question,
                  style: GoogleFonts.rubik(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isExpanded = !isExpanded; // Toggle the value
                    });
                  },
                  child: Icon(
                    isExpanded ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                    color: Color(0xFF118743),
                  ),
                )
              ],
            ),
            if (isExpanded) Divider(),
            Visibility(
              visible: isExpanded,
              child: Text(
                widget.answer,
                style: GoogleFonts.rubik(color: Colors.grey),
              ),
            ),
          ],
        ),
      ),
    );
  }
}