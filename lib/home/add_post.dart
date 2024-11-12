import 'dart:collection';
import 'dart:convert';

import 'package:fac/welcome/choose.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../starting/splashscreen.dart';
// import 'package:flutter_quill/flutter_quill.dart'as quill;
// import 'package:flutter_quill/flutter_quill.dart';

class AddPost extends StatefulWidget {
  final Function(String) callback;
  AddPost({required this.callback});

  @override
  State<AddPost> createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  TextEditingController _desc = TextEditingController();
  TextEditingController _salary = TextEditingController();
  TextEditingController _keySkill = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();

  String selectedValues = '';
  bool saveOrNot = false;
  List<String> _options =[];
  List<String>  _option2 =[];
  String codepin = '';
  final TextEditingController _serchController = TextEditingController();

  var getD ;
  String? selectedOptionnnn;
  var abc="";

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
 // QuillController _controller = QuillController.basic();
  bool _isBold = false;

  Future _post() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/job_seeker_post.php");
      var prefs = await SharedPreferences.getInstance();
      //var ids=prefs.getInt(FirstScreenState.UNIQEId);
      // var session_id=ids != null?ids:2;
      Map mapdata = {
        "updte":1,
        "skills": _keySkill.text,
        "user_id": user_id.toString(),
        "message": _desc.text,
        "preference": selectedItem,
        "job_type": jobTypCont[0],
        "job_type_two": jobTypCont[1],
        "job_type_three": jobTypCont[2],
        "job_name": subTypCont[0],
        "job_name_two": subTypCont[1],
        "job_name_three":subTypCont[2],
        "salary_exp": abc == ""?_salary.text:abc,
        "state": locselected,
        "city": "$selectedValues ($codepin)",
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
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII");
        if(data["error"]==0){
          setState(() {
            _desc.clear();
            _keySkill.clear();
            jobTypCont.clear();
            subTypCont.clear();
            _salary.clear();
            selectedItem=null;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Post Added Successfully"),
              duration: Duration(seconds: 2 ),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );

          // Navigator.pop(context);
          // setState(() {
          //   widget.callback("");
          // });
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
          return  data;
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went wrong"),
              duration: Duration(seconds: 2 ),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
          //MotionToast.error(description: Text(data["error_msg"]));
        }
      }else{
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

      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
  getData(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id.toString();

    var res = await http.post(
        Uri.parse("$mainurl/get_user_jop_filter_deta.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $map");
    print("hello get data for autofill $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          getD=jsondata;
          if(jsondata["job_type"] != null && jsondata["job_type"]!="") {
            print("yes i am inside it");
            subTypCont.add(jsondata["job_name"]);
            subTypCont.add(jsondata["job_name_two"]);
            subTypCont.add(jsondata["job_name_three"]);
            jobTypCont.add(jsondata["job_type"]);
            jobTypCont.add(jsondata["job_type_two"]);
            jobTypCont.add(jsondata["job_type_three"]);
          }
          if(jsondata["employment"]!=null && jsondata["employment"] !=""){
            selectedItem = jsondata["employment"];
          }
        });

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
            print("helo its gd $getD");
            //locselected = userSkills[0];
            if( getD == null || getD["city"]=="" ) {
              print("hello its selected location");
              locselected = userSkills[0];
            }else{
              print("city i skjdfj f ${getD["state"]}");
              locselected = getD["state"];
            }
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
            // pinselected = pin;
            print("ot os coty ${getD["city"]}");
            if(pin !=""){
              print("ot os coty ${getD["city"]}");
              if(getD == null || getD["city"]=="") {
                pinselected = pin;
              }else{
                print("ot os coty ${getD["city"]}");
                pinselected=getD["city"];
              }
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
  @override
  void initState() {
    getData(context);
    locations(context);
    jobTypes(context);
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text('Post Interest'),
      //   centerTitle: true,
      // ),
      appBar: AppBar(
        title: Text('Post Interest'),
        centerTitle: true,
        leading: InkWell(
          onTap: (){
            Navigator.pop(context);
            setState(() {
              widget.callback("");
            });
          },
            child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),

      ),
      body: PopScope(
        onPopInvoked: (vl){
          print("helo $vl");
          widget.callback("");
        },
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _key,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text("Skills",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                            Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                          ],
                        ),
                        SizedBox(height: 5,),
                        TextFormField(
                          controller: _keySkill,
                          maxLines: 3,
                          minLines: 1,
                          validator: (value){
                            if(value == null || value!.isEmpty){
                              return "Enter Skills";
                            }
                            return null;
                          },
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
                            hintText: "Java , C++ etc.",
                          ),
                          style: TextStyle(
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text("Preferred job type",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
                            Text("Preferred job subType",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
                        SizedBox(height: 5.0),
                        Row(
                          children: [
                            Text("Preferred work state",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
                            Text("Preferred work Suburb",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
                        SizedBox(height: 16.0),
                        Row(
                          children: [
                            Text("Expected Salary",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                            Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                          ],
                        ),
                        SizedBox(height: 5,),
                        Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _salary,
                                maxLines: 3,
                                minLines: 1,
                                keyboardType: TextInputType.number,
                                validator: (value){
                                  if(value == null || value!.isEmpty){
                                    return "Enter Salary";
                                  }
                                  return null;
                                },
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
                                  hintText: "per month",
                                ),
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
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
                                  print(_salary.text);
                                  print(selectedOptionnnn);
                                  abc="${_salary.text}/${selectedOptionnnn}";
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
                        SizedBox(height: 16.0),
                        // Row(
                        //   children: [
                        //     Text("About Interest",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                        //     Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),
                        //
                        //   ],
                        // ),
                        // SizedBox(height: 5,),
                        // TextFormField(
                        //   controller: _desc,
                        //   validator: (value){
                        //     if(value == null || value!.isEmpty){
                        //       return "Enter description";
                        //     }
                        //     return null;
                        //   },
                        //   maxLines: null, // Allows unlimited lines of text
                        //   decoration: InputDecoration(
                        //     filled: true,
                        //     fillColor: Colors.white,
                        //     contentPadding:
                        //     EdgeInsets.symmetric(horizontal: 16),
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey), // Set the border color
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey),
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     border: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.grey), // Set the border color
                        //       borderRadius: BorderRadius.circular(10),
                        //     ),
                        //     hintText: "Write here....",
                        //   ),
                        //   style: TextStyle(
                        //     fontWeight: FontWeight.normal,
                        //   ),
                        // ),

                        // Add any additional widgets here, such as buttons or other controls
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: InkWell(
                    onTap: (){
                      if(_key.currentState!.validate()){
                        _post();
                      }

                    },
                    child: Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Color(0xFF118743),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(14.0),
                        child: Center(child: Text("Post",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }


//Padding(
//         padding: const EdgeInsets.all(10.0),
//         child: Column(
//           children: [
//             Padding(
//               padding: const EdgeInsets.only(top: 10.0,bottom: 10),
//               child: quill.QuillToolbar.simple(configurations: QuillSimpleToolbarConfigurations(
//                 controller: _controller,
//                 showAlignmentButtons: false,
//                 showCenterAlignment: false,
//                 showSearchButton: false,
//                 showClearFormat: false,
//                 showColorButton: false,
//                 showJustifyAlignment: false,
//                 showUndo: false,
//                 showQuote: false,
//                 showListNumbers: false,
//                 showListCheck: false,
//                 showCodeBlock: false,
//                 showSubscript: false,
//                 showSmallButton: false,
//                 showFontSize: false,
//                 showFontFamily: false,
//                 showDirection: false,
//                 showInlineCode: false,
//                 showSuperscript: false,
//                 showStrikeThrough: false,
//                 showDividers: false,
//                 showLink: false,
//                 showRedo: false,
//                 multiRowsDisplay: false,
//                 sharedConfigurations: const QuillSharedConfigurations(
//                   locale: Locale('de'),
//                 ),
//               ),),
//             ),
//             Expanded(child: Container(
//               color: Colors.grey.shade100,
//               padding: EdgeInsets.all(16),
//               child: quill.QuillEditor.basic(configurations: QuillEditorConfigurations(
//                 controller: _controller,
//                 readOnly: false,
//                 autoFocus: true,
//                 sharedConfigurations: const QuillSharedConfigurations(
//                   locale: Locale('de'),
//                 ),
//               ),),
//             )),
//             Padding(
//               padding: const EdgeInsets.all(10.0),
//               child: InkWell(
//                 onTap: (){
//
//                 },
//                 child: Container(
//                   width: width,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(12),
//                     color: Colors.green.shade800,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.all(14.0),
//                     child: Center(child: Text("Post",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
//                   ),
//                 ),
//               ),
//             ),
//
//           ],
//         ),
//       ),

}
