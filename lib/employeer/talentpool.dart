import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/employeer/talent.dart';
import 'package:fac/home/de_talent.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../home/de.dart';
import '../welcome/choose.dart';
class Talentpool extends StatefulWidget {
  const Talentpool({super.key});

  @override
  State<Talentpool> createState() => _TalentpoolState();
}

class _TalentpoolState extends State<Talentpool> {

  List<Map<String, dynamic>> talentList = [];

  bool isPermission = false;
  Dio dio =Dio();
  double prog =0.0;
  String downloading ="0.0";
  var membert="";

  var showsub = false;

  Future<void> showSub(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";

    var res = await http.post(Uri.parse("$mainurl/subscription_switch.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("::::::::::::::::$jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if(jsondata["user_subscription"]!="Off" && type == "User"){
          setState(() {
            showsub=true;
          });
        }else if(jsondata["employers_subscription"] != "Off" && type != "User"){
          setState(() {
            showsub=true;
          });
        }else if(jsondata["employers_subscription"] != "Off" && jsondata["user_subscription"]!="Off" ){
          setState(() {
            showsub=true;
          });
        }else{
          setState(() {
            showsub=false;
          });
        }

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
  void startDownloading(var filename) async{
    String url ='http://110.173.135.111/fac/cv/$filename';
    // const String fileName="Doc8.docx";
    //print("file path ::: ::::::: ::::$fileName ");
    String path = await _getFilePaths(filename);
    print("file path ::: ::::::: ::::::::: $path");
    if(await File(path).exists()){
      print("helllo its working here you can use it now :: :   ::::::::::::::::::::::::");
    }

    if(await File(path).exists()) {
      final result = Platform.isIOS?await OpenFile.open(path) :await OpenFile.open("/storage/emulated/0/Download/$filename");
      print("hello its file here exists :::::::::::::::::::::::::::");
      setState(() {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(result.message),
            duration: Duration(seconds: 2 ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      });
    }else{
      show_dialoge(filename,path);
      await dio.download(
        url,
        path,
        onReceiveProgress: (recivedBytes, totalBytes) {
          setState(() {
            print("hello ::::::::::::::::downloading");
            prog = recivedBytes / totalBytes;
            downloading=(prog* 100).toInt().toString();
            if(downloading=="100"){
              Navigator.pop(context);
              show_dialoge(filename,path);
            }
          });
          print("your progreess ::::::::::::::::::::: $prog");
        },
        deleteOnError: true,
      ).then((_) {
        //Navigator.pop(context);
      });
    }
  }

  _getFilePaths(String fileName) async {
    Directory downloadsDirectory = Platform.isAndroid
        ? Directory('/storage/emulated/0/Download')
        : await getApplicationDocumentsDirectory();
    print("its your ios path ::::::: : ::::: ${downloadsDirectory.path}");
    return '${downloadsDirectory.path}/$fileName';
  }

  checkPermisson() async{
    if (Platform.isAndroid) {
      AndroidDeviceInfo build = await DeviceInfoPlugin().androidInfo;
      // print("your sdk version is :::: :::::::::::::::::::::::  ${build.version.release}");
      // print("your sdk version is :::: :::::::::::::::::::::::  ${build.version.release}");
      // build.version.sdkInt>=30?await Permission.photos.status:
      //build.version.sdkInt>=30?await Permission.photos.request():
      if(build.version.sdkInt >=33){
        var isStorage =await Permission.photos.status;
        print("your storage permission is  ${isStorage}");
        if(!isStorage.isGranted){
          var  isStorage2= await Permission.photos.request();
          if(!isStorage2.isGranted){
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.white,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Storage permission required !!",style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),)
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      openAppSettings();
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("Open app Setting"),
                    ),
                  ),
                ],
              ),
            );
            return false;
          }else{
            setState(() {
              isPermission = true;
            });
            return true;
          }
        }else{
          setState(() {
            isPermission = true;
          });
        }
      }else{
        var isStorage =await Permission.storage.status;
        print("your storage permission is  ${isStorage}");
        if(!isStorage.isGranted){
          var  isStorage2= await Permission.storage.request();
          if(!isStorage2.isGranted){
            showDialog(
              context: context,
              builder: (ctx) => AlertDialog(
                backgroundColor: Colors.white,
                content: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(
                        height: 20,
                      ),
                      Text("Storage permission required !!",style: TextStyle(
                          color: Colors.black,
                          fontSize: 17
                      ),)
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(ctx).pop();
                      openAppSettings();
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("Open app Setting"),
                    ),
                  ),
                ],
              ),
            );
            return false;
          }else{
            setState(() {
              isPermission = true;
            });
            return true;
          }
        }else{
          setState(() {
            isPermission = true;
          });
        }
      }
    }else{
      var isStorage =await Permission.storage.status;
      print("your storage permission is ::::::::::::::::: ${isStorage}");
      if(!isStorage.isGranted){
        var  isStorage2= await Permission.storage.request();
        if(!isStorage2.isGranted){
          showDialog(
            context: context,
            builder: (ctx) => AlertDialog(
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Text("Storage permission required !!",style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),)
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(ctx).pop();
                    openAppSettings();
                  },
                  child: Container(
                    color: Colors.green,
                    padding: const EdgeInsets.all(14),
                    child: const Text("Open app Setting"),
                  ),
                ),
              ],
            ),
          );
          return false;
        }else{
          setState(() {
            isPermission = true;
          });
          return true;
        }
      }else{
        setState(() {
          isPermission = true;
        });
      }
    }


  }
  void show_dialoge(var filename,var path)async{
    String downloading =(prog* 100).toInt().toString();
    showDialog(
      context: context,
      builder: (ctx) => StatefulBuilder(
          builder: (context, setStat) {
            return AlertDialog(
              backgroundColor: Colors.white,
              content: SingleChildScrollView(
                child: Column(
                  children: [
                    downloading != "100"?const CircularProgressIndicator.adaptive():Container(),
                    const SizedBox(
                      height: 20,
                    ),
                    downloading != "100"?Text("Downloading : $downloading %",style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),):Text("Download Complete",style: TextStyle(
                        color: Colors.black,
                        fontSize: 17
                    ),)
                  ],
                ),
              ),
              actions: [
                if(downloading == "100")
                  TextButton(
                    onPressed: ()async {
                      Navigator.of(ctx).pop();
                      final result =Platform.isIOS?await OpenFile.open(path) :await OpenFile.open("/storage/emulated/0/Download/$filename");
                      setState(() {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(result.message),
                            duration: Duration(seconds: 2 ),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                          ),
                        );
                      });
                    },
                    child: Container(
                      color: Colors.green,
                      padding: const EdgeInsets.all(14),
                      child: const Text("open file"),
                    ),
                  ),
              ],
            );
          }
      ),
    );

  }


  @override
  void initState() {
    checkPermisson();
    showSub(context);
    membershipDetails(context);
    super.initState();
    fetch();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Talent Pool",
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Profile Matched",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20),),
              SizedBox(height: 20,),
              if(talentList.isNotEmpty)
                for (var talent in talentList)
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                child: Image(
                                  image: NetworkImage("$photo/${talent["profile_img"]}"),
                                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Container(
                          height: 55,
                          width: 50,
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
                                  height: 65, width: 50,),
                              ),
                              SizedBox(width: 10,),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(talent["user_name"] ?? "", style: GoogleFonts.rubik(fontWeight: FontWeight.w500, fontSize: 15),),
                                  Text(talent["skills"] ?? "", style: GoogleFonts.rubik(color: Colors.grey, fontSize: 13),),
                                ],
                              ),
                              Spacer(flex: 2,),
                              GestureDetector(
                                onTap: () {

                                  iid=talent["user_apply_jop_id"];
                                  iddname=talent["user_name"];
                                  iddem=talent["email_id"];
                                  iddimg=talent["profile_img"];
                                  Navigator.pushNamed(context, "applicants");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDF9F0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        iid=talent["user_id"];
                                        iddname=talent["user_name"];
                                        iddem=talent["email_id"];
                                        iddimg=talent["profile_img"];
                                      });
                                      Navigator.pushNamed(context, "applicants");
                                    },
                                    icon: Icon(Icons.mail, color: Colors.green,),
                                  ),
                                ),
                              )
                            ],
                          ),
                          Divider(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 35,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                        backgroundColor: Color(0xFF118743),
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(10))),
                                    onPressed: () {
                                      //Navigator.pushNamed(context, "sr");
                                      setState(() {
                                        //iid=talent["user_id"];
                                      });
                                      print("hhhhhhhhellllllllooooooooooo :::::::::KLLKLK::::::::: ${talent["user_id"]} ");
                                      serr(context,talent["user_id"]);

                                    },
                                    child: Text(
                                      "See Resume",
                                      style: GoogleFonts.rubik(
                                          color: Colors.white, fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  width: MediaQuery.of(context).size.width * 0.35,
                                  height: 35,
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        side: BorderSide(color: Color(0xFF118743)),
                                      ),
                                    ),
                                    onPressed: () {
                                      if(showsub == true) {
                                        if (membert != "") {
                                          if (membert == "Paid") {
                                            setState(() {
                                              iid = talent["user_id"];
                                            });
                                            print(
                                                "hhhhhhhhellllllllooooooooooo ::::::::::::::: ");

                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DeTalent(
                                                            user_id: talent["user_id"])));
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "To See details buy Subscription"),
                                                duration: Duration(seconds: 2),
                                                shape:
                                                RoundedRectangleBorder(
                                                    borderRadius: BorderRadius
                                                        .circular(
                                                        40)),
                                              ),
                                            );
                                            Navigator.push(context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Subscription(
                                                            callback: callback_mem)));
                                          }
                                        }
                                      }else{
                                        setState(() {
                                          iid = talent["user_id"];
                                        });
                                        print(
                                            "hhhhhhhhellllllllooooooooooo ::::::::::::::: ");

                                        Navigator.push(context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DeTalent(
                                                        user_id: talent["user_id"])));
                                      }
                                     // vdd(context);
                                     //  Navigator.pushNamed(context, "de");

                                    },
                                    child: Text(
                                      "See Details",
                                      style: GoogleFonts.rubik(
                                          color: Color(0xFF118743), fontSize: 15),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
              if(talentList.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "No Seeker Found",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

  Future<void>fetch() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_skill"] = selectedText.toString();

    var res = await http.post(Uri.parse("$mainurl/talent_pool.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print("hello its talent pool data $jsondata");

    if (res.statusCode == 200) {
      setState(() {
        talentList = List<Map<String, dynamic>>.from(jsondata['talent_pool']);
      });

    } else {
      throw Exception('Failed to load user skills');
    }
  }
  vdd(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_apply_jop_id"] = iid.toString();
    map["user_id"]=user_id.toString();

    var res = await http.post(
        Uri.parse("$mainurl/user_applied_jops_details_show.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        Navigator.push(context, MaterialPageRoute(builder: (context)=>De(cate: "",user_id: "",)));
        // Navigator.pushNamed(context, "de");
      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription(callback: callback_mem)));

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

  serr(context,var userid) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]=userid;

    var res = await http.post(
        Uri.parse("$mainurl/user_details_show.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        if(jsondata["user_resume"] != null) {
          startDownloading(jsondata["user_resume"]);
        }else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("No Resume Found!"),
              duration: Duration(seconds: 2 ),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }

      } else {

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsondata["error_msg"]),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Subscription(callback: callback_mem)));
      }
    }
  }



}
