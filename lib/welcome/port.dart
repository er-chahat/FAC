import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
class Port extends StatefulWidget {
  var isEdit;
  var port_id;
  final Function(String) callback;
  Port({required this.callback,this.isEdit,this.port_id});

  @override
  State<Port> createState() => _PortState();
}

class _PortState extends State<Port> {
  File? _id;
  var base64Id;
  var loading = false;
  String po = "";
  String des = "";
  TextEditingController poController = TextEditingController();
  TextEditingController descontroller = TextEditingController();

  Future imagepicker() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _id = File(pickedImage.path);
        List<int> imageBytes = _id!.readAsBytesSync();
        base64Id = base64Encode(imageBytes);
      });
    }
    print(
        "i\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n mage = $base64Id \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
  }

  @override
  Widget build(BuildContext context) {
    Color buttonColor = base64Id != null && base64Id!.isNotEmpty
        ? Color(0xFF118743)
        : Colors.grey;
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
        title: widget.isEdit==true?Text("Portfolio Edit", style: GoogleFonts.rubik()):Text("Portfolio Upload", style: GoogleFonts.rubik()),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Upload Portfolio",
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
                        _id != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(_id!, fit: BoxFit.cover),
                        )
                            : Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Text("Upload Image",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),
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
                              imagepicker();
                              print("ok");

                            },
                            child: Text(
                              "Upload",
                              style: GoogleFonts.rubik(
                                  color: Colors.white, fontSize: 17),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text(
                  "Portfolio Title",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w500, fontSize: 17),
                ),
                SizedBox(
                  height: 15,
                ),
                TextField(
                  controller: poController,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      po = text;
                    });
                  },
                  style: GoogleFonts.rubik(),
                  decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
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
                      hintText: "title",
                      hintStyle: GoogleFonts.rubik(color: Colors.grey)),
                ),
                SizedBox(height: 20,),
                Text(
                  "Portfolio Description",
                  style: GoogleFonts.rubik(
                      fontWeight: FontWeight.w600, fontSize: 17),
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: descontroller,
                  maxLines: 7,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      des = text;
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
                      hintText: "description",
                      hintStyle: GoogleFonts.rubik(color: Colors.grey)),
                ),

                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  height: 50,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: buttonColor,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed:base64Id != null && base64Id!.isNotEmpty
                        ?() async {
                      setState(() {
                        loading=true;
                      });
                      print("hiiii");
                      if(widget.isEdit==false)
                        Des(context);
                      if(widget.isEdit==true)
                        editPort(context);
                    }
                        :null,

                    child:  loading==true?Center(child: CircularProgressIndicator(color: Colors.white,)):Text(
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
  Des(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["portfolio_title"] = poController.text;
    map["portfolio_description"]= descontroller.text;
    map["portfolio_image"]=base64Id;


    var res = await http.post(Uri.parse("$mainurl/portfolio_upload.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      setState(() {
        loading=false;
      });
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
                        "Sucessfully",
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
        Future.delayed(Duration(seconds: 2), (){
          Navigator.pop(context);
          Navigator.pop(context);
          widget.callback("");
        });

        //Navigator.pushNamedAndRemoveUntil(context, "wel",(route) => false);
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);

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
      setState(() {
        loading=false;
      });
      print('error');
    }
  }
  editPort(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["portfolio_id"] = widget.port_id;
    map["portfolio_title"] = poController.text;
    map["portfolio_description"]= descontroller.text;
    map["portfolio_image"]=base64Id;


    var res = await http.post(Uri.parse("$mainurl/portfolio_update.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh edit edit $map");
    print("edit deiijef jkjfjejf ${jsondata}");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      setState(() {
        loading=false;
      });
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
                        "Sucessfully",
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
        Future.delayed(Duration(seconds: 2), (){
          Navigator.pop(context);
          Navigator.pop(context);
          if(Navigator.canPop(context))
            Navigator.pop(context);
          widget.callback("");
        });

        //Navigator.pushNamedAndRemoveUntil(context, "wel",(route) => false);
        //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);

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
      setState(() {
        loading=false;
      });
      print('error');
    }
  }

}
