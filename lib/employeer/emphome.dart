import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:fac/employeer/post_chat.dart';
import 'package:fac/employeer/seeresume.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/welcome/login.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:table_calendar/table_calendar.dart';

var app_id = "";
var iid = "";
var iddname = "";
var iddem = "";
var iddimg = "";
var riteshsinghh = "";
var ohgod = "";


class Emphome extends StatefulWidget {
  const Emphome({super.key});

  @override
  State<Emphome> createState() => _EmphomeState();
}

var applicant_id ="";


class _EmphomeState extends State<Emphome> {
  String search = "";
  TextEditingController searchController = TextEditingController();
  // bool isAnalyticsVisible = false;
  // var tot="";
  // var sel="";
  // var rej="";
  // var vie="";
  CalendarFormat _format =CalendarFormat.month;
  DateTime _focusDay = DateTime.now();
  DateTime _currentDay = DateTime.now();
  int? currentIndex ;
  bool _isWeekend = false;
  bool _dateSelected=false;
  bool _timeSelected=false;

  bool isPermission = false;
  Dio dio =Dio();
  double prog =0.0;
  String downloading ="0.0";


  var roww = "";
  var rowww = "";
  var name = "";
  var pp = "";
  List<dynamic> vacancies = [];
  List<dynamic> peoplist = [];
  var membert="";
  var showsub = false;
  var postList;



  Map<DateTime,List<Event>> events={};

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
        if(jsondata["user_subscription"]!="Off"){
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
  void startDownloading(var filename) async{
    String url ='http://103.99.202.191/fac/cv/$filename';
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

  Future _postList() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/all_post.php");
      Map mapdata = {
        "updte":1,
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
            postList=data;
          });
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
          return  data;
        }else{
          setState(() {
            postList=[];
          });
          //MotionToast.error(description: Text(data["error_msg"]));
        }
      }else{
        setState(() {
          postList=[];
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

      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }

  @override
  void initState() {
    showSub(context);
    _postList();
    checkPermisson();
    membershipDetails(context);

    super.initState();
    Fetch(context);
    activevacancies(context);
    peopleapplied(context);
  }

  Future<bool> _onBackPressed(BuildContext context) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Exit'),
          content: const Text('Are you sure you want to exit?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            ),
            TextButton(
              child: const Text('Exit'),
              onPressed: () {
                Navigator.of(context).pop(true);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return WillPopScope(
      onWillPop: () => _onBackPressed(context),
      child: Scaffold(
        backgroundColor: Color(0xFFfafafd),
        body: RefreshIndicator(
          onRefresh: () async {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => Emphome()));
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome Back !",
                            style: GoogleFonts.rubik(
                                color: Colors.grey,
                                fontSize: 20,
                                fontWeight: FontWeight.w400),
                          ),
                          Text(
                            "$name 👋",
                            style: GoogleFonts.rubik(
                                fontSize: 25, fontWeight: FontWeight.w600),
                          )
                        ],
                      ),
                      Stack(
                        children: [
                          Container(
                            height: 85,
                            width: 85,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                image: NetworkImage("$photo/$pp"),
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          if (membertype == "Paid")
                            Positioned(
                              top: 0,
                              right: 3,
                              child: Container(
                                width: 30,
                                height: 30,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.amberAccent,
                                  border: Border.all(
                                    color: Colors.amber,
                                    // Set your desired border color
                                    width: 2.0,
                                  ),
                                ),
                                child: Icon(
                                  Icons.auto_awesome_outlined,
                                  color: Colors.orange,
                                ),
                              ),
                            ),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: searchController,
                          cursorColor: Color(0xFF118743),
                          onChanged: (text) {
                            setState(() {
                              search = text;
                            });
                          },
                          //controller: textEditingController,
                          //focusNode: focusNode,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey[200],
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20.0),
                                borderSide: BorderSide.none,
                              ),
                              hintText: 'Search a skill here',
                              prefixIcon: Icon(
                                Icons.search,
                                color: Colors.grey,
                              )),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        child: Container(
                          height: 50,
                          width: 100,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green[700],
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                riteshsinghh = "${searchController.text}";
                              });
                              if (riteshsinghh == "") {
                                print("herei am;");
                              } else if (riteshsinghh != "") {
                                print("oh no");
                                Navigator.pushNamed(context, "semp");
                              }
                            },
                            child: Text(
                              "Search",
                              style: GoogleFonts.baloo2(color: Colors.white),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "My Vacancies",
                        style: GoogleFonts.rubik(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "application");
                        },
                        child: Text(
                          "See All",
                          style: GoogleFonts.rubik(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (vacancies.isNotEmpty)
                    vacancyContainer(vacancies[0], context),
                  if (roww == "0")
                    Container(
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Nothing Yet",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey,
                                  fontSize: 17),
                            ),
                            Container(
                                width: MediaQuery.of(context).size.width * 0.20,
                                height: 35,
                                child: TextButton(
                                  style: TextButton.styleFrom(
                                      backgroundColor: Color(0xFF118743),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10))),
                                  onPressed: () {
                                    Navigator.pushNamed(context, "vj");
                                  },
                                  child: Text(
                                    "+ADD",
                                    style: GoogleFonts.rubik(
                                        color: Colors.white, fontSize: 15),
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 30,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Recent People Applied",
                        style: GoogleFonts.rubik(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, "app");
                        },
                        child: Text(
                          "See All",
                          style: GoogleFonts.rubik(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: Colors.green),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  if (peoplist.isNotEmpty)
                    peopleContainer(peoplist[0], context),
                  if (peoplist.isEmpty)
                    Container(
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
                          "Nothing Yet",
                          style: GoogleFonts.rubik(
                              fontWeight: FontWeight.w500,
                              color: Colors.grey,
                              fontSize: 17),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Job Seekers Posts",
                        style: GoogleFonts.rubik(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      ),
                      // GestureDetector(
                      //   onTap: () {
                      //     Navigator.pushNamed(context, "application");
                      //   },
                      //   child: Text(
                      //     "See All",
                      //     style: GoogleFonts.rubik(
                      //         fontSize: 15,
                      //         fontWeight: FontWeight.w500,
                      //         color: Colors.green),
                      //   ),
                      // ),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  postList == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      if(postList == null)
                        Center(child: CircularProgressIndicator(color: Colors.green,)),
                      if(postList.length == 0)
                        Center(child: Text("No Post Available")),
                      if(postList != null && postList.length !=0)
                        for(int i=0; i<postList["rows"];i++)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Posts(width,height,postList["deta"][i]),
                          )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Bottom(),
      ),
    );
  }

  Fetch(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/employer_profile.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          name = jsondata["user_name"];
          pp = jsondata["profile_image"];

          membertype = jsondata["membership_type"];
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print(membertype);
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
          print("\n\n\n\n\n\n\n");
        });
      } else {}
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

  activevacancies(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/active_vacancies.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        roww = jsondata["rows"].toString();

        if (jsondata["row"] != null || jsondata["rows"] != 0) {
          setState(() {
            vacancies = jsondata["user_skills"];
          });
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
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

  peopleapplied(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;


    var res = await http.post(Uri.parse("$mainurl/all_applications.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::hey i am in::$map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        rowww=jsondata["rows"].toString();

        if(jsondata["rows"]!=null||jsondata["rows"]!=0) {
          setState(() {
            peoplist = jsondata["people_jop_applied_list"];
          });
        }

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("No data found"),
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

  peopleapplieded(context) async {

    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(
        Uri.parse("$mainurl/employer_latest_message.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("New----Mapped::::::$map");
    print(jsondata);
    print('MR.BOSS--->`');

    if (res.statusCode == 200) {
        ohgod = jsondata["error_msg"];
        rowww = jsondata["rows"].toString();

        if (jsondata["rows"] != null || jsondata["rows"] != 0) {
          setState(() {
            peoplist = jsondata["people_jop_applied_list"];
          });
        }

    } else {
      print('error');
    }
  }
  Widget vacancyContainer(dynamic vacancy, BuildContext context) {

    bool isActive = vacancy["is_active"] == "1";

    return GestureDetector(
      onTap: () {
        print(vacancy["jop_vacancy_id"]);
        app_id = vacancy["jop_vacancy_id"];
        Navigator.pushNamed(context, "vj");
      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Image(
                      image: NetworkImage("$photo/${vacancy["jop_image"]}"),
                      height: 65,
                      width: 50,
                    ),
                  ),
                  SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        vacancy["open_position"],
                        style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
                      ),
                      SizedBox(height: 2),
                      Text(
                        vacancy["location"],
                        style: GoogleFonts.rubik(),
                      ),
                      Text(
                        "${vacancy["type"]}",
                        style: GoogleFonts.rubik(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                      Text(
                        "${vacancy["salary"]}",
                        style: GoogleFonts.rubik(
                          color: Colors.grey,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  Spacer(flex: 2),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: isActive ? Color(0xFFEDF9F0) : Color(0xFFF9EDED),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 12,right: 12,top: 8,bottom: 8),
                          child: Text(
                            isActive ? "Active" : "Inactive",
                            style: GoogleFonts.rubik(
                                color:
                                isActive ? Color(0xFF00C152) : Color(0xFFC10000)),
                          ),
                        ),
                      ),
                      SizedBox(height: 5),
                      Container(
                          width: MediaQuery.of(context).size.width * 0.22,
                          height: 35,
                          child: TextButton(
                            style: TextButton.styleFrom(
                                backgroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  side: BorderSide(color: Color(0xFF118743)),
                                )),
                            onPressed: () {
                              // setState(() {
                              //   isAnalyticsVisible = !isAnalyticsVisible;
                              //   app_id = vacancy["jop_vacancy_id"];
                              // });
                             // fetchplease(context);

                              setState(() {
                                app_id = vacancy["jop_vacancy_id"];
                              });
                              Navigator.pushNamed(context, "single");

                              print("#");
                            },
                            child: Text(
                              // isAnalyticsVisible ? "Hide" : "Analytics",
                              "Applicants",
                              style: GoogleFonts.rubik(
                                  color: Color(0xFF118743), fontSize: 12),
                            ),
                          )),
                    ],
                  ),
                ],
              ),
              // if (isAnalyticsVisible)
              //   Column(
              //     crossAxisAlignment: CrossAxisAlignment.start,
              //     children: [
              //       SizedBox(height: 10,),
              //       Text("People Applied: $tot",style: GoogleFonts.rubik(color: Colors.grey),),
              //       Text("Selected: $sel",style: GoogleFonts.rubik(color: Colors.grey),),
              //       Text("Rejected: $rej",style: GoogleFonts.rubik(color: Colors.grey),),
              //       Text("Interviewed: $vie",style: GoogleFonts.rubik(color: Colors.grey),),
              //     ],
              //   )
            ],
          ),
        ),
      ),
    );
  }
  Widget peopleContainer(dynamic peoplist, BuildContext context) {
    return Container(
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
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                if (peoplist["profile_img"] != "")
                  Container(
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image:
                          NetworkImage("$photo/${peoplist["profile_img"]}"),
                          height: 65,
                          width: 65,
                          fit: BoxFit.cover,
                        )),
                  ),
                if (peoplist["profile_img"] == "")
                  ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: Image(
                        image: AssetImage("assets/person.png"),
                        height: 65,
                        width: 65,
                        fit: BoxFit.cover,
                      )),
                SizedBox(
                  width: 10,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      peoplist["name"],
                      style: GoogleFonts.rubik(
                          fontWeight: FontWeight.w500, fontSize: 15),
                    ),
                    Text(
                      "For: ${peoplist["open_position"]}",
                      style: GoogleFonts.rubik(color: Colors.grey, fontSize: 13),
                    ),
                  ],
                ),
                Spacer(
                  flex: 2,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, "applicants");
                    iid = peoplist["user_apply_jop_id"];
                    iddname = peoplist["name"];
                    iddem = peoplist["confirm_email"];
                    iddimg = peoplist["jop_image"];
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xFFEDF9F0),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "applicants");
                        iid = peoplist["user_apply_jop_id"];
                        iddname = peoplist["name"];
                        iddem = peoplist["confirm_email"];
                      },
                      icon: Icon(
                        Icons.mail,
                        color: Colors.green,
                      ),
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
                          // Navigator.pushNamed(context, "sr");
                          setState(() {
                            iid = peoplist["user_apply_jop_id"];

                          });
                          seeresume(context);
                        },
                        child: Text(
                          "See Resume",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 15),
                        ),
                      )),
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
                            )),
                        onPressed: () {
                          if(showsub==true) {
                            if (membert != "") {
                              if (membert == "Paid") {
                                setState(() {
                                  iid = peoplist["user_apply_jop_id"];
                                  applicant_id = peoplist["applicant_id"];
                                });

                                viewdetails(context);
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                        "To See details buy Subscription"),
                                    duration: Duration(seconds: 2),
                                    shape:
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
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
                              iid = peoplist["user_apply_jop_id"];
                              applicant_id = peoplist["applicant_id"];
                            });

                            viewdetails(context);
                          }
                          // Navigator.pushNamed(context, "de");

                        },
                        child: Text(
                          "See Details",
                          style: GoogleFonts.rubik(
                              color: Color(0xFF118743), fontSize: 15),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
  Widget Posts(var width,var height,var key){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.3,color: Colors.green)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    key["profile_img"] == "" ?Container(
                      height: (height/4)/5,
                      width: (width/3)/3,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: AssetImage("assets/place_img.jpeg"),
                              fit: BoxFit.cover
                          )
                      ),
                    ):Container(
                      height: (height/4)/5,
                      width: (width/3)/3,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              image: NetworkImage("$photo/${key["profile_img"]}"),
                              fit: BoxFit.cover
                          )
                      ),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(key["user_name"],style: TextStyle(fontWeight: FontWeight.w600),),
                        Text("Employment : ${key["preference"]}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),
                      ],
                    ),

                  ],
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>PostChat(jobPostId: key["job_seeker_post_id"],name: key["user_name"],profile: key["profile_img"],emp: key["preference"],isEmployer: true,)));
                    // iid = peoplist["user_apply_jop_id"];
                    // iddname = peoplist["name"];
                    // iddem = peoplist["confirm_email"];
                  },
                  icon: Icon(
                    Icons.mail,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 16.0),
                children: [
                  WidgetSpan(child: Icon(Icons.location_on,color: Colors.green,),),
                  // TextSpan(
                  //     text: 'Preferred Job Location: ',
                  //     style: TextStyle(fontWeight: FontWeight.w500)
                  // ),
                  TextSpan(
                    text: "${key["city"]} , ${key["state"]}",
                    style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Text(key["message"],
              textAlign: TextAlign.justify,
              style: TextStyle(
                fontWeight: FontWeight.normal,
              ),),
            SizedBox(
              height: 10,
            ),

            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Key Skill : ',
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                  ),
                  TextSpan(
                    text: key["skills"],
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              textAlign: TextAlign.left,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Preferred Jobs : ',
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                  ),
                  TextSpan(
                    text: "${key["job_type"]} as ${key["job_name"]} ,",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: " ${key["job_type_two"]} as ${key["job_name_two"]} ,",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                  TextSpan(
                    text: " ${key["job_type_three"]} as ${key["job_name_three"]}",
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RichText(
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 14.0),
                children: <TextSpan>[
                  TextSpan(
                    text: 'Salary Expectation : \$',
                    style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14),
                  ),
                  TextSpan(
                    text: key["salary_exp"],
                    style: TextStyle(fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }
  // fetchplease(context) async {
  //   HashMap<String, String> map = HashMap();
  //   map["updte"] = "1";
  //   map["jop_vacancy_id"] = app_id;
  //
  //   var res = await http.post(
  //       Uri.parse("$mainurl/employer_vacancy_user_count.php"),
  //       body: jsonEncode(map));
  //   print(res.body);
  //   dynamic jsondata = jsonDecode(res.body);
  //   print("i harleen here  $map");
  //   if (res.statusCode == 200) {
  //
  //     print(jsondata);
  //       setState(() {
  //         tot=jsondata["total_apply_jop"];
  //         sel=jsondata["total_selected"];
  //         rej=jsondata["total_rejected"];
  //         vie=jsondata["total_interviews"];
  //       });
  //
  //   }else{
  //     print("something..wrong");
  //   }
  // }

  seeresume(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_apply_jop_id"] = iid.toString();
    map["user_id"] = user_id.toString();

    var res = await http.post(
        Uri.parse("$mainurl/user_applied_jops_resume_show.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i harleen here  $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        startDownloading(jsondata["user_resume"]);
        //Navigator.pushNamed(context, "sr");
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
    }
  }

  viewdetails(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_apply_jop_id"] = iid.toString();
    map["user_id"] = user_id.toString();

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
        Navigator.pushNamed(context, "de");
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
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
    }
  }


}


class Event {
  late final String title;
  Event(this.title);

}



