import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:fac/employeer/messages.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

var uuser="";

class Single extends StatefulWidget {
  const Single({super.key});

  @override
  State<Single> createState() => _SingleState();
}

class _SingleState extends State<Single> {
  var rowww="";
  var membert="";
  List<dynamic> peoplist = [];
  bool _isLoading=true;

  bool isPermission = false;
  Dio dio =Dio();
  double prog =0.0;
  String downloading="0";

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
    showSub(context);
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
            Navigator.popUntil(context, (route) => route.isFirst);
            //Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        centerTitle: true,
        title: Text("Applicants", style: GoogleFonts.rubik()),
      ),
      body: _isLoading
          ? Center(
        child: CircularProgressIndicator(
          color: Colors.green[700],
        ),
      )
          : peoplist.isNotEmpty
          ? SingleChildScrollView(
        child: Column(
          children: peoplist
              .map((peopc) => peopleContainer(peopc, context))
              .toList(),
        ),
      )
          : Padding(
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
              "Nobody Applied",
              style: GoogleFonts.rubik(
                fontWeight: FontWeight.w500,
                color: Colors.grey,
                fontSize: 17,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }


  peopleapplied(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["jop_vacancy_id"]= app_id;
    map["user_id"]=user_id.toString();


    var res = await http.post(Uri.parse("$mainurl/employer_vacancy_user_count_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {
        rowww=jsondata["rows"].toString();
        setState(() {
          if(jsondata["rows"]!=null||jsondata["rows"]!=0) {
            setState(() {
              peoplist = jsondata["people_jop_applied_list"];
            });
          }else{
            peoplist=[];
          }
          _isLoading=false;
        });



      }else{
        setState(() {
          _isLoading=false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Nobody Applied"),
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

  Widget peopleContainer(dynamic peopc,BuildContext context) {
    Color textcolor;
    switch (peopc["status"]) {
      case "Pending":
        textcolor = Colors.amber;
        break;
      case "Interview":
        textcolor = Color(0xFF4e3b7b);
        break;
      case "Selected":
        textcolor = Color(0xFF8fae5e);
        break;
      case "Shortlisted":
        textcolor = Color(0xFF4b8f8c);
        break;
      case "Rejected":
        textcolor = Color(0xFFff786c);
        break;
      default:
        textcolor = Colors.black;
    }

    double ratingggg = peopc["rating"].toDouble();


    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        margin: EdgeInsets.only(bottom: 2.0),

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
          padding: const EdgeInsets.all(10.0),
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
                            height: 55,
                            width: 55,
                            fit: BoxFit.cover,
                          )),
                    ),
                  if (peopc["profile_img"] == "")
                    ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: Image(
                          image: AssetImage("assets/person.png"),
                          height: 55,
                          width: 55,
                          fit: BoxFit.cover,
                        )),
                  SizedBox(width: 5,),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(peopc["name"],style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 15),),
                          SizedBox(width: 10,),
                         if(ratingggg>0)
                           RatingBarIndicator(
                             rating: ratingggg,
                             itemBuilder: (context, index) => Icon(
                               Icons.star,
                               color: Colors.amber,
                             ),
                             itemCount: 5,
                             itemSize: 15,
                             direction: Axis.horizontal,
                           ),
                        ],
                      ),

                      Text("For:${peopc["open_position"]}",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 12),),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: textcolor
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5,right: 5),
                            child: Text("${peopc["status"]}",style: GoogleFonts.rubik(color: Colors.white,fontSize: 12,fontWeight: FontWeight.w500),),
                          )),
                    ],
                  ),
                  Spacer(flex: 2,),
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.pushNamed(context, "msgg");
                            setState(() {
                              lovee=peopc["user_apply_jop_id"];
                              ccnamee=peopc["name"];
                              ccemaile=peopc["confirm_email"];
                              cclogoe=peopc["profile_img"];
                            });
                            print("=======>>>");
                            print(lovee);
                            print(ccemaile);
                            print(ccnamee);
                            print(cclogoe);
                            print("=======>>>");

                          },
                          child: Container(
                            child: Stack(
                              children: [
                                Icon(Icons.outgoing_mail,),
                                if(peopc["total_messages"]!="0")
                                  Positioned(
                                    top: -5,
                                    right: -1,
                                    child: Container(
                                      padding: EdgeInsets.all(3),
                                      decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      constraints: BoxConstraints(
                                        minWidth: 16,
                                        minHeight: 16,
                                      ),
                                      child: Text(
                                        peopc["total_messages"],
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                       if(peopc["rating"]==0)
                         if(peopc["status"]=="Selected"||peopc["status"]=="Rejected")
                           GestureDetector(
                             onTap: (){
                               print("=======>>>");
                               print(lovee);
                               print(ccemaile);
                               print(ccnamee);
                               print(cclogoe);
                               setState(() {
                                 uuser=peopc["user_id"];
                               });
                               Navigator.pushNamed(context, "ratingss");

                               print("=======>>>");

                             },
                             child: Container(
                               margin: EdgeInsets.all(10),
                               child: Icon(Icons.star_border,color: Colors.yellow,),
                             ),
                           ),
                      ],
                    ),
                    // Container(
                    //   padding: EdgeInsets.all(3),
                    //   decoration: BoxDecoration(
                    //     color: Colors.green,
                    //     borderRadius: BorderRadius.circular(10),
                    //   ),
                    //   constraints: BoxConstraints(
                    //     minWidth: 16,
                    //     minHeight: 16,
                    //   ),
                    //   child: Text(
                    //     peopc["total_messages"],
                    //     style: TextStyle(
                    //       color: Colors.white,
                    //       fontSize: 10,
                    //     ),
                    //     textAlign: TextAlign.center,
                    //   ),
                    // ),

                ],
              ),
              Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width:MediaQuery.of(context).size.width * 0.32 ,
                        height: 35,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Color(0xFF118743),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
                          onPressed: () {
                            iid=peopc["user_apply_jop_id"];
                            seeresume(context);

                          },
                          child: Text(
                            "See Resume",
                            style: GoogleFonts.rubik(
                                color: Colors.white, fontSize: 15),
                          ),
                        )),
                  ),
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
                  ),
                  Padding(
                    padding: const EdgeInsets.all(5),
                    child: Container(
                        width:MediaQuery.of(context).size.width * 0.32 ,
                        height: 35,
                        child: TextButton(
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(color: Color(0xFF118743)),)),
                          onPressed: () {
                            if(showsub==true) {
                              if (membert != "") {
                                if (membert == "Paid") {
                                  setState(() {
                                    iid = peopc["user_apply_jop_id"];
                                    uuser = peopc["user_id"];
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
                                  Navigator.push(context, MaterialPageRoute(
                                      builder: (context) =>
                                          Subscription(
                                              callback: callback_mem)));
                                }
                              }
                            }else{
                              setState(() {
                                iid = peopc["user_apply_jop_id"];
                                uuser = peopc["user_id"];
                              });
                              viewdetails(context);
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
    print("i harleen here::::::::::::::::::::::::::::::::::::::::::::::::::::::  $map");
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


