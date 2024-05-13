import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

var vacancy_id="";
var imggg="";

class Vacancyjob extends StatefulWidget {
  const Vacancyjob({super.key});

  @override
  State<Vacancyjob> createState() => _VacancyjobState();
}

class _VacancyjobState extends State<Vacancyjob> {
String? name="";
String? sal="";
String? des="";
TextEditingController descontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();
TextEditingController salcontroller = TextEditingController();
var abc="";
String amount="";
String unit="";
String pp="";
String oo="";

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

List<String> userSkills = [];
String? locselected;
List<String> userSkillss = [];
String? pinselected;

List<String> itemList = ['Full-Time', 'Part-Time', 'Casual'];
String? selectedItem ;
List<String> itemListt = ['Active', 'Inactive'];
String? selectedItemm;
List<String> itemListtt = ["Beginner", "Intermediate", "Proficient"];
String? selectedItemmm;



File? _image;


var base64Image;


Future imagepicker() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    setState(() {
      _image = File(pickedImage.path);
      List<int> imageBytes = _image!.readAsBytesSync();
      base64Image = base64Encode(imageBytes);
    });
  }
  print(
      "i\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n mage = $base64Image \n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n\n");
}



String selectedText = '';
var ski;


Color radioColor = Colors.grey;
String selectedOption = 'No';
Color radioColorr = Colors.grey;
String selectedOptionn = 'No';
Color radioColorrr = Colors.grey;
String selectedOptionnn = 'No';
String? selectedOptionnnn;


@override
  void initState() {
 if(app_id!=null||app_id!=""||app_id.isNotEmpty){
   view(context);
 }

 locations(context);

 super.initState();
  }

locations(context) async {
  HashMap<String, String> map = HashMap();
  map["updte"] = "1";

  var res = await http.post(
      Uri.parse("$mainurl/location_list.php"),
      body: jsonEncode(map));
  print(res.body);
  dynamic jsondata = jsonDecode(res.body);
  print("i harleen here  $map");
  print(jsondata);
  var er = jsondata["error"];
  if (res.statusCode == 200) {
    if (er == 0) {
      if (jsondata.containsKey("user_skills")) {

        List<dynamic> skillsList = jsondata["user_skills"];
        userSkills = skillsList.map((skill) => skill["state"].toString()).toList();

      }
      print("User Skills: $userSkills");


    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
          duration: Duration(seconds: 2 ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );

    }
  }
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Vacancy",style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width:MediaQuery.of(context).size.width * 0.42 ,
                        height: 45,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF118743),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            Navigator.pushNamed(context, "vj");
                          },
                          child: Text(
                            "Job Details",
                            style: GoogleFonts.rubik(
                                color: Colors.white, fontSize: 15),
                          ),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width:MediaQuery.of(context).size.width * 0.42 ,
                        height: 45,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Color(0xFF118743)),)),
                          onPressed: () {
                            Navigator.pushNamed(context, "req");
                          },
                          child: Text(
                            "Requirements",
                            style: GoogleFonts.rubik(
                                color: Color(0xFF118743), fontSize: 15),
                          ),
                        )),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              if(imggg!="")
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEDF9F0),
                          shape: BoxShape.circle
                        ),
                        child: ClipOval(
                          child: Image(
                            image: NetworkImage("$photo/$imggg"),
                            height: 150,
                            width: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -5,
                        child: IconButton(
                          icon: Icon(Icons.edit,color: Color(0xFF118743),),
                          onPressed: () {
                            imagepicker();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              if(imggg=="")
                Center(
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Color(0xFFEDF9F0),
                          borderRadius: BorderRadius.circular(50),
                        ),
                        child: _image != null
                            ? ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image.file(_image!,
                              height: 150,
                              width: 150,
                              fit: BoxFit.cover),
                        )
                            : Image(
                          image: AssetImage("assets/comp.png"),
                          height: 150,
                          width: 150,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: -5,
                        child: IconButton(
                          icon: Icon(Icons.edit,color: Color(0xFF118743),),
                          onPressed: () {
                            imagepicker();
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              Row(
                children: [
                  Text("Open Position",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: namecontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    name = text;
                  });
                },
                maxLength: 20,
                style: GoogleFonts.rubik(),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Set the border color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Set the border color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "UI/UX Designer",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Salary",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: salcontroller,
                      cursorColor: Color(0xFF118743),
                      onChanged: (text) {
                        setState(() {
                          sal = text;
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
                        hintText: "",
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  DropdownButton<String>(
                    value: selectedOptionnnn,
                    hint: Text("   Type", style: TextStyle(color: Colors.grey)),
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black),
                    onChanged: (String? newValue) {
                      setState(() {
                        selectedOptionnnn = newValue!;
                        print(salcontroller.text);
                        print(selectedOptionnnn);
                        abc="${salcontroller.text}/${selectedOptionnnn}";
                        print(abc);
                      });
                    },
                    items: <String>['Year', 'Hour']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Text("Job-Type",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: DropdownButton<String>(
                      isExpanded: true,

                      style: TextStyle(fontSize: 14, color: Colors.black),
                      hint: Text("   Type", style: TextStyle(color: Colors.grey)),
                      value: selectedItem,
                      onChanged: (selectedItem) {
                        setState(() {
                          this.selectedItem = selectedItem!;
                        });
                      },
                      items: itemList
                          .map((String item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Location",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                readOnly: true,
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: DropdownButton<String>(
                      isExpanded: true,

                      style: TextStyle(fontSize: 14, color: Colors.black),
                      hint: Text("location", style: TextStyle(color: Colors.grey)),
                      value: locselected,
                      onChanged: (selectedItem) {
                        setState(() {
                          this.locselected = selectedItem!;
                          this.pinselected = null;
                          PinCode(context);
                        });
                      },
                      items: userSkills
                          .map((String item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("City",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                  readOnly: true,
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
                    suffixIcon: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: DropdownButton<String>(
                        isExpanded: true,

                        style: TextStyle(fontSize: 14, color: Colors.black),
                        hint: Text("City", style: TextStyle(color: Colors.grey)),
                        value: pinselected,
                        onChanged: (selectedItem) {
                          setState(() {
                            this.pinselected = selectedItem!;
                          });
                        },
                        items: userSkillss
                            .map((String item) => DropdownMenuItem(
                          value: item,
                          child: Text(item),
                        ))
                            .toList(),
                        icon: Padding(
                          padding: EdgeInsets.only(left: 20),
                          child: Icon(
                            Icons.keyboard_arrow_down,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Experience",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: DropdownButton<String>(
                      isExpanded: true,

                      style: TextStyle(fontSize: 14, color: Colors.black),
                      hint: Text("   Type", style: TextStyle(color: Colors.grey)),
                      value: selectedItemmm,
                      onChanged: (selectedItem) {
                        setState(() {
                          this.selectedItemmm = selectedItem!;
                        });
                      },
                      items: itemListtt
                          .map((String item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),


              SizedBox(
                height: 10,
              ),

              Row(
                children: [
                  Text("Status",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
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
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: DropdownButton<String>(
                      isExpanded: true,

                      style: TextStyle(fontSize: 14, color: Colors.black),
                      hint: Text("   Type", style: TextStyle(color: Colors.grey)),
                      value: selectedItemm,
                      onChanged: (selectedItem) {
                        setState(() {
                          this.selectedItemm = selectedItem!;
                          print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                          print(selectedItemm);
                        });
                      },
                      items: itemListt
                          .map((String item) => DropdownMenuItem(
                        value: item,
                        child: Text(item),
                      ))
                          .toList(),
                      icon: Padding(
                        padding: EdgeInsets.only(left: 20),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Job-Description",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                maxLines: 100,
                minLines: 3,
                controller: descontroller,
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
                  contentPadding:
                  EdgeInsets.symmetric(horizontal: 16,vertical: 10),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Set the border color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey), // Set the border color
                    borderRadius: BorderRadius.circular(10),
                  ),
                  hintText: "Something About Job",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              SizedBox(height: 40),
              // if(app_id==null||app_id==""||app_id.isEmpty)
              Container(
                  width: double.infinity,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () {
                      setState(() {
                        abc="${salcontroller.text}/${selectedOptionnnn}";
                        print(abc);
                      });
                      if(namecontroller.text!=""&& abc!="" &&selectedItem!=""&&locselected!=""&&selectedItemmm!=""&&selectedItemm!=""&&pinselected!=""){
                        JobDetails(context);
                      }else {
                        print(namecontroller.text);
                        print(abc);
                        print(selectedItem);
                        print(locselected);
                        print(selectedItemmm);
                        print(selectedItemm);
                        print(pinselected);

                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Fill the Form Properly"),
                            duration: Duration(seconds: 2),
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          ),
                        );
                      }
                    },
                    child: Text(
                      "Update Vacancy",
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 15),
                    ),
                  )),



            ],
          ),
        ),
      ),
    );
  }

JobDetails(context) async{

  print(pinselected);
  String rawSalary = pinselected.toString();
  List<String> salaryParts = rawSalary.split('(');
  if (salaryParts.length == 2) {
    pp = salaryParts[0].trim();
    oo = salaryParts[1].replaceAll(')', '');
    print('pp: $pp');
    print('oo: $oo');
  }
  HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;
    map["open_position"] = namecontroller.text;
    map["salary"] = abc.toString();
    map["location"] = locselected.toString();
    map["city"]=pp.toString();
    map["pincode"]=oo.toString();
    map["type"] = selectedItem!;
    map["status"] = selectedItemm!;
    map["job_description"]= descontroller.text;
    map["experience"]= selectedItemmm!;

    if(app_id!="")
      {
        map["jop_vacancy_id"]= app_id;
      }
    if(base64Image==""||base64Image==null){
      map["jop_image"]="";
    }else{
      map["jop_image"]=base64Image;
    }

    var res = await http.post(Uri.parse("$mainurl/add_job_details.php"),
        body: jsonEncode(map));
    print(map);
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Information Saved Successfully"),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        setState(() {

          print("################################################################################");
          app_id=jsondata["jop_vacancy_id"].toString();
          print(app_id);

          Navigator.pushNamed(context, "req");

        });

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        Future.delayed(Duration(seconds: 2),(){
          Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription(callback: callback_mem)));
        });
      }
    } else {
      print('error');
    }

  }

view(context) async{
  HashMap<String, String> map = HashMap();
  map["updte"] = "1";
  map["user_id"]= user_id;
  map["jop_vacancy_id"]= app_id;


  var res = await http.post(Uri.parse("$mainurl/add_job_details_show.php"),
      body: jsonEncode(map));
  print(res.body);
  dynamic jsondata = jsonDecode(res.body);
  print("Mapped::::::$map");
  print(jsondata);


  if (res.statusCode == 200) {
    if(jsondata["error"]==0) {

      setState(() {
        vacancy_id=jsondata["jop_vacancy_id"];
        namecontroller.text= jsondata["open_position"];

        // Extracting and saving the salary differently
        String rawSalary = jsondata["salary"];
        List<String> salaryParts = rawSalary.split('/');
        if (salaryParts.length == 2) {
          amount = salaryParts[0].trim();
          unit = salaryParts[1].trim();
          print("*");
          print(unit);
          print(amount);
          print("*");
        }
        pinselected=jsondata["city_pin"];
        print("**");
        setState(() {
          locselected=jsondata["location"];
          PinCode(context);
        });
        print(pinselected);
        salcontroller.text = amount;
        selectedOptionnnn=unit;
        locselected=jsondata["location"];
        selectedItem=jsondata["type"];
        selectedItemmm=jsondata["experience"];
        imggg = jsondata["jop_image"];

        if(jsondata["job_description"]!="" || jsondata["job_description"]!=null){
          descontroller.text=jsondata["job_description"];
        }

        if(jsondata["is_active"]=="1"){
          setState(() {
            selectedItemm="Active";
          });
        } else if(jsondata["is_active"]=="0"){
          setState(() {
            selectedItemm="Inactive";
          });
        }
      });
    } else {
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

PinCode(context) async {
  HashMap<String, String> map = HashMap();
  map["updte"] = "1";
  map["state"]=locselected.toString();

  var res = await http.post(
      Uri.parse("$mainurl/location_city_pincode_list.php"),
      body: jsonEncode(map));
  dynamic jsondata = jsonDecode(res.body);
  print(map);
  var er = jsondata["error"];
  if (res.statusCode == 200) {
    print(jsondata);
    if (er == 0) {
      setState(() {
        if (jsondata.containsKey("user_skills")) {
          List<dynamic> skillsList = jsondata["user_skills"];
          userSkillss = skillsList.map((skill) => "${skill["city"]}(${skill["pincode"]})").toList();
          pinselected=userSkillss[0];
        }
      });
      print("pincodes************: $userSkillss");

    } else {

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went Wrong"),
          duration: Duration(seconds: 2 ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );

    }
  }
}



}
