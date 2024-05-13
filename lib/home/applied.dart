import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fac/employeer/bottom.dart';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:permission_handler/permission_handler.dart';
class Applied extends StatefulWidget {
  const Applied({super.key});

  @override
  State<Applied> createState() => _AppliedState();
}

class _AppliedState extends State<Applied> {

  var rowww="";
  bool _isLoading = true;

  List<dynamic> peoplist = [];

  bool isPermission = false;
  Dio dio =Dio();
  double prog =0.0;
  String downloading ="0.0";

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
  @override
  void initState() {
    checkPermisson();
    membershipDetails(context);
    peopleapplied(context);
    super.initState();
  }


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
        title: Text("People Applied", style: GoogleFonts.rubik()),
      ),
      body:  _isLoading
          ? Center(
          child: CircularProgressIndicator(color: Colors.green[700],),
      )
          :SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 5,),
            if(peoplist.length>0)
              for (var peopc in peoplist)
                peopleContainer(peopc, context),
            if(peoplist.length==0)
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
          ],
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
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
        print("your list of people applied is :::::: $peoplist");

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
      setState(() {
        _isLoading=false;
      });
    } else {
      print('error');
    }

  }
  Widget peopleContainer(dynamic peopc,BuildContext context) {
    return Padding(
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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  if (peopc["profile_img"] != "")
                    Container(
                      child: ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image(
                            image:
                            NetworkImage("$photo/${peopc["profile_img"]}"),
                            height: 65,
                            width: 65,
                            fit: BoxFit.cover,
                          )),
                    ),
                  if (peopc["profile_img"] == "")
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage("assets/person.png"),
                          height: 65,
                          width: 65,
                          fit: BoxFit.cover,
                        )),
                  SizedBox(width: 10,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(peopc["name"],style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 15),),

                      Text("For:${peopc["open_position"]}",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 13),),
                    ],
                  ),
                  Spacer(flex: 2,),
                  GestureDetector(
                    onTap: (){
                      Navigator.pushNamed(context, "applicants");
                      iid=peopc["user_apply_jop_id"];
                      iddname=peopc["name"];
                      iddem=peopc["confirm_email"];

                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEDF9F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(onPressed: (){
                        Navigator.pushNamed(context, "applicants");
                        iid=peopc["user_apply_jop_id"];
                        iddname=peopc["name"];
                        iddem=peopc["confirm_email"];



                      }, icon: Icon(Icons.mail,color: Colors.green,),),
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
                        width:MediaQuery.of(context).size.width * 0.35 ,
                        height: 35,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF118743),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            //  Navigator.pushNamed(context, "sr");
                           setState(() {
                             iid=peopc["user_apply_jop_id"];
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
                        width:MediaQuery.of(context).size.width * 0.35 ,
                        height: 35,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Color(0xFF118743)),)),
                          onPressed: () {
                            if(membert !=""){
                              if(membert == "Paid"){
                                setState(() {
                                  iid=peopc["user_apply_jop_id"];
                                  applicant_id = peopc["applicant_id"];
                                });
                                viewdetails(context);
                              }else{
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
      ),
    );

  }


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



