import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Tnc extends StatefulWidget {
  const Tnc({super.key});

  @override
  State<Tnc> createState() => _TncState();
}

class _TncState extends State<Tnc> {
  
  var here="";
  
  @override
  void initState() {
    tnn(context);
    super.initState();
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
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0, // Remove elevation
          centerTitle: true,
          title: Text(
            "Terms Of Service",
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
              children: [
                Text(here,style: GoogleFonts.rubik(),)
                ],
            ),
          ),
        ),
      ),
    );
  }

  tnn(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(Uri.parse("$mainurl/terms_conditions.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        setState(() {
          here=jsondata["terms_conditions"];
          print(here);


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
