import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  List<String> userSkills = [];
  String? locselected;

  List<String> userSkillss = [];
  String? pinselected;

  var tiname="";
  var tiem="";
  var tipp="";

  String? name="";
  TextEditingController namecontroller = TextEditingController();
  String? inch="";
  TextEditingController inchcontroller = TextEditingController();
  String? po="";
  TextEditingController pocontroller = TextEditingController();
  String? em="";
  TextEditingController emcontroller = TextEditingController();
  String? des="";
  TextEditingController descontroller = TextEditingController();

  String? addr="";
  TextEditingController addrcontroller = TextEditingController();
  String? state="";
  TextEditingController statecontroller = TextEditingController();
  String? num="";
  TextEditingController numcontroller = TextEditingController();

  TextEditingController dateInput = TextEditingController();



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
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    locations(context);
  }

  @override
  Widget build(BuildContext context) {
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
        }
         // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Drawer(),), (route) => false);        },
      ),
    ),
      body: (pinselected ==null || locselected ==null)
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
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
                        child:  _image != null
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
                            image: NetworkImage("$photo/$tipp"),
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
                            icon: Icon(Icons.edit,color: Colors.green,),
                            onPressed: () {
                              imagepicker();
                            },
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(width: 15,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(tiname,style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                      Text(tiem,style: GoogleFonts.rubik(color: Colors.grey),),
                      Text("Australia",style: GoogleFonts.rubik(color: Colors.grey),)

                    ],
                  )
                ],
              ),
              SizedBox(height: 20,),
              Divider(),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Name of Company",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Person in charge name",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: inchcontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    inch = text;
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
                  hintText: "InCharge Name",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Position",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: pocontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    po = text;
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
                  hintText: "Position",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Company Email",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
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
                  hintText: "fac@gmail.com",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Company Phone",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              IntlPhoneField(
                cursorColor: Color(0xFF118743),
                controller: numcontroller,

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
                  hintText: "Company Phone",
                  counterText: "",
                ),
                initialCountryCode: 'AU',
                onChanged: (phone) {
                  print(phone.completeNumber); // Handle phone number changes
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Company Description",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                minLines: 4,
                maxLines: 100,
                controller: descontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    des = text;
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
                  hintText: "Description",
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Company Address",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: addrcontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    addr = text;
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
                  hintText: "Address",
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
              DropdownButtonFormField(
                // isDense: true,

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
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text("Suburbs",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              DropdownButtonFormField(
                // isDense: true,

                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white,
                  hintText: "Suburbs",
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
                value: pinselected,
                onChanged: (selectedItem) {
                  setState(() {
                    this.pinselected = selectedItem!;
                  });
                },
                items: userSkillss
                    .map((String item) => DropdownMenuItem(
                  value: item,
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
              SizedBox(
                height: 10,
              ),

              SizedBox(height: 15),
              Container(
                  width: double.infinity,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20))),
                    onPressed: () {
                      Updatepro(context);
                    },
                    child: Text(
                      "Update",
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 17),
                    ),
                  )),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

  viewpro(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/employer_profile_view.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::::::::::::::: here  $jsondata");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
        setState(() {
          namecontroller.text=jsondata["company_name"];
          inchcontroller.text=jsondata["user_name"];
          pocontroller.text=jsondata["position"];
          emcontroller.text=jsondata["email_id"];
          addrcontroller.text=jsondata["address"];
          print("i after view here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $locselected");
          if(jsondata["country"]!="")
            locselected=jsondata["country"];
          descontroller.text=jsondata["company_description"];
          dateInput.text=jsondata["established_year"];
          numcontroller.text=jsondata["mobile_number"];

          tiname=jsondata["company_name"];
          tiem=jsondata["email_id"];
          tipp=jsondata["profile_image"];
          print("i am inside view here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: ${jsondata["country"]}");
          // if(jsondata["country"]=="") {
          //   locations(context);
          //   print("hello i am isndie the country locacation api in viewpro :::::::::::");
          // }
          PinCode(context,jsondata["city"]);
          if(jsondata["city"] != "") {
            print("hello i am isndie the country locacation api in viewpro :::::::::::");
            pinselected = jsondata["city"];
          }


          _isLoading = false;


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
  }

  Updatepro(context) async {
    HashMap<String, String> map = HashMap();
    if(namecontroller.text!=""&&inchcontroller.text!=""&&pocontroller.text!=""&&emcontroller.text!=""&&numcontroller.text!=""&&dateInput.text!=""&&addrcontroller.text!="")
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["company_name"] = namecontroller.text;
    map["user_name"] = inchcontroller.text;
    map["position"] = pocontroller.text;
    map["email_id"] = emcontroller.text;
    map["mobile_number"] = numcontroller.text;
    map["company_description"] = descontroller.text;
    map["established_year"] = dateInput.text;
    map["address"] = addrcontroller.text;
    map["country"] = locselected?.toString() ?? "";
    map["city"] = pinselected?.toString() ?? "";

    if(base64Image==""||base64Image==null){
      map["profile_img"]="";
    }else{
      map["profile_img"]=base64Image;
    }



    var res = await http.post(Uri.parse("$mainurl/employer_profile_update.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("updated$map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          viewpro(context);
        });
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text(''),
              content: SingleChildScrollView(
                child: Center(
                  child: Container(
                    height: 60,
                    child: Column(
                      children: [
                        Text('Data updated',style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),),
                        Text('Successfully!',style: TextStyle(fontWeight: FontWeight.w700,fontSize: 14)),
                      ],
                    ),
                  )
                ),
              ),
              actions: <Widget>[

              ],
            );
          },
        );
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(context);
        });
       // Navigator.pushNamed(context, "profile");




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
            print("i harleen here ::::::::::::::::::::::::::::::: ::::::::::::::::::::::::::::::::::::: $locselected");
            viewpro(context);
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
