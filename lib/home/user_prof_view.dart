import 'dart:collection';
import 'dart:convert';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import '../starting/splashscreen.dart';
import '../welcome/login.dart';

class UserProfView extends StatefulWidget {
  var userId;
  UserProfView({required this.userId});

  @override
  State<UserProfView> createState() => _UserProfViewState();
}

class _UserProfViewState extends State<UserProfView> {
  var ig;
  var docList;
  var name = "";
  var email = "";
  var about = "";
  var no = "";
  var fb = "";
  var insta = "";
  var twit = "";
  var linked = "";
  var appl="";
  var sele="";
  var inte="";
  var isLoading=true;
  int selectedButtonIndex = 0;

  var degree = "";
  var iname = "";
  var course = "";
  var sp = "";
  var start = "";
  var end = "";
  var showOther=false;
  double ratinggg=0.0;
  bool _isLoading = true;
  bool isPermission = false;
  Dio dio =Dio();
  double prog =0.000;
  String downloading ="";
  List<String> resumes = []; // List to store resume file names
  List<String> resumes_ids = [];
  List<Map<String, dynamic>> userSkills = [];
  List<String> portfolioImages = [];
  List<dynamic> userPorti = [];



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
    map["user_id"] = widget.userId;

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
  Future Fetch() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id":widget.userId,
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



  @override
  void initState() {
    checkPermisson();
    fetchProfile();
    Fetch();
    selectedButtonIndex = 0;
    setState(() {
      inside = true;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
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
        title: Text("Details", style: GoogleFonts.rubik()),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              if (ig != "")
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.transparent,
                  backgroundImage: NetworkImage("$photo/$ig"),
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              if (ig == "")
                CircleAvatar(
                  radius: 90,
                  backgroundColor: Colors.transparent,
                  backgroundImage: AssetImage("assets/img.png"),
                  child: Container(
                    foregroundDecoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              SizedBox(
                height: 10,
              ),
              Text(
                "$name",
                style: GoogleFonts.rubik(
                    fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 2),
              Text(
                "$email",
                style: GoogleFonts.rubik(),
              ),
              SizedBox(
                height: 5,
              ),
              if (membertype == "Paid")
                Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 2,
                        ),
                      ],
                      color: Colors.amberAccent,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Text(
                        "Premium Member",
                        style: GoogleFonts.rubik(color: Colors.orange,fontWeight: FontWeight.w400),
                      ),
                    )),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildTextButton(0, "Personal Info"),
                  SizedBox(
                    width: width/6,
                  ),
                  buildTextButton(1, "Portfolio"),
                ],
              ),
              IndexedStack(
                index: selectedButtonIndex,
                children: [
                  buildContainerForIndex(0,width,height),
                  buildContainerForIndex(1,width,height),
                ],
              ),

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

                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
  TextButton buildTextButton(int index, String text) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedButtonIndex = index;
        });
        if (selectedButtonIndex == 1) {
          pooo(context);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selectedButtonIndex == index
                  ? Color(0xFF118743)
                  : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(bottom: 5),
          child: Text(
            text,
            style: GoogleFonts.rubik(
              fontSize: 10,
              color: selectedButtonIndex == index
                  ? Color(0xFF118743)
                  : Colors.black,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildContainerForIndex(int index,var width ,var height) {
    // print("dl2: $dl");
    // print("pp2: $pp");
    // print("bc2: $bc");

    switch (index) {
      case 0:
        return Container(
          child: Column(
            children: [
              Container(
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("My Skills",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 20),
                      if (userSkills != null && userSkills.isNotEmpty)
                        Wrap(
                          spacing: 20.0,
                          runSpacing: 16.0,
                          children: List.generate(
                            (userSkills.length / 2).ceil(),
                                (index) {
                              int startIndex = index * 2;
                              int endIndex = (index + 1) * 2;
                              endIndex = endIndex > userSkills.length
                                  ? userSkills.length
                                  : endIndex;

                              return Row(
                                children: [
                                  ...userSkills
                                      .sublist(startIndex, endIndex)
                                      .map(
                                        (skill) => Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        Container(
                                          width: MediaQuery.of(context)
                                              .size
                                              .width *
                                              0.35,
                                          padding: EdgeInsets.all(8),
                                          decoration: BoxDecoration(
                                            borderRadius:
                                            BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey
                                                    .withOpacity(0.2),
                                                spreadRadius: 2,
                                                blurRadius: 2,
                                              ),
                                            ],
                                            color: Colors.white38,
                                          ),
                                          child: Text(skill["skills"],
                                              textAlign: TextAlign.center),
                                        ),
                                        Positioned(
                                          top: -10,
                                          right: 3,
                                          child: Container(
                                            padding: EdgeInsets.only(
                                                left: 7,
                                                right: 7,
                                                top: 2,
                                                bottom: 2),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.grey
                                                      .withOpacity(0.2),
                                                  spreadRadius: 2,
                                                  blurRadius: 2,
                                                ),
                                              ],
                                              color: Color(0xFF118743),
                                            ),
                                            child: Text(
                                              skill["experience"],
                                              style: GoogleFonts.rubik(
                                                  color: Colors.white,
                                                  fontSize: 8),
                                              textAlign: TextAlign.center,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                      .expand((widget) => [
                                    widget,
                                    SizedBox(width: 20),
                                  ]),
                                ],
                              );
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Education",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 15),
                      if (degree == null || degree == "")
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
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                    child: Text(
                                      "Nothing Yet",
                                      style: GoogleFonts.rubik(color: Colors.grey),
                                    )),
                              )),
                        ),
                      if (degree != "" && degree != null)
                        Wrap(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Degree:",
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                                Text(
                                  "$degree",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Univ/College: ",
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    "$iname",
                                    softWrap: true,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.right,
                                    style: GoogleFonts.rubik(
                                        fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Course:",
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                                Text(
                                  "$course",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Specialization:",
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                                Text(
                                  "$sp",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Starting Year:",
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                                Text(
                                  "$start",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Ending Year:",
                                  style: GoogleFonts.rubik(color: Colors.grey),
                                ),
                                Text(
                                  "$end",
                                  style: GoogleFonts.rubik(
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            )
                          ],
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("About Me",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 15),
                      if(about!="")
                        Text(
                          "$about",
                          style: GoogleFonts.rubik(color: Colors.grey),
                        ),
                      if(about=="")
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
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                    child: Text(
                                      "Nothing Yet",
                                      style: GoogleFonts.rubik(color: Colors.grey),
                                    )),
                              )),
                        ),

                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Contact Here",
                          style:
                          GoogleFonts.rubik(fontWeight: FontWeight.w500)),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Icon(
                            Icons.phone,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text("$no")
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.mail,
                            color: Colors.black,
                          ),
                          SizedBox(width: 20),
                          Text("$email")
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Social Media",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 15),
                      if (insta != null && insta!.isNotEmpty)
                        Row(
                          children: [
                            Icon(
                              Icons.receipt_outlined,
                              color: Colors.black,
                            ),
                            SizedBox(width: 20),
                            Container(
                                width:MediaQuery.of(context).size.width/1.5,
                                child: Text("$insta",maxLines: 4,softWrap: true,))
                          ],
                        ),
                      SizedBox(
                        height: 10,
                      ),
                      if (linked != null && linked!.isNotEmpty)
                        Row(
                          children: [
                            Icon(
                              Icons.link,
                              color: Colors.black,
                            ),
                            SizedBox(width: 20),
                            Container(
                                width:MediaQuery.of(context).size.width/1.5,
                                child: Text("$linked",maxLines: 4,softWrap: true,overflow: TextOverflow.ellipsis,))
                          ],
                        ),
                      if(linked==""&&insta=="")
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
                                color: Colors.white,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Center(
                                    child: Text(
                                      "Nothing Yet",
                                      style: GoogleFonts.rubik(color: Colors.grey),
                                    )),
                              )),
                        ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
              Container(
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
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("My Resume",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500)),
                        ],
                      ),
                      SizedBox(height: 15),
                      isLoading
                          ? Center(child: CircularProgressIndicator(color: Colors.green[700],)) // Show a loading indicator while fetching resumes
                          : resumes.isNotEmpty
                          ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 20),
                            ResumeCard(resumeFileName: resumes[0],id: "${resumes_ids[0]}"),
                            SizedBox(height: 30,),
                        ],
                      )
                          : Column(
                        children: [
                          SizedBox(height: 10),
                          Center(
                            child:
                            Text("Nothing Yet",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 20),),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        );
      case 1:
        return Container(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Portfolio",
                      style: GoogleFonts.rubik(fontSize: 20),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                // if (portfolioImages.isNotEmpty)
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: portfolioImages.length,
                  itemBuilder: (context, index) {
                    var imageUrl = portfolioImages[index];
                    var title = userPorti[index]["portfolio_title"];
                    var descrip = userPorti[index]["portfolio_description"];
                    return buildImageContainer(imageUrl, title, descrip,"${userPorti[index]["portfolio_id"]}",index);
                  },
                ),
              ],
            ),
          ),
        );
      default:
        return Container();
    }
  }

  Widget buildImageContainer(String imageUrl, String title, String descrip,var p_id,var i) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {

            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
                color: Colors.white,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Image.network(
                      "$photo/$imageUrl",
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future fetchProfile() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": widget.userId,
    };
    final response = await http.post(
      Uri.parse('$mainurl/prosnal_info.php'),
      body: jsonEncode(map),
    );
    print(map);
    dynamic jsondata = jsonDecode(response.body);
    print(jsondata);
    if (response.statusCode == 200) {
      print("okkkkkk");

      name = jsondata["user_name"];
      email = jsondata["email_id"];
      no = jsondata["mobile_number"];
      about = jsondata["about_me"];
      if(jsondata["total_apply_jop"]!=null){
        appl=jsondata["total_apply_jop"].toString();
      }else if(jsondata["total_apply_jop"]==null){
        appl="0";
      }

      if(jsondata["total_review_jop"]!=null){
        sele=jsondata["total_review_jop"].toString();
      }else if(jsondata["total_review_jop"]==null){
        sele="0";
      }
      if(jsondata["total_interview_jop"]!=null){
        inte=jsondata["total_interview_jop"].toString();
      }else if(jsondata["total_interview_jop"]==null){
        inte="0";
      }

      if (jsondata["facebook_url"] != null) {
        fb = jsondata["facebook_url"];
      }
      if (jsondata["instagram_url"] != null) {
        insta = jsondata["instagram_url"];
      }
      if (jsondata["twitter_url"] != null) {
        twit = jsondata["twitter_url"];
      }
      if (jsondata["linkedin_url"] != null) {
        linked = jsondata["linkedin_url"];
      }
      if (jsondata['user_skills'] != null) {
        List<Map<String, dynamic>> skills =
        List<Map<String, dynamic>>.from(jsondata['user_skills']);
        if(userSkills.length>0){
          userSkills.clear();
        }
        setState(() {
          userSkills = skills;
        });
      }
      setState(() {
        if (jsondata["profile_image"] == "" ||
            jsondata["profile_image"] == null) {
          setState(() {
            ig = "";
          });
        } else {
          setState(() {
            ig = jsondata["profile_image"];
          });
        }
        _isLoading = false;

      });
    } else {
      throw Exception("Failed to load profile data");
    }
  }
  Future<void> pooo(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = widget.userId;

    var res = await http.post(Uri.parse("$mainurl/portfolio_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          if (jsondata != null && jsondata["user_porti"] != null) {
            userPorti = jsondata["user_porti"];
            print("youoeuriwnrc   ehjwbfief o bevsi $userPorti");
            portfolioImages.clear();

            for (var row in userPorti) {
              var portfolioImage = row["portfolio_image"];
              portfolioImages.add(portfolioImage);
            }
          }
        });
      } else {
        // if(userPorti.isNotEmpty){
        //   userPorti.clear();
        //   portfolioImages.clear();
        // }
        setState(() {
          if(portfolioImages.isNotEmpty)
            portfolioImages.clear();
        });
      }
    } else {
      print('error');
    }
  }
}
