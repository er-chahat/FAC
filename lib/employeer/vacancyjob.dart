import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/gemini/gemini_chat.dart';
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
  List<String> jobTypCont = [];
  List<String> subTypCont = [];
  List<String> jobSubType = [];
  List<String> jobType = [];
  String? typeSelected;
  List<String> jobIdType = [];
  String? typeIdSelected;
  String? typeSubSelected;

  String selectedValues = '';
  List<String> _options =[];
  List<String>  _option2 =[];
  String codepin = '';
  final TextEditingController _serchController = TextEditingController();

  var _isChecked= false;
String? name="";
String? sal="";
String? des="";
TextEditingController descontroller = TextEditingController();
TextEditingController namecontroller = TextEditingController();
TextEditingController salcontroller = TextEditingController();
final GlobalKey<FormState> _key = GlobalKey();
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
  jobTypes(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(
        Uri.parse("$mainurl/jobs_category.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here job details ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if (jsondata.containsKey("deta")) {
          setState(() {
            List<dynamic> jobtyp = jsondata["deta"];
            jobType = jobtyp.map((skill) => skill["job_type"].toString()).toList();
            jobIdType=jobtyp.map((skill) => skill["job_category_id"].toString()).toList();
            typeSelected=jobType[0];
            namecontroller.text="$typeSelected";
          });

        }
        print("job type: $jobType");


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
  subType(context,var idSelected) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["job_category_id"]=idSelected.toString();

    var res = await http.post(
        Uri.parse("$mainurl/jobs_type_get.php"),
        body: jsonEncode(map));
    dynamic jsondata = jsonDecode(res.body);
    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::         :::::::::::::$map");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      print(jsondata);
      if (er == 0) {
        setState(() {
          if (jsondata.containsKey("deta")) {
            List<dynamic> skillsList = jsondata["deta"];
            jobSubType = skillsList.map((skill) => "${skill["job_name"]}").toList();
            typeSubSelected=jobSubType[0];
          }
        });
        print("pincodes************: $jobSubType");

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

  List<String> test_cate = [];
  String? selected_cate;
  List<String> test_cate_id = [];
  var sel_cate_id ;

List<String> itemList = ['Full-Time', 'Part-Time', 'Casual'];
String? selectedItem ;
List<String> itemListt = ['Active', 'Inactive'];
String? selectedItemm;
List<String> itemListtt = ["Beginner", "Intermediate", "Proficient"];
String? selectedItemmm;




File? _image;


var base64Image;

  searchapi(String value, String? state) async{
    HashMap<String, dynamic> map = HashMap();
    map["updte"] = "1";
    map["state"] = state!;
    map["city"] = value;

    var res = await http.post(Uri.parse("$mainurl/location_city_search.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("harleen $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      print("hello api search data is $jsondata");
      //List<dynamic> skillsList = jsondata["user_skills"];
      //           setState(() {
      //             userSkills = skillsList.map((skill) => skill["state"].toString()).toList();
      //             locselected=userSkills[0];
      //           });
      if(er==0){
        List<dynamic> all = jsondata["location"] ;
        setState(() {
          _options = all.map((alldat)=> alldat["city"].toString()).toList();
          _option2 = all.map((alldat)=> alldat["pincode"].toString()).toList();
        });
      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went worng"),
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

Future get_cate() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/employer_category_list.php");
      Map mapdata = {
        "updte":1,
        "user_id": user_id.toString(),
        //"category_name": widget.heading,
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII$data");
        if(data["error"]==0){
          setState(() {
            if (data.containsKey("categories_list")) {

              List<dynamic> skillsList = data["categories_list"];
              test_cate_id = skillsList.map((skill) => skill["emp_category_id"].toString()).toList();
              test_cate = skillsList.map((skill) => skill["category_name"].toString()).toList();
              selected_cate=test_cate[0];
              sel_cate_id = test_cate_id[0];
            }
          });
          // Navigator.pop(context);
          // setState(() {
          //   widget.callback("");
          // });
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
          return  data;
        }else{
          setState(() {
            test_cate=[];
          });
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("Something went wrong"),
          //     duration: Duration(seconds: 2 ),
          //     shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          //   ),
          // );
          //MotionToast.error(description: Text(data["error_msg"]));
        }
      }else{
        setState(() {
          test_cate=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        // MotionToast.warning(
        //     title:  Text("${data["error_msg"]}"),
        //     description:  Text("try again later ")
        // ).show(context);

      }

    }catch(e){
      setState(() {
        test_cate=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }

Future imagepicker() async {
  final picker = ImagePicker();
  final pickedImage = await picker.pickImage(source: ImageSource.gallery);
  if (pickedImage != null) {
    setState(() {
      imggg="";
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
var pin="";


@override
  void initState() {
  jobTypes(context);
 locations(context);
 get_cate();
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
        if(app_id!=null||app_id!=""||app_id.isNotEmpty){
          view(context);
        }

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
    var size = MediaQuery.of(context).size;
    var width = size.width;
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
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Form(
                key: _key,
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
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                    return Container(
                                      height: 55,
                                      width: 55,
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
                      minLines: 1,
                      maxLines: 6,
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
                    SizedBox(height: 5,),
                    Row(
                      children: [
                        Text("Job Category",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                        Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                      ],
                    ),
                    SizedBox(height: 5,),
                    DropdownButtonFormField(
                      // isDense: true,
                      validator: (value){
                        if(value == null || value!.isEmpty){
                          return "Please select";
                        }else if(typeSelected ==null || typeSelected == ""){
                          return "Please Select Value";
                        }
                        return null;
                      },
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
                      ),
                      value: typeSelected,
                      onChanged: (String? selectedItem) {
                        setState(() {
                          this.typeSelected = selectedItem!;
                         // namecontroller.text=selectedItem!;
                          //this.pinselected = null;
                          // PinCode(context,"");
                        });
                      },

                      items: jobType
                          .map((String item) => DropdownMenuItem(
                        value: item,
                        onTap: (){
                          int index = jobType.indexOf(item);
                          setState(() {
                            typeIdSelected=jobIdType[index];

                          });
                        },
                        child: Container(
                            width: width/1.5,
                            child: Text(item)),
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
                    SizedBox(height: 16.0),
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
                        Text("Employment Type",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
                                pin = "";
                                print("yes it is called on change ::: ");
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
                        Text("Suburb",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                        Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                      ],
                    ),
                    SizedBox(height: 5,),
                    Padding(
                      padding: const EdgeInsets.only(left: 8,right: 8),
                      child: Container(
                        height: 50,
                        child: TextFormField(
                          controller: _serchController,
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
                            suffixIcon: Autocomplete<String>(
                              optionsBuilder: (TextEditingValue textEditingValue) async {
                                if (textEditingValue.text.isEmpty) {
                                  return const Iterable<String>.empty();
                                }
                                await searchapi(textEditingValue.text, locselected);
                                return _options;
                              },
                              onSelected: (String selection) {
                                setState(() {
                                  _serchController.text = selection;
                                  pinselected=selection;
                                  int index = _options.indexOf(selection);
                                  selectedValues = selection;
                                  codepin = _option2[index];
                                });
                                print('You selected: $selection');
                              },
                              fieldViewBuilder: (context, controller, focusNode, onFieldSubmitted) {
                                return TextFormField(
                                  controller: controller,
                                  focusNode: focusNode,
                                  style: GoogleFonts.rubik(),
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.white,
                                    contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                    hintText: "Search Suburb",
                                    hintStyle: GoogleFonts.rubik(color: Colors.grey),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onFieldSubmitted: (value) {
                                    onFieldSubmitted();
                                  },
                                );
                              },
                              optionsViewBuilder: (BuildContext context, AutocompleteOnSelected<String> onSelected, Iterable<String> options) {
                                return Align(
                                  alignment: Alignment.topLeft,
                                  child: Material(
                                    elevation: 4.0,
                                    child: Container(
                                      height: 200.0,
                                      color: Colors.white,
                                      child: ListView.builder(
                                        padding: EdgeInsets.all(8.0),
                                        itemCount: options.length,
                                        itemBuilder: (BuildContext context, int index) {
                                          final String option = options.elementAt(index);
                                          return GestureDetector(
                                            onTap: () {
                                              onSelected(option);
                                            },
                                            child: ListTile(
                                              title: Text("$option (${_option2[index]})"),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                );
                              },
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
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,  // Center the row
                      children: [
                        Checkbox(
                          value: _isChecked,
                          onChanged: (newValue) {
                            setState(() {
                              _isChecked = newValue!;
                            });
                          },
                        ),
                        SizedBox(width: 5),
                        Text('Want to add test',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight:FontWeight.w600),),
                       // Add some space between the text and the checkbox
                      ],
                    ),
                    SizedBox(height: 10,),
                    if(_isChecked == true)
                    Row(
                      children: [
                        Text("Select Category for test",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                        Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                      ],
                    ),
                    if(_isChecked == true)
                    SizedBox(height: 10,),
                    if(_isChecked == true)
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
                          padding: const EdgeInsets.only(left: 10),
                          child: DropdownButton<String>(
                            isExpanded: true,

                            style: TextStyle(fontSize: 14, color: Colors.black),
                            hint: Text(" Select", style: TextStyle(color: Colors.grey)),
                            value: selected_cate,
                            onChanged: (selectedItem) {
                              int x = test_cate.indexOf(selectedItem!);
                              setState(() {
                                this.selected_cate = selectedItem!;
                                sel_cate_id = test_cate_id[x];
                                print("hiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiiii");
                                print(sel_cate_id);
                              });
                            },
                            items: test_cate.map((String item) => DropdownMenuItem(
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
                    if(_isChecked == true)
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
                            if(abc!="" &&selectedItem!=""&&locselected!=""&&selectedItemmm!=""&&selectedItemm!=""&&pinselected!=""){
                              if(_key.currentState!.validate()) {
                                JobDetails(context);
                              }else{
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("3 open sub positions are required"),
                                    duration: Duration(seconds: 2),
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                  ),
                                );
                              }
                            }else {
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
          ),
          Positioned(
              right: -50,
              top: 120,
              child: Transform.rotate(
                angle: -90 * 3.1415926535897932 / 180,
                child: InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>GeminiAI()));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFF118743),
                      shape: BoxShape.rectangle,
                      borderRadius: BorderRadius.circular(6)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Job Description Builder",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }

JobDetails(context) async{

  print("pin selected are so d ${pinselected}");
  // String rawSalary = pinselected.toString();
  // List<String> salaryParts = rawSalary.split('(');
  // if (salaryParts.length == 2) {
  //   pp = salaryParts[0].trim();
  //   oo = salaryParts[1].replaceAll(')', '');
  //   print('pp: $pp');
  //   print('oo: $oo');
  // }
  HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;
    map["open_position"] = namecontroller.text;
    map["salary"] = abc.toString();
    map["location"] = locselected.toString();
    map["city"]=selectedValues;
    map["pincode"]=codepin;
    map["type"] = selectedItem!;
    map["status"] = selectedItemm!;
    map["job_description"]= descontroller.text;
    map["experience"]= selectedItemmm!;
    map["emp_category_id"]= "${sel_cate_id}";
    map["job_type"] = typeSelected!;


    if(app_id!="")
      {
        map["jop_vacancy_id"]= app_id;
      }
    if(base64Image==""||base64Image==null){
      map["jop_image"]="";
    }else{
      map["jop_image"]=base64Image;
    }
    print("i harleen here job details ::::::::::::::::::::::::::::::: :::::::::::::::::::::::::::::::::::z$map");
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
  print("its vaccny details${jsondata}");


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
        pin=jsondata["city_pin"];
        print("**");
        setState(() {
          locselected=jsondata["location"];
          PinCode(context);
        });

        print(pinselected);
        salcontroller.text = amount;
        selectedOptionnnn=unit;
        selectedItem=jsondata["type"];
        selectedItemmm=jsondata["experience"];
        imggg = jsondata["jop_image"];

        if(jsondata["job_description"]!="" || jsondata["job_description"]!=null){
          descontroller.text=jsondata["job_description"];
        }
        if(jsondata["job_type"] != null && jsondata["job_type"] != ""){
          typeSelected = jsondata["job_type"];
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
          userSkillss = skillsList.map((skill) => "${skill["city"]}(${skill["pincode"]})".trim()).toList();
          print("hello ist pin ${pin.trim()} && ${userSkillss[0].trim()}");
          if(pin == "" ) {
            pinselected = userSkillss[0];
          }else{
            print("hello its uou r pin $pin");
           pinselected = pin;
          }

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
