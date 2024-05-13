import 'package:fac/home/drawres.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class OhhHere extends StatefulWidget {
  const OhhHere({super.key});

  @override
  State<OhhHere> createState() => _OhhHereState();
}

class _OhhHereState extends State<OhhHere> {
  @override
  void initState() {
    super.initState();
    print("$d_c/$go");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "", style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(Icons.arrow_back_ios, color: Colors.black,),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
            height: MediaQuery.of(context).size.height * 0.9,
            child: SfPdfViewer.network('$d_c/$go')),
      ),
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
}
