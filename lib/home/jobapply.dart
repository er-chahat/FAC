import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:fac/home/mainprofile.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Jobapply extends StatefulWidget {
  const Jobapply({super.key});

  @override
  State<Jobapply> createState() => _JobapplyState();
}

class _JobapplyState extends State<Jobapply> {
  var file_type;

  String cl="";
  TextEditingController clcontroller=TextEditingController();
  String name="";
  TextEditingController namecontroller=TextEditingController();
  String numb="";
  TextEditingController numbcontroller=TextEditingController();
  String email="";
  TextEditingController emailcontroller=TextEditingController();


  String? filePath;
  FilePickerResult? result;
  String? base64PDF;
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
      print("File name: ${file.name}");
      print("File size: ${file.size}");

      List<int> pdfBytes = await File(file.path!).readAsBytes();
      setState(() {
        base64PDF = base64Encode(pdfBytes);
        file_type=file.extension;
      });
      print("Base64 encoded PDF: $base64PDF");

    }
  }
  final _formKey = GlobalKey<FormState>();

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
        title: Text("Apply", style: GoogleFonts.rubik(fontWeight: FontWeight.w500)),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Row(
                  children: [
                    Text("Cover Letter",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20),),
                    SizedBox(width: 5,),
                    Text("(Optional)",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 17),),
                  ],
                ),
                SizedBox(height: 15,),
                TextField(
                  controller: clcontroller,
                  minLines: 3,
                  maxLines: 17,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      cl = text;
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
                      hintText: "Write a cover letter...",
                      hintStyle: GoogleFonts.rubik(color: Colors.grey)),
                ),
                SizedBox(height: 10,),

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
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      children: [
                        SizedBox(height: 10,),
                        if(base64PDF==null||base64PDF=="")
                          Padding(
                            padding: const EdgeInsets.only(left: 30,right: 30),
                            child: Text("Upload your CV or Resume",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 14),textAlign: TextAlign.center,),
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
                SizedBox(height: 10,),
                TextField(
                  controller: namecontroller,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      name = text;
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
                      hintText: "Name",
                      hintStyle: GoogleFonts.rubik(color: Colors.grey)),
                ),
                SizedBox(height: 10,),
                TextField(
                  controller: numbcontroller,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      numb = text;
                    });
                  },
                  style: GoogleFonts.rubik(),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
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
                    hintText: "Mobile Number",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey),
                  ),
                ),
                SizedBox(height: 10,),
                TextFormField(
                  controller: emailcontroller,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      email = text;
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
                    hintText: "Confirm Email",
                    hintStyle: GoogleFonts.rubik(color: Colors.grey),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }
                    final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@[a-zA-Z0-9-]+(\.[a-zA-Z]{2,})+$');

                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },

                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                Applyjob(context);
              }
            },
            child: Text(
              "Apply Now",
              style: GoogleFonts.baloo2(color: Colors.white,fontSize: 20),
            ),
          ),
        ),
      ),
    );
  }
  Applyjob(context) async {
    HashMap<String, String> map = HashMap();
    if(base64PDF!=null && base64PDF!="" &&emailcontroller.text!="" && numbcontroller.text!="" && namecontroller.text!="")
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["jop_vacancy_id"] = con_id;
    map["confirm_email"] = emailcontroller.text;
    map["mobile_number"] = numbcontroller.text;
    map["name"] = namecontroller.text;
    map["cover_later"] = clcontroller.text;
    map["user_resume"] = base64PDF ?? "";
    map["file_type"] =  file_type.toString()?? "";


    var res = await http.post(Uri.parse("$mainurl/user_apply_jop.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::::::::::::::: :$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {

        Navigator.pushNamed(context, "suc");
        Future.delayed(Duration(seconds:3),(){
          Navigator.popUntil(context, (route) => route.isFirst);
          //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
        });

      } else if(jsondata["error"]== 1){
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Fill the form properly"),
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

}
