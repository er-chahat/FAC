import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class EditPro extends StatefulWidget {
  const EditPro({super.key});

  @override
  State<EditPro> createState() => _EditProState();
}

class _EditProState extends State<EditPro> {
  var tipp="";

  String? name="";
  TextEditingController namecontroller = TextEditingController();
  String? mob="";
  TextEditingController mobcontroller = TextEditingController();
  String? em="";
  TextEditingController emcontroller = TextEditingController();

  String selectedValues = '';
  List<String> _options =[];
  List<String>  _option2 =[];
  String codepin = '';
  final TextEditingController _serchController = TextEditingController();

  TextEditingController dateinput = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  String? selectedItemm;
  List<String> itemListtt = ["Male", "Female"];
  String? selectedItemmm;

  bool _isLoading = true;
  List<String> itemList = [
    'Full-Time',
    'Part-Time',
    'Casual',
  ];
  List<String> jobType = [];
  String? typeSelected;
  List<String> jobIdType = [];
  String? typeIdSelected;
  List<String> jobTypCont = [];
  List<String> subTypCont = [];
  List<String> jobSubType = [];
  String? typeSubSelected;

  List<String> userSkills = [];
  String? locselected;
  List<String> userSkillss = [];
  String? pinselected;
  String? selectedItem ;

  locations(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(
        Uri.parse("$mainurl/location_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if (jsondata.containsKey("user_skills")) {
          setState(() {
            List<dynamic> skillsList = jsondata["user_skills"];
            userSkills = skillsList.map((skill) => skill["state"].toString()).toList();
            locselected=userSkills[0];
            if(userSkillss.isEmpty || userSkillss == []){
              PinCode(context, "");
            }
            print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $locselected");
          });

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

  jobTypes(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(
        Uri.parse("$mainurl/jobs_category.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $map");
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
            if(jobSubType.isEmpty || jobSubType == []){
              subType(context, jobIdType[0]);
            }
            print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $locselected");
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

  PinCode(context,var pin) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["state"]=locselected.toString();

    var res = await http.post(
        Uri.parse("$mainurl/location_city_pincode_list.php"),
        body: jsonEncode(map));
    dynamic jsondata = jsonDecode(res.body);
    print(":::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::         :::::::::::::$map");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      print(jsondata);
      if (er == 0) {
        setState(() {
          if (jsondata.containsKey("user_skills")) {
            List<dynamic> skillsList = jsondata["user_skills"];
            userSkillss = skillsList.map((skill) => "${skill["city"]}(${skill["pincode"]})").toList();
            pinselected=userSkillss[0];
            print("your locselected ::::::: $pinselected");
            if(pin !=""){
              pinselected=pin;
              _serchController.text=pinselected!;
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

  @override
  void initState() {
    locations(context);
    jobTypes(context);
    show();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Profile",
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
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(color: Color(0xFF118743),),
      )
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _key,
            child: Column(
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            color: Color(0xFFEDF9F0),
                            shape: BoxShape.circle,

                          ),
                          child: _image != null
                              ? ClipRRect(
                            borderRadius: BorderRadius.circular(20.0),
                            child: Image.file(_image!,
                                height: MediaQuery.of(context).size.height * 0.17,
                                width: MediaQuery.of(context).size.width * 0.3,
                                fit: BoxFit.cover),
                          )
                              :ClipRRect(
                            borderRadius: BorderRadius.circular(50),
                            child: Image(
                              image:
                              NetworkImage("$photo/$tipp"),
                              height: MediaQuery.of(context).size.height * 0.17,
                              width: MediaQuery.of(context).size.width * 0.3,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: -5,
                          child: Container(
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 2,
                                  blurRadius: 2,
                                ),
                              ],
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(35),
                            ),
                            child: IconButton(
                              icon: Icon(Icons.edit,color: Color(0xFF118743),),
                              onPressed: () {
                                imagepicker();
                              },
                            ),
                          ),
                        ),
                      ],
                    ),

                    SizedBox(width: 30,),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(namecontroller.text,style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 22),),
                        Text(emcontroller.text,style: GoogleFonts.rubik(color: Colors.grey),),
                        Text("Australia",style: GoogleFonts.rubik(color: Colors.grey),)

                      ],
                    )
                  ],
                ),
                SizedBox(height: 20,),
                Divider(),
                Row(
                  children: [
                    Text("Name",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
                  style: GoogleFonts.rubik(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    hintText: "FAC",
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Email",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),
                  ],
                ),
                SizedBox(height: 5,),
                TextFormField(
                  controller: emcontroller,
                  cursorColor: Color(0xFF118743),
                  onChanged: (text) {
                    setState(() {
                      em = text;
                    });
                  },
                  style: GoogleFonts.rubik(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'This field is required';
                    }
                    return null;
                  },
                  autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    hintText: "FAC",
                  ),
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Mobile Number",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                  ],
                ),
                SizedBox(height: 5,),
                IntlPhoneField(
                  cursorColor: Color(0xFF118743),
                  controller: mobcontroller,

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
                    hintText: "Phone",
                    counterText: "",
                  ),
                  initialCountryCode: 'AU',
                  onChanged: (phone) {
                    print(phone.completeNumber); // Handle phone number changes
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Job type",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                  ],
                ),
                SizedBox(height: 5,),
                DropdownButtonFormField(
                  // isDense: true,
                  validator: (value){
                    if(value == null || value!.isEmpty){
                      return "Please select";
                    }else if(jobTypCont.length<3){
                      return "Please add 3 Preferred jobs";
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
                        subType(context,typeIdSelected);
                        print(" index of id $index and $typeIdSelected");

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
                    Text("Job subType",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                  ],
                ),
                SizedBox(height: 5,),
                DropdownButtonFormField(
                  // isDense: true,
                  validator: (value){
                    if(value == null || value!.isEmpty){
                      return "Please select";
                    }else if(subTypCont.length<3){
                      return "Please add 3 Preferred jobs";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: "Job subType",
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
                  value: typeSubSelected,
                  onChanged: (selectedItem) {
                    setState(() {
                      this.typeSubSelected = selectedItem!;
                      if(subTypCont.length < 3) {
                        if(subTypCont.length == 0){
                          setState(() {
                            jobTypCont.add(typeSelected!);
                            subTypCont.add(typeSubSelected!);
                          });
                        }else{
                          for(int j =0;j<subTypCont.length;j++){
                            print("hello your sutype cont ${subTypCont[j]} && $typeSubSelected");
                            print("hello your sutype cont ${subTypCont} && $j");
                            if(subTypCont[j] == typeSubSelected){
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("This Job is already selected"),
                                  duration: Duration(seconds: 2),
                                  shape:
                                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                ),
                              );
                              break;
                            }else if(j == subTypCont.length-1 && typeSubSelected !=subTypCont[j]){
                              setState(() {
                                jobTypCont.add(typeSelected!);
                                subTypCont.add(typeSubSelected!);
                              });
                              break;
                            }
                          }
                        }
                      }else{
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("You can only select up to three jobs"),
                            duration: Duration(seconds: 2),
                            shape:
                            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          ),
                        );
                      }
                    });
                  },
                  items: jobSubType
                      .map((String item) => DropdownMenuItem(
                    value: item,
                    onTap: (){
                      // if(subTypCont.length < 3) {
                      //   setState(() {
                      //     jobTypCont.add(typeSelected!);
                      //     subTypCont.add(typeSubSelected!);
                      //   });
                      // }
                      print("hello your list cont job is ${jobTypCont} && $subTypCont");
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width/2,
                        child: Text(item,softWrap: true,maxLines: 1,overflow: TextOverflow.ellipsis,)),
                  ))
                      .toList(),
                  icon: Icon(
                    Icons.keyboard_arrow_down,
                    color: Colors.grey,
                  ),
                ),
                if(subTypCont.length > 0)
                  SizedBox(height: 10.0),
                if(subTypCont.length > 0 )
                  Text("Selected ${subTypCont.length}/3 Preferred jobs",style: GoogleFonts.rubik(fontWeight: FontWeight.w400,fontSize: 14)),
                SizedBox(height: 16.0),
                if(subTypCont.length > 0)
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      for(int i =0 ; i<subTypCont.length;i++)
                        Padding(
                          padding: const EdgeInsets.only(right: 10.0),
                          child: Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Container(
                                  width: width/4,
                                  decoration: BoxDecoration(
                                      borderRadius:BorderRadius.circular(10),
                                      border: Border.all(width: 0.2,color: Colors.black)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Text("${subTypCont[i]}",softWrap: true,overflow: TextOverflow.ellipsis,textAlign: TextAlign.center,),
                                  ),
                                ),
                              ),
                              Positioned(
                                  right: -2,
                                  top: -2,
                                  child: InkWell(
                                      onTap: (){
                                        setState(() {
                                          subTypCont.removeAt(i);
                                          jobTypCont.removeAt(i);
                                        });
                                      },
                                      child: Icon(Icons.remove_circle_outlined,color: Colors.red,size: 22,))),
                            ],
                          ),
                        ),
                    ],
                  ),
                if(subTypCont.length > 0)
                  SizedBox(height: 4.0),
                Row(
                  children: [
                    Text("Employment Preference",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                  ],
                ),
                SizedBox(height: 5.0),
                DropdownButtonFormField(
                  // isDense: true,
                  validator: (value){
                    if(value == null || value!.isEmpty){
                      return "Please select";
                    }else if(jobTypCont.length<3){
                      return "Please add 3 Preferred jobs";
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    hintText: "Select Employment",
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
                  value: selectedItem,
                  onChanged: (String? selectedItem) {
                    setState(() {
                      this.selectedItem = selectedItem!;

                      //this.pinselected = null;
                      // PinCode(context,"");
                    });
                  },

                  items: itemList
                      .map((String item) => DropdownMenuItem(
                    value: item,
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
                SizedBox(height: 5.0),
                Row(
                  children: [
                    Text("Work state",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                  ],
                ),
                SizedBox(height: 5,),
                DropdownButtonFormField(
                  // isDense: true,
                  validator: (value){
                    if(value == null || value!.isEmpty){
                      return "Please select";
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
                  value: locselected,
                  onChanged: (String? selectedItem) {
                    setState(() {
                      this.locselected = selectedItem!;
                      this.pinselected = null;
                      PinCode(context,"");
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
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Text("Work Suburb",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                  ],
                ),
                SizedBox(height: 5,),
                Container(
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
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Date Of Birth",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                    Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                  ],
                ),
                SizedBox(height: 5,),
                TextField(
                  readOnly: true,
                  controller: dateinput,
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
                    hintText: "Date Of Birth",

                  ),
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(1950),
                        lastDate: DateTime.now());

                    if (pickedDate != null) {
                      print(pickedDate);
                      String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                      print(formattedDate);
                      setState(() {
                        dateinput.text = formattedDate;
                      });
                      print(dateinput.text);
                    } else {
                      print("Date is not selected");
                    }
                  },
                ),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text("Gender",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFF118743),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              if(_key.currentState!.validate()) {
                Update(context);
              }
            },
            child: Text(
              "Update",
              style: GoogleFonts.baloo2(color: Colors.white,fontSize: 17),
            ),
          ),
        ),
      ),

    );
  }
  Future show() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse('$mainurl/user_profile_show.php'),
        body: jsonEncode(map),
      );
      print(map);
      dynamic jsondata = jsonDecode(response.body);
      print("its your show data ");
      print(jsondata);
      if (response.statusCode == 200) {
        print("okkkkkk asjkdhfjasjdhf $jsondata");
        if(jsondata["job_type"] != null && jsondata["job_type"]!="" ) {
          print("yes i am inside it");
          subTypCont.add(jsondata["job_name"]);
          subTypCont.add(jsondata["job_name_two"]);
          subTypCont.add(jsondata["job_name_three"]);
          jobTypCont.add(jsondata["job_type"]);
          jobTypCont.add(jsondata["job_type_two"]);
          jobTypCont.add(jsondata["job_type_three"]);
        }

        setState(() {
          tipp=jsondata["profile_image"];
          namecontroller.text=jsondata["user_name"];
          mobcontroller.text=jsondata["mobile_number"];
          emcontroller.text=jsondata["email_id"];
          dateinput.text=jsondata["dob"];
          selectedItemmm=jsondata["gender"];
          _isLoading = false;
          if(jsondata["prefrence"]!=null && jsondata["prefrence"]!=""){
            selectedItem=jsondata["prefrence"];
          }

        });

      } else {
        throw Exception("Failed to load profile data");
      }
    } catch (e) {
      print('Error while fetching profile: $e');
    }
  }
  Update(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["user_name"] = namecontroller.text;
    map["email_id"] = emcontroller.text;
    map["mobile_number"] = mobcontroller.text;
    map["dob"] = dateinput.text;
    map["gender"] = selectedItemmm!;
    map["job_type"] = jobTypCont[0];
    map["job_type_two"] = jobTypCont[1];
    map["job_type_three"] = jobTypCont[2];
    map["job_name"] = subTypCont[0];
    map["job_name_two"] = subTypCont[1];
    map["job_name_three"] = subTypCont[2];
    map["prefrence"] = selectedItem!;

    if(base64Image==""||base64Image==null){
      map["profile_img"]="";
    }else{
      map["profile_img"]=base64Image;
    }
    print("your map data is$map");

    var res = await http.post(Uri.parse("$mainurl/user_profile_update.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("updated$map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
      } else {

      }
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
  }
}
