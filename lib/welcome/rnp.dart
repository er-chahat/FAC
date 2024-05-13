import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:fac/home/drawres.dart';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/signup.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var im="";

class Rnp extends StatefulWidget {
  final Function(String) callback;
  Rnp({required this.callback});

  @override
  State<Rnp> createState() => _RnpState();
}


class _RnpState extends State<Rnp> {
  String? filePath;
  FilePickerResult? result;
  String? base64PDF;
  var file_type;
  bool isLoading = false;


 Future pickFile() async {
   print("I am HEREREEEEEEE");
   try{
      result =
     await FilePicker.platform.pickFiles(
       type: FileType.custom,
       allowedExtensions: ['pdf', 'doc', 'docx'],
     );
   }
   catch (e){
     print("ERROOORRRRRRRRRRRRRR==== $e");
   }


    if (result != null) {
      PlatformFile file = result!.files.first;


      setState(() {
        filePath = file.name;
      });

      print("File path: ${file.path}");
      print("File path::::::::::::::::::::::::::::::::::::::  ${file.extension}");
      print("File name: ${file.name}");
      print("File size: ${file.size}");

      List<int> pdfBytes = await File(file.path!).readAsBytes();
      setState(() {
        file_type=file.extension;
        base64PDF = base64Encode(pdfBytes);
      });
      print("Base64 encoded PDF: $base64PDF");

    }
  }


  @override
  Widget build(BuildContext context) {
    Color buttonColor = filePath != null && filePath!.isNotEmpty
        ? Color(0xFF118743)
        : Colors.grey;
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            widget.callback("");
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Resume & Portfolio", style: GoogleFonts.rubik()),
        actions: [
          TextButton(onPressed: (){
            Navigator.pushNamed(context, "wel");
          },
              child: Text("Skip",style: GoogleFonts.rubik(color: Color(0xFF118743),fontWeight: FontWeight.w600),))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Resume or CV",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 20),
                ),
                SizedBox(height: 40),
                Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                        style: BorderStyle.solid,
                      ),
                        borderRadius: BorderRadius.circular(20.0),
                    ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        SizedBox(height: 30,),
                        if(base64PDF==null||base64PDF=="")
                        Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Text("Upload your CV or Resume and use it when you apply for jobs.",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),
                        ),
                        if(base64PDF!=null)
                          Padding(
                            padding: const EdgeInsets.all(16),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  ),
                                ],
                                color: Colors.white54,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    Image(image: AssetImage("assets/pdf.png")),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Expanded(
                                      child: Text("$filePath",style: GoogleFonts.rubik(), maxLines: 3,
                                        overflow: TextOverflow.ellipsis,softWrap: false,),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ),
                        SizedBox(height: 30,),
                        Container(
                          width: 150,
                          height: 50,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF118743),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10))),
                            onPressed: () async {
                              await pickFile();
                              print("ok");

                            },
                            child: Text(
                              "Select",
                              style: GoogleFonts.rubik(
                                  color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 200),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed:filePath != null && filePath!.isNotEmpty
                      ?() async {
                      print("hiiii");

                      await upload(context);

                    }
                        :null,

                    child:  Text(
                      "Save",
                      style: GoogleFonts.rubik(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),

              ]
          ),
        ),
      ),
    );
  }

  upload(context) async {
   print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["resume_cv"] = base64PDF ?? "";
    map["file_type"] =  file_type.toString()?? "";

    var res = await http.post(Uri.parse("$mainurl/resume_uplode.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                height: 250,
                width: 50,
                child: Center(
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                            height: 120,
                            width: 120,
                            child: Image.asset(
                                "assets/thumbb.png")),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Uploaded",
                        style: GoogleFonts.rubik(
                            fontWeight:
                            FontWeight.w500,
                            fontSize: 20),
                      ),
                      Text(
                        "Successfully",
                        style: GoogleFonts.rubik(
                            fontWeight:
                            FontWeight.w500,
                            fontSize: 20),
                      ),
                      SizedBox(height: 20),

                    ],
                  ),
                ),
              ),
            );
          },
        );
        Future.delayed(const Duration(seconds: 2), () {

          setState(() {
            im=base64PDF!;
          });
          if(inside==true){
            //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Drawres(),), (route) => false);
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callback("");
            //Navigator.pushNamed(context, "wel");
          }
          else if(inside==false){
            // Navigator.pushNamed(context, "mp");
            Navigator.pop(context);
            Navigator.pop(context);
            widget.callback("");
          }

        });







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
   setState(() {
     isLoading = false;
   });
  }

}
