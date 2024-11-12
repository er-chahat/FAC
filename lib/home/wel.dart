import 'dart:collection';
import 'dart:convert';
import 'dart:io';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fac/employeer/portfolio.dart';
import 'package:fac/home/Userbottom.dart';
import 'package:fac/home/add_post.dart';
import 'package:fac/home/drawres.dart';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/home/result.dart';
import 'package:fac/home/subb.dart';
import 'package:fac/welcome/about.dart';
import 'package:fac/welcome/education.dart';
import 'package:fac/welcome/keyskills.dart';
import 'package:fac/welcome/login.dart';
import 'package:fac/welcome/port.dart';
import 'package:fac/welcome/social.dart';
import 'package:file_picker/file_picker.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';

var pt = "";
var pd = "";

// var photo = "http://192.168.0.5/fac/img";
// var photos="http://192.168.0.5/fac/images/";
// var c_v="http://192.168.0.5/fac/cv";

class Wel extends StatefulWidget {
  const Wel({super.key});

  @override
  State<Wel> createState() => _WelState();
}

class _WelState extends State<Wel> {
  var ig;
  bool _isLoading = true;
  bool _dlLoading = false;
  bool _passLoading = false;
  bool _crtiLoading = false;
  var recent_data;
  bool isPermission = false;
  Dio dio =Dio();
  double prog =0.000;
  String downloading ="";
  var selectedDocs ="Select";
  List<String> _documents=["Select",
    "Visa",
    "Citizenship Certificate",
    "Birth Certificate",
    "Other"
  ];
  TextEditingController _document=TextEditingController();

  final GlobalKey<FormState> _key = GlobalKey();


  int selectedButtonIndex = 0;
  List<Map<String, dynamic>> userSkills = [];
  List<String> portfolioImages = [];
  List<dynamic> userPorti = [];
  Future _recentTest() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/user_test_detials.php");
      Map mapdata = {
        "updte":"1",
        "user_id": user_id.toString(),
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII${data["tests"]}");
        if(data["error"]==0){
          setState(() {
            recent_data=data["tests"];
            // percent = total/atmpt;
          });
          return  data;
        }else{
          setState(() {
            recent_data=[];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went Wrong"),
              duration: Duration(seconds: 2 ),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      }else{
        setState(() {
          recent_data=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went Wrong"),
            duration: Duration(seconds: 2 ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }

    }catch(e){
      setState(() {
        recent_data=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
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

  var degree = "";
  var iname = "";
  var course = "";
  var sp = "";
  var start = "";
  var end = "";
  var showOther=false;
  var postList;

  FilePickerResult? result;
  String? base64PDF;
  String? filePath;

  FilePickerResult? resultt;
  String? base64PDFF;
  String? filePathh;

  FilePickerResult? resulttt;
  String? base64PDFFF;
  String? filePathhh;

  var filepath1 = "";
  var filepath2 = "";
  var filepath3 = "";

  var dl = "";
  var doc = "";
  var pp = "";
  var bc = "";
  void startDownloading(var filename) async{
    String url ='http://110.173.135.111/fac/documents/$filename';
    // const String fileName="Doc8.docx";
    //print("file path ::: ::::::: ::::$fileName ");
    String path = await _getFilePaths(filename);
    print("file path ::: ::::::: ::::::::: $path");
    if(await File(path).exists()){
      print("helllo its working here you can use it now :: :   ::::::::::::::::::::::::$filename");
    }

    if(await File(path).exists()) {
      final result = Platform.isIOS?await OpenFile.open(path) :await OpenFile.open("/storage/emulated/0/Download/$filename");
      print("hello its file here exists :::::::::::::::::::::::::::$filename");
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
      show_dialoges(filename,path);
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
              print("helllo :::: : : : : : : : : : :$filename");
              show_dialoges(filename,path);
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

  void show_dialoges(var filename,var path)async{
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
  Future _postList() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/job_seeker_post_list.php");
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
  Future _deletePost(String delteId) async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/job_seeker_post_delete.php");
      Map mapdata = {
        "updte":1,
        "user_id": user_id.toString(),
        "job_seeker_post_id": delteId,
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
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("Post Deleted Successfully"),
                duration: Duration(seconds: 2 ),
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
              ),
          );
          setState(() {
            _postList();
          });
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

  @override
  void initState() {
    super.initState();
   // _recentTest();
    checkPermisson();
    _postList();
    fetchProfile();
    selectedButtonIndex = 0;
    educationinfo();
    setState(() {
      inside = true;
    });
  }


  void callback(var data){
    setState(() {
      pooo(context);
      fetchProfile();
    });
  }
  void callback1(var data){
    setState(() {
      fetchProfile();
    });
  }
  void callback2(var data){
    setState(() {
      educationinfo();
    });
  }
  void callbackPost(String s){
    setState(() {
      print("hello its post list is called");
      _postList();
    });
  }
  void callback_mem(var data){
    setState(() {
     membershipDetails(context);
    });
  }

  Future pickFile() async {
    print("I am HEREREEEEEEE");
    try {
      result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
    } catch (e) {
      print("ERROOORRRRRRRRRRRRRR==== $e");
    }

    if (result != null) {
      setState(() {
        _dlLoading=true;
      });
      PlatformFile file = result!.files.first;

      setState(() {
        filePath = file.name;
        filepath1 = file.path!;
      });

      print("File path: ${file.path}");
      print("File name: ${file.name}");
      print("File size: ${file.size}");

      List<int> pdfBytes = await File(file.path!).readAsBytes();
      base64PDF = base64Encode(pdfBytes);
      print("Base64 encoded PDF: $base64PDF");
      if(file.extension=="pdf"){
        upload_dl(context);
      }else{
        show_dialoge();
        setState(() {
          all_doc(context);
        });
      }
    }
  }
  void show_dialoge(){

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: Colors.white,
        content: SingleChildScrollView(
          child: Column(
            children: [
              Text("You can uplaod only pdf",style: TextStyle(
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
            },
            child: Container(
              color: Colors.green,
              padding: const EdgeInsets.all(14),
              child: const Text("ok"),
            ),
          ),
        ],
      ),
    );

  }

  Future pickFilee() async {
    print("I am HEREREEEEEEE");
    try {
      resultt = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
    } catch (e) {
      print("ERROOORRRRRRRRRRRRRR==== $e");
    }

    if (resultt != null) {
      setState(() {
        _passLoading=true;
      });
      PlatformFile file = resultt!.files.first;
      if(file.extension == "pdf") {
        setState(() {
          filePathh = file.name;
          filepath2 = file.path!;
        });

        print("File path: ${file.path}");
        print("File name: ${file.name}");
        print("File size: ${file.size}");

        List<int> pdfBytes = await File(file.path!).readAsBytes();
        base64PDFF = base64Encode(pdfBytes);
        print("Base64 encoded PDF: $base64PDFF");

        upload_pp(context);
      }else{
        show_dialoge();
        setState(() {
          all_doc(context);
        });
      }
    }
  }

  Future pickFileee() async {
    print("I am HEREREEEEEEE");
    try {
      resulttt = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf','jpg','webp','png','jpeg','HEIF'],
      );
    } catch (e) {
      print("ERROOORRRRRRRRRRRRRR==== $e");
    }

    if (resulttt != null) {
      setState(() {
        _crtiLoading = true;
      });
      PlatformFile file = resulttt!.files.first;

      setState(() {
        filePathhh = file.name;
        filepath3 = file.path!;
      });

      print("File path: ${file.path}");
      print("File name: ${file.name}");
      print("File size: ${file.size}");

      List<int> pdfBytes = await File(file.path!).readAsBytes();
      base64PDFFF = base64Encode(pdfBytes);
      print("Base64 encoded PDF: $base64PDFFF");
      if (file.extension == "pdf") {
        upload_Anydl(context, file.extension);
      } else {
        upload_Anydl(context,"other");
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: Color(0xFFfafafd),
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              //Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, "edit");
                },
                child: Text(
                  "Edit",
                  style: GoogleFonts.rubik(
                      color: Colors.grey,
                      fontWeight: FontWeight.w400,
                      fontSize: 17),
                ))
          ],
        ),
        body:  _isLoading
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
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          appl,
                          style: GoogleFonts.rubik(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Applied",
                          style: GoogleFonts.rubik(color: Colors.grey),
                        )
                      ],
                    ),
                    Spacer(
                      flex: 3,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          sele,
                          style: GoogleFonts.rubik(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Selected",
                          style: GoogleFonts.rubik(color: Colors.grey),
                        )
                      ],
                    ),
                    Spacer(flex: 3),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          inte,
                          style: GoogleFonts.rubik(
                              fontSize: 17, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          "Interview",
                          style: GoogleFonts.rubik(color: Colors.grey),
                        )
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    buildTextButton(0, "Personal Info"),
                    Spacer(
                      flex: 3,
                    ),
                    buildTextButton(1, "Documentation"),
                    Spacer(
                      flex: 3,
                    ),
                    buildTextButton(2, "Portfolio"),
                  ],
                ),
                IndexedStack(
                  index: selectedButtonIndex,
                  children: [
                    buildContainerForIndex(0,width,height),
                    buildContainerForIndex(1,width,height),
                    buildContainerForIndex(2,width,height),
                    buildContainerForIndex(3,width,height),
                  ],
                ),

              ],
            ),
          ),
        ),
        bottomNavigationBar: Userbottom(),
      ),
    );
  }

  TextButton buildTextButton(int index, String text) {
    return TextButton(
      onPressed: () {
        setState(() {
          selectedButtonIndex = index;
        });
        if (selectedButtonIndex == 1) {
         allDoc(context);
        } else if (selectedButtonIndex == 2) {
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
                          Container(
                            width: 50,
                            height: 30,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF118743),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                //Navigator.pushNamed(context, "keyskills");
                                setState(() {
                                  inside = false;
                                });
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Keyskills(callback: callback1)));
                            // if you want to apply sub for edit also  uncomment this code for all
                                // if (membertype == "Paid") {
                                //   //Navigator.pushNamed(context, "keyskills");
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Keyskills(callback: callback1)));
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(
                                //           "Buy Subscription to add more!!"),
                                //       duration: Duration(seconds: 2),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(40)),
                                //     ),
                                //   );
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                                //   //Navigator.pushNamed(context, "usersubs");
                                // }
                                print("ok");
                              },
                              child: Text(
                                "+Add",
                                style: GoogleFonts.rubik(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
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
                          Container(
                            width: 50,
                            height: 30,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF118743),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                // Navigator.pushNamed(context, "education");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Education(callback: callback2)));
                                // if (membertype == "Paid") {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Education(callback: callback2)));
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(
                                //           "Buy Subscription to add more!!"),
                                //       duration: Duration(seconds: 2),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(40)),
                                //     ),
                                //   );
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                                // }
                                print("ok");
                              },
                              child: Text(
                                "+Edit",
                                style: GoogleFonts.rubik(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
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
                          Container(
                            width: 50,
                            height: 30,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF118743),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                // Navigator.pushNamed(context, "about");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>About(callback: callback1,)));

                                // if (membertype == "Paid") {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>About(callback: callback1,)));
                                //   // Navigator.pushNamed(context, "about");
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(
                                //           "Buy Subscription to add more!!"),
                                //       duration: Duration(seconds: 2),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(40)),
                                //     ),
                                //   );
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                                // }
                                print("ok");
                              },
                              child: Text(
                                "+Edit",
                                style: GoogleFonts.rubik(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
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
                          Container(
                            width: 50,
                            height: 30,
                            child: TextButton(
                              style: TextButton.styleFrom(
                                  backgroundColor: Color(0xFF118743),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10))),
                              onPressed: () async {
                                // Navigator.pushNamed(context, "social");
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>Social(callback: callback1)));
                                // if (membertype == "Paid") {
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Social(callback: callback1)));
                                //   //Navigator.pushNamed(context, "social");
                                // } else {
                                //   ScaffoldMessenger.of(context).showSnackBar(
                                //     SnackBar(
                                //       content: Text(
                                //           "Buy Subscription to add more!!"),
                                //       duration: Duration(seconds: 2),
                                //       shape: RoundedRectangleBorder(
                                //           borderRadius:
                                //               BorderRadius.circular(40)),
                                //     ),
                                //   );
                                //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                                // }
                                print("ok");
                              },
                              child: Text(
                                "+Edit",
                                style: GoogleFonts.rubik(
                                    color: Colors.white, fontSize: 10),
                              ),
                            ),
                          ),
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
              // SizedBox(height: 15),
              // Container(
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     borderRadius: BorderRadius.circular(20),
              //     boxShadow: [
              //       BoxShadow(
              //         color: Colors.grey.withOpacity(0.2),
              //         spreadRadius: 2,
              //         blurRadius: 2,
              //       ),
              //     ],
              //     color: Colors.white,
              //   ),
              //   child: Padding(
              //     padding: const EdgeInsets.all(20.0),
              //     child: Column(
              //       crossAxisAlignment: CrossAxisAlignment.start,
              //       children: [
              //         Text("Test Taken",
              //             style: GoogleFonts.rubik(
              //                 fontWeight: FontWeight.w500)),
              //         SizedBox(height: 15),
              //         if(recent_data == null)
              //           CircularProgressIndicator(color: Colors.green,),
              //         if(recent_data != null && recent_data.length==0)
              //           Center(child: Text("No Record found!")),
              //         if(recent_data !=null && recent_data.length >0)
              //           for(int i =0;i<recent_data.length;i++)
              //             InkWell(
              //               onTap: (){
              //                 if(recent_data[i]["completed_percentage"] == 100) {
              //                   Navigator.push(context, MaterialPageRoute(
              //                       builder: (context) =>
              //                           ResultQuestion(cate: recent_data[i]["category_name"], callback: callback)));
              //                 }
              //               },
              //               child: Container(
              //                 decoration: BoxDecoration(
              //                   borderRadius: BorderRadius.circular(10),
              //                   color: Color(0xFFF8F7F9),
              //                 ),
              //                 child: Padding(
              //                   padding: const EdgeInsets.all(8.0),
              //                   child: Column(
              //                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                     crossAxisAlignment: CrossAxisAlignment.start,
              //                     children: [
              //                       Row(
              //                         mainAxisAlignment: MainAxisAlignment.center,
              //                         children: [
              //                           // Container(
              //                           //   height: 87,
              //                           //   width: 93,
              //                           //   child: SvgPicture.asset(
              //                           //       gen_iq
              //                           //   ),
              //                           // ),
              //                         ],
              //                       ),
              //                       Column(
              //                         crossAxisAlignment: CrossAxisAlignment.start,
              //                         children: [
              //                           Container(
              //                               width: width/2.4,
              //                               child: Text("${recent_data[i]["category_name"]}",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),softWrap: true,overflow: TextOverflow.ellipsis,)),
              //                           SizedBox(
              //                             height: 4,
              //                           ),
              //                           Row(
              //                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //                             children: [
              //                               Text("Completed",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),),
              //                               Text("${recent_data[i]["completed_percentage"]} %",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.green),),
              //                             ],
              //                           ),
              //                           SizedBox(
              //                             height: 4,
              //                           ),
              //                           LinearPercentIndicator(
              //                             padding: EdgeInsets.zero,
              //                             animation: true,
              //                             animationDuration: 1000,
              //                             lineHeight: 6.0,
              //                             percent: recent_data[i]["completed_percentage"]/100,
              //
              //                             linearStrokeCap: LinearStrokeCap.roundAll,
              //                             barRadius: Radius.circular(10),
              //                             progressColor: Colors.green,
              //                           ),
              //                         ],
              //                       )
              //                     ],
              //                   ),
              //                 ),
              //               ),
              //             ),
              //       ],
              //     ),
              //   ),
              // ),
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
                child: postList == null ? Center(child: CircularProgressIndicator(color: Colors.green,)):Container(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Posts",
                              style: GoogleFonts.rubik(fontSize: 20),
                            ),
                            Container(
                              width: 50,
                              height: 30,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    backgroundColor: Color(0xFF118743),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10))),
                                onPressed: () async {
                                  // Navigator.pushNamed(context, "port");
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>AddPost(callback: callbackPost,)));

                                  // if (membertype == "Paid") {
                                  //  // Navigator.pushNamed(context, "port");
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Port(callback: callback,isEdit:false)));
                                  // } else {
                                  //   ScaffoldMessenger.of(context).showSnackBar(
                                  //     SnackBar(
                                  //       content: Text("Buy Subscription to add more!!"),
                                  //       duration: Duration(seconds: 2),
                                  //       shape: RoundedRectangleBorder(
                                  //           borderRadius: BorderRadius.circular(40)),
                                  //     ),
                                  //   );
                                  //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem )));
                                  // }
                                },
                                child: Text(
                                  "+Add",
                                  style: GoogleFonts.rubik(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        if(postList.length == 0)
                          Text("No Post Available"),
                        if(postList != null && postList.length !=0)
                          for(int i=0; i<postList["rows"];i++)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 20),
                              child: Posts(width,height,postList["deta"][i]),
                            )
                        // if (portfolioImages.isNotEmpty)
                        // GridView.builder(
                        //   shrinkWrap: true,
                        //   physics: NeverScrollableScrollPhysics(),
                        //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        //     crossAxisCount: 3,
                        //     crossAxisSpacing: 8.0,
                        //     mainAxisSpacing: 8.0,
                        //   ),
                        //   itemCount: portfolioImages.length,
                        //   itemBuilder: (context, index) {
                        //     var imageUrl = portfolioImages[index];
                        //     var title = userPorti[index]["portfolio_title"];
                        //     var descrip = userPorti[index]["portfolio_description"];
                        //     return buildImageContainer(imageUrl, title, descrip,"${userPorti[index]["portfolio_id"]}",index);
                        //   },
                        // ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
            ],
          ),
        );
      case 1:
        return docList==null?Center(child: CircularProgressIndicator(color: Colors.green,)):docList["rows"]==0?Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Center(child: Text("No any Document",)),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    onPressed: () async {
                      setState(() {
                        showOther=!showOther;
                      });
                      //await pickFile();
                      // if (membertype == "Paid") {
                      //   await pickFile();
                      // } else {
                      //   ScaffoldMessenger.of(context).showSnackBar(
                      //     SnackBar(
                      //       content: Text(
                      //           "Buy Subscription to add more!!"),
                      //       duration: Duration(seconds: 2),
                      //       shape: RoundedRectangleBorder(
                      //           borderRadius:
                      //               BorderRadius.circular(40)),
                      //     ),
                      //   );
                      //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                      // }
                      print("ok");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "+Add Document",
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontSize: 10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if(showOther==true)
              Form(
                key: _key,
                child: Column(
                  children: [
                    SizedBox(height: 15),
                    DropdownButtonFormField(
                      // isDense: true,
                      validator: (String? value){
                        if(value == null || value.isEmpty || value == "Select"){
                          return "Please select value";
                        }
                        return null;
                      },

                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(width: 0.5, color: Colors.black),
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        hintText: "Type here...",
                        hintStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54,fontSize: 12),
                        helperStyle: TextStyle(fontSize: 18),
                        isDense: false,
                        contentPadding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 16),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.5, color: Colors.black),
                        ),
                        disabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.5, color: Colors.black),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(width: 0.5, color: Colors.black),
                        ),
                        // fillColor: Color(0xFFF6F6F6),
                        // filled: true,
                      ),

                      value: selectedDocs,
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedDocs = newValue!;
                        });
                      },
                      items: _documents.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(
                            value,
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),
                          ),
                        );
                      }).toList(),
                    ),
                    if(selectedDocs=="Other")
                      SizedBox(height: 10),
                    if(selectedDocs=="Other")
                      TextFormField(
                        controller: _document,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return "Please enter value";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Document Name",
                          hintStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54,fontSize: 12),
                          helperStyle: TextStyle(fontSize: 18),
                          isDense: false,
                          contentPadding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 16),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          // fillColor: Color(0xFFF6F6F6),
                          // filled: true,
                        ),
                      ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: ()async{
                        if(_key.currentState!.validate()){
                          await pickFileee();
                        }

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          border: Border.all(width: 0.5,color: Colors.black),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Select Document",
                              style: GoogleFonts.rubik(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     // if(_key.currentState!.validate()) {
                    //     //   upload_Anydl(context);
                    //     // }
                    //   },
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xFF118743),
                    //       border: Border.all(width: 0.5,color: Colors.black),
                    //       borderRadius: BorderRadius.circular(14),
                    //     ),
                    //     child: Center(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(14.0),
                    //         child: Text(
                    //           "Upload Document",
                    //           style: GoogleFonts.rubik(
                    //               color: Colors.white, fontSize: 14),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),
          ],
        ):Container(
          child: Column(
            children: [
              for(int i=0;i<docList["rows"];i++)
              Padding(
                padding: const EdgeInsets.only(bottom: 14.0),
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
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("${docList["data"][i]["document_type"]}",
                                style: GoogleFonts.rubik(
                                    fontWeight: FontWeight.w500)),
                          ],
                        ),
                        Stack(
                          children: [
                            GestureDetector(
                              onTap: (){
                                setState(() {
                                  go=pp;
                                  print(pp);
                                });
                                // Navigator.pushNamed(context, "ohhhere");
                                if(isPermission) {
                                  startDownloading("${docList["data"][i]["document"]}");
                                }else{
                                  checkPermisson();
                                }
                              },
                              child: Padding(
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
                                    color: Colors.white54,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20),
                                    child: Row(
                                      children: [
                                        Image(image: AssetImage("assets/pdf.png")),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          children: [
                                            Container(
                                              width: MediaQuery.of(context).size.width/2.2,
                                                child: Text("${docList["data"][i]["document_type"]}.pdf")),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                                right: 3,
                                top: 4,
                                child: InkWell(
                                    onTap: (){
                                      deleteDoc(context,"${docList["data"][i]["document_id"]}" );
                                    },
                                    child: Container(
                                        decoration: BoxDecoration(
                                          color: Colors.black38,
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: Icon(Icons.cancel,color: Colors.white,size: 18,),
                                        ))))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 15),
              if(docList["rows"]<8)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async {
                        setState(() {
                          showOther=!showOther;
                        });
                        //await pickFile();
                        // if (membertype == "Paid") {
                        //   await pickFile();
                        // } else {
                        //   ScaffoldMessenger.of(context).showSnackBar(
                        //     SnackBar(
                        //       content: Text(
                        //           "Buy Subscription to add more!!"),
                        //       duration: Duration(seconds: 2),
                        //       shape: RoundedRectangleBorder(
                        //           borderRadius:
                        //               BorderRadius.circular(40)),
                        //     ),
                        //   );
                        //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem)));
                        // }
                        print("ok");
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "+Add Document",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              if(docList["rows"]<8)
                if(showOther==true)
                  Form(
                key: _key,
                child: Column(
                  children: [
                      SizedBox(height: 15),
                      DropdownButtonFormField(
                        // isDense: true,
                        validator: (String? value){
                          if(value == null || value.isEmpty || value == "Select"){
                            return "Please select value";
                          }
                          return null;
                        },

                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Type here...",
                          hintStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54,fontSize: 12),
                          helperStyle: TextStyle(fontSize: 18),
                          isDense: false,
                          contentPadding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 16),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          // fillColor: Color(0xFFF6F6F6),
                          // filled: true,
                        ),

                        value: selectedDocs,
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedDocs = newValue!;
                          });
                        },
                        items: _documents.map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 14,fontWeight: FontWeight.w500,color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    if(selectedDocs=="Other")
                      SizedBox(height: 10),
                    if(selectedDocs=="Other")
                      TextFormField(
                        controller: _document,
                        keyboardType: TextInputType.emailAddress,
                        validator: (String? value){
                          if(value == null || value.isEmpty){
                            return "Please enter value";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          hintText: "Document Name",
                          hintStyle: TextStyle(fontWeight: FontWeight.normal,color: Colors.black54,fontSize: 12),
                          helperStyle: TextStyle(fontSize: 18),
                          isDense: false,
                          contentPadding: EdgeInsets.only(left: 18,right: 18,top: 10,bottom: 16),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide(width: 0.5, color: Colors.black),
                          ),
                          // fillColor: Color(0xFFF6F6F6),
                          // filled: true,
                        ),
                      ),
                    SizedBox(height: 10),
                    InkWell(
                      onTap: ()async{
                        if(_key.currentState!.validate()){
                          await pickFileee();
                        }

                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          border: Border.all(width: 0.5,color: Colors.black),
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.all(14.0),
                            child: Text(
                              "Select Document",
                              style: GoogleFonts.rubik(
                                  color: Colors.black, fontSize: 14),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    // InkWell(
                    //   onTap: (){
                    //     // if(_key.currentState!.validate()) {
                    //     //   upload_Anydl(context);
                    //     // }
                    //   },
                    //   child: Container(
                    //     width: MediaQuery.of(context).size.width,
                    //     decoration: BoxDecoration(
                    //       color: Color(0xFF118743),
                    //       border: Border.all(width: 0.5,color: Colors.black),
                    //       borderRadius: BorderRadius.circular(14),
                    //     ),
                    //     child: Center(
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(14.0),
                    //         child: Text(
                    //           "Upload Document",
                    //           style: GoogleFonts.rubik(
                    //               color: Colors.white, fontSize: 14),
                    //         ),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
              ),


            ],
          ),
        );
      case 2:
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
                    Container(
                      width: 70,
                      height: 30,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF118743),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () async {
                          // Navigator.pushNamed(context, "port");
                          Navigator.push(context, MaterialPageRoute(builder: (context)=>Port(callback: callback,isEdit:false)));

                          // if (membertype == "Paid") {
                          //  // Navigator.pushNamed(context, "port");
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Port(callback: callback,isEdit:false)));
                          // } else {
                          //   ScaffoldMessenger.of(context).showSnackBar(
                          //     SnackBar(
                          //       content: Text("Buy Subscription to add more!!"),
                          //       duration: Duration(seconds: 2),
                          //       shape: RoundedRectangleBorder(
                          //           borderRadius: BorderRadius.circular(40)),
                          //     ),
                          //   );
                          //   Navigator.push(context, MaterialPageRoute(builder: (context)=>Subb(callback:callback_mem )));
                          // }
                        },
                        child: Text(
                          "+Add",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 10),
                        ),
                      ),
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
  Widget Posts(var width,var height,var key){
    return Stack(
      children: [
        Container(
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
                    // IconButton(
                    //   onPressed: () {
                    //     Navigator.pushNamed(context, "applicants");
                    //     // iid = peoplist["user_apply_jop_id"];
                    //     // iddname = peoplist["name"];
                    //     // iddem = peoplist["confirm_email"];
                    //   },
                    //   icon: Icon(
                    //     Icons.mail,
                    //     color: Colors.green,
                    //   ),
                    // ),
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
        ),
        Positioned(
          top: 1,
            right: 4,
            child: InkWell(
          onTap: (){
            _deletePost(key["job_seeker_post_id"]);
          },
            child: Icon(Icons.clear ,color: Colors.red)))
      ],
    );
  }

  Widget buildImageContainer(String imageUrl, String title, String descrip,var p_id,var i) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(2.0),
          child: GestureDetector(
            onTap: () {
              setState(() {
                pt = title;
                pd = descrip;
              });
              //Navigator.pushNamed(context, "portfolio");
              Navigator.push(context, MaterialPageRoute(builder: (context)=>Portfolio(por_data: userPorti[i],callback:callback)));
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
        Positioned(
          right: 0,
            top: 0,
            child: InkWell(
              onTap: (){
                deletePort(context, p_id);
              },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Icon(Icons.cancel,color: Colors.white,size: 18,),
                    ))))
      ],
    );
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
  Future<void> pooo(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

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
  Future<void> deletePort(BuildContext context,var port_id) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["portfolio_id"] = port_id;

    var res = await http.post(Uri.parse("$mainurl/portfolio_delete.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print("your portfolio delete data $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          pooo(context);
        });
      } else {}
    } else {
      print('error');
    }
  }
  Future<void> deleteDoc(BuildContext context,var doc_id) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["document_id"] = doc_id;

    var res = await http.post(Uri.parse("$mainurl/document_delete.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print("your portfolio delete data $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          allDoc(context);
        });
      } else {

      }
    } else {
      print('error');
    }
  }

  Future fetchProfile() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id.toString(),
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
        if(jsondata['user_skills'] == null){
          userSkills.clear();
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

  Future educationinfo() async {
    Map<String, String> map = {
      "updte": "1",
      "user_id": user_id.toString(),
    };

      final response = await http.post(
        Uri.parse('$mainurl/user_education_list.php'),
        body: jsonEncode(map),
      );
      print(map);
      dynamic jsondata = jsonDecode(response.body);
      print(jsondata);
      if (response.statusCode == 200) {
        setState(() {
          degree = jsondata["degree"];
          iname = jsondata["university_Institute_name"];
          course = jsondata["course"];
          sp = jsondata["specialization"];
          start = jsondata["starting_year"].toString();
          end = jsondata["ending_year"].toString();
        });
      } else {
        throw Exception("Failed to load profile data");
      }
  }

  upload_dl(context) async {
    print("hi::::::::::::::::::::::::::::::::::::::::::::::::::::::");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["driver_license"] = base64PDF ?? "";
    print("helllllllllllllllllllllllllllllll:::::::::::::::::::$map");

    var res = await http.post(Uri.parse("$mainurl/driver_license_uplode.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ::::::::::::::::::::::::: ::::::::::::::: : $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          all_doc(context);
        });
        //Navigator.pushNamed(context, "wel");
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
    } else {
      print('error');
    }
  }
  upload_Anydl(context,var type) async {
    print("hi::::::::::::::::::::::::::::::::::::::::::::::::::::::");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["file_type"] = type;
    map["document_type"] = selectedDocs=="Other"?_document.text:selectedDocs;
    map["document"] = base64PDFFF ?? "";
    print("helllllllllllllllllllllllllllllll:::::::::::::::::::$map");

    var res = await http.post(Uri.parse("$mainurl/certificate_uplode.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ::::::::::::::::::::::::: ::::::::::::::: : $map");
    print(jsondata);
    print("hello its your result  $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        print("hello its your result  $jsondata");
        setState(() {
          showOther=false;
          allDoc(context);
          _key.currentState!.reset();
          selectedDocs="Select";
          _document.clear();

          //all_doc(context);
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Document uploaded Successfully"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
        //Navigator.pushNamed(context, "wel");
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
    } else {
      print('error');
    }
  }
  allDoc(context) async {
    print("hi::::::::::::::::::::::::::::::::::::::::::::::::::::::");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    print("helllllllllllllllllllllllllllllll:::::::::::::::::::$map");

    var res = await http.post(Uri.parse("$mainurl/documentation_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh ::::::::::::::::::::::::: ::::::::::::::: : $map");
    print(jsondata);
    print("hello its your result of all Doc $jsondata");
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        print("hello its your result  $jsondata");
        setState(() {
          docList=jsondata;
          //all_doc(context);
        });
        //Navigator.pushNamed(context, "wel");
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
    } else {
      print('error');
    }
  }

  upload_pp(context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["passport"] = base64PDFF ?? "";

    var res = await http.post(Uri.parse("$mainurl/passport_uplode.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
       setState(() {
         all_doc(context);
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
    } else {
      print('error');
    }
  }

  upload_bc(context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["birth_certificate"] = base64PDFFF ?? "";

    var res = await http.post(
        Uri.parse("$mainurl/birth_certificate_uplode.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          all_doc(context);
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
    } else {
      print('error');
    }
  }

  Future<void> all_doc(BuildContext context) async {
    print("hi");
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;

    var res = await http.post(Uri.parse("$mainurl/documentation_list.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("i am here hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh $map");
    print(jsondata);
    var er = jsondata["error"];
    if (res.statusCode == 200) {
      if (er == 0) {
        setState(() {
          _dlLoading=false;
          _passLoading=false;
          _crtiLoading=false;
          bc = jsondata["birth_certificate"].toString();
          pp = jsondata["passport"].toString();
          dl = jsondata["driver_license"].toString();
          doc=jsondata["document_id"].toString();
        });
        print("dl: $dl");
        print("pp: $pp");
        print("bc: $bc");
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
    } else {
      print('error');
    }
  }
}
