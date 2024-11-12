import 'dart:collection';
import 'dart:ffi';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:fac/home/subb.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/fetchdata.dart';
import 'package:fac/welcome/login.dart';
import 'package:fac/welcome/rnp.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../welcome/choose.dart';

var go = "";

class Drawres extends StatefulWidget {
  const Drawres({super.key});

  @override
  State<Drawres> createState() => _DrawresState();
}

class _DrawresState extends State<Drawres> {
  List<String> resumes = []; // List to store resume file names
  List<String> resumes_ids = []; // List to store resume file names
  bool isLoading = true;
  bool isPermission = false;
  Dio dio =Dio();
  double prog =0.000;
  String downloading ="";
  var showsub = false;
  void callback_mem(var data){
    setState(() {
      membershipDetails(context);
    });
  }

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
          membertype=jsondata["membership_type"];
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
      show_dialoge(filename);
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
              show_dialoge(filename);
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
                      color: Color(0xFF118743),
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
                      color: Color(0xFF118743),
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
                    color: Color(0xFF118743),
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

  void show_dialoge(var filename)async{
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
                    onPressed: () async{
                      Navigator.of(ctx).pop();
                      final result =await OpenFile.open("/storage/emulated/0/Download/$filename");
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
                      color: Color(0xFF118743),
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

  Future<String> _getFilePath(String filname)async{
    final dir = await getExternalStorageDirectory();
    print("your fvioerfokljkj ${dir!.parent} , ${dir.uri}");
    return "${dir!.path}/$filname";
  }

  void callBack(String cat){
    setState(() {
      Fetch();
    });
  }

  @override
  void initState() {
    checkPermisson();
    showSub(context);
    Fetch();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "My Resumes",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            if(Navigator.canPop(context))
              Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: isLoading
              ? Center(child: CircularProgressIndicator(color: Color(0xFF118743),)) // Show a loading indicator while fetching resumes
              : resumes.isNotEmpty
              ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),

                  Text(
                    "My Resumes",
                    style: GoogleFonts.rubik(color: Colors.grey, fontSize: 20),
                  ),
                  SizedBox(height: 10),

                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: resumes.length,
                    itemBuilder: (context, index) {
                      return ResumeCard(resumeFileName: resumes[index],id: "${resumes_ids[index]}");
                    },
                  ),
                  SizedBox(height: 30,),
                  Padding(
                    padding: const EdgeInsets.only(left: 40,right: 40),
                    child: Container(
                        width: double.infinity,
                        height: 45,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF118743),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            if(showsub==true) {
                              if (membertype == "Paid") {
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Rnp(callback: callBack)));
                              } else if (membertype == "Free" ||
                                  membertype == null || membertype == "") {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "Buy Subscription to add more!!"),
                                    duration: Duration(seconds: 2),
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                        BorderRadius.circular(40)),
                                  ),
                                );
                                Navigator.push(context, MaterialPageRoute(
                                    builder: (context) =>
                                        Subb(callback: callback_mem)));
                              }
                            }else{
                              Navigator.push(context, MaterialPageRoute(builder: (context)=>Rnp(callback: callBack)));
                            }
                          },
                          child: Text(
                            "ADD RESUME",
                            style: GoogleFonts.rubik(
                                color: Colors.white, fontSize: 15),
                          ),
                        )),
                  ),
                ],
              )
              : Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.36,),
                  Center(
                    child:
                    Text("Nothing Yet",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 20),),
                  ),
                  SizedBox(height: 10,),
                  Container(
                      width: MediaQuery.of(context).size.width / 1.4,
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF118743),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Rnp(callback: callBack)));
                          // if (membertype == "Paid") {
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Rnp(callback: callBack)));
                          // } else if (membertype == "Free" ||
                          //     membertype == null||membertype=="") {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text(
                          //           "Buy Subscription to add more!!"),
                          //       duration: Duration(seconds: 2),
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius:
                          //           BorderRadius.circular(40)),
                          //     ),
                          //   );
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                          // }
                        },
                        child: Text(
                          "ADD RESUME",
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

  Widget ResumeCard({required String resumeFileName,required String id}) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              go = resumeFileName;
              print(resumeFileName);
            });
            print("your file picker is $c_v/$resumeFileName}");
            // show_dialoge(resumeFileName);
            print("tyuiofghjklvbnm $isPermission");
            if(isPermission) {
              startDownloading(resumeFileName);
            }else{
              checkPermisson();
            }
            //download();

            //OpenFile.open("$mainurl/fac/cv/$resumeFileName");
           // Navigator.pushNamed(context, "hwr");
          },
          child: Container(
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Image(image: AssetImage("assets/file.png"),width: 30,),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    '${resumeFileName}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Spacer(flex: 2,),
                  InkWell(
                    onTap: (){
                      deleteRes(id);
                    },
                      child: Icon(Icons.delete_forever,))
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future Fetch() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id.toString(),
    };

    try {
      final response = await http.post(
        Uri.parse('$mainurl/my_resumes.php'),
        body: jsonEncode(map),
      );
      print(map);
      dynamic jsondata = jsonDecode(response.body);
      print("YOur resume data is ::::: : :: :: : : :$jsondata");
      if (response.statusCode == 200) {
        print("okkkkkk");
        if(jsondata["error"]==0){
          List<dynamic> resumeList = jsondata['cover_later'];
          if(resumes.isNotEmpty){
            resumes.clear();
            resumes_ids.clear();
          }
          for (var resume in resumeList) {
            resumes.add(resume['user_resume']);
            resumes_ids.add(resume['resume_id']);
          }
          setState(() {
            isLoading = false;
          });
        }else{
          if(resumes.isNotEmpty) {
            setState(() {
              resumes.clear();
              resumes_ids.clear();
            });
          }
          setState(() {
            isLoading = false;
          });
        }
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception("Failed to load profile data");
      }
    } catch (e) {
      print('Error while fetching profile: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
  Future deleteRes(var id) async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id.toString(),
      "resume_id":id,
    };

    try {
      final response = await http.post(
        Uri.parse('$mainurl/resumes_delete.php'),
        body: jsonEncode(map),
      );
      print(map);
      dynamic jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200) {
        setState(() {
          Fetch();
          isLoading=false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        throw Exception("Failed to load profile data");
      }
    } catch (e) {
      print('Error while fetching profile: $e');
      setState(() {
        isLoading = false;
      });
    }
  }
}
