import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/wel.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/fetchdata.dart';
import 'package:http/http.dart' as http;
import 'package:fac/home/mainprofile.dart';
import 'package:fac/home/usermsg.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class Usermain extends StatefulWidget {
  const Usermain({super.key});

  @override
  State<Usermain> createState() => _UsermainState();
}

class _UsermainState extends State<Usermain> {

  TextEditingController msgcontroller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ValueNotifier<List> AllMessages = ValueNotifier([]);

  var whatsup="";

  List<dynamic> userlist = [];
  List<dynamic> emplist = [];
  String? vacancyMessage;
  var neeraj = "";
  var empst = "";
  var ohimg = "";

  final urlRegExp = RegExp(
    r'(?:(https?:\/\/)?(meet\.google\.com\/[\w\-]+))',
    caseSensitive: false,
  );

  // Function to launch the URL
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to extract the first URL from the message
  String? extractFirstUrl(String message) {


    final matches = urlRegExp.allMatches(message);
    if (matches.isNotEmpty) {
      final url = matches.first.group(0);
      if (url != null && !url.startsWith('http')) {
        return 'https://' + url;
      }
      return url;
    }
    return null;
  }


  Timer? timers;
  Timer? timerss;

  @override
  void initState() {
    super.initState();
    timers = Timer.periodic(Duration(seconds: 3), (timer) {
      GetMessage();
    });

    Fetchhere();
    timerss = Timer.periodic(Duration(seconds: 2), (timer) {
      _scrollToBottom();
    });

  }

  @override
  void deactivate() {
    timers?.cancel();
    timerss?.cancel();
    super.deactivate();
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  Future<void> GetMessage() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["user_apply_jop_id"] = love.toString();
    map["user_type"] = type;

    var res = await http.post(Uri.parse("$mainurl/messages.php"),
        body: jsonEncode(map));

    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      print("**");
      print(jsondata);
      print("**");
      AllMessages.value = jsondata['user_applied_jop'];

      print(AllMessages);
    } else {
      print('Error: ${res.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    ValueNotifier<String> msg = ValueNotifier(" ");

    Future<void> GetMessage() async {
      HashMap<String, String> map = HashMap();
      map["updte"] = "1";
      map["user_id"] = user_id;
      map["user_apply_jop_id"] = love.toString();
      map["user_type"] = type;

      var res = await http.post(Uri.parse("$mainurl/messages.php"),
          body: jsonEncode(map));

      print(res.body);
      dynamic jsondata = jsonDecode(res.body);
      print("Mapped::::::$map");
      print(jsondata);

      if (res.statusCode == 200) {
        print("**");
        print(jsondata);
        print("**");
        AllMessages.value = jsondata['user_applied_jop'];

        print(AllMessages);
      } else {
        print('Error: ${res.statusCode}');
      }
    }

    Future SendMessage() async {
      HashMap<String, String> map = HashMap();
      map["updte"] = "1";
      map["user_id"] = user_id;
      map["user_apply_jop_id"] = love.toString();
      map["message"] = msgcontroller.text;
      map["user_type"] = type;

      var res = await http.post(Uri.parse("$mainurl/send_messages.php"),
          body: jsonEncode(map));
      print("Mapped::::::$map");

      print(res.body);
      dynamic jsondata = jsonDecode(res.body);
      print("Mapped::::::$map");
      print(jsondata);

      if (res.statusCode == 200) {
        print("send msg");

        GetMessage();
      } else {
        print('Error: ${res.statusCode}');
      }
    }

    Future<void> messagesFuture = GetMessage();
    Future<bool> _onWillPop() async {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Usermsg()));

      return false;
    }

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            "Message",
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
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              if(neeraj!="")
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    for (var vacancy in emplist)
                    Container(
                        margin: EdgeInsets.only(bottom: 10),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.2),
                              spreadRadius: 2,
                              blurRadius: 2,
                            ),
                          ],
                          color: Colors.white38,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                            bottomLeft: Radius.circular(20.0),
                            bottomRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("${vacancy["status"]}",style: GoogleFonts.rubik(fontWeight: FontWeight.w500),),
                                  Spacer(flex: 2,),
                                  if(vacancy["status"]=="Interview")
                                    Text("${vacancy["schedule_date"]}, ${vacancy["schedule_time"]}",style: GoogleFonts.rubik(fontSize: 13)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                  ],
                ),
              Expanded(
                child: SingleChildScrollView(
                  controller: _scrollController,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                            children: [
                              if (cclogo != "")
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: NetworkImage("$photo/$cclogo"),
                                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                                        return Container(
                                          height: 55,
                                          width: 55,
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
                                      height: 65,
                                      width: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              if (cclogo == "")
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: AssetImage("assets/pers.png"),
                                      height: 65,
                                      width: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ccname,
                                    style: GoogleFonts.rubik(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    ccemail,
                                    style: GoogleFonts.rubik(
                                        color: Colors.grey, fontSize: 13),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      FutureBuilder<void>(
                        future: messagesFuture,
                        builder: (context, snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.connectionState ==
                              ConnectionState.done) {
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
                            });
                            return ValueListenableBuilder(
                                valueListenable: msg,
                                builder: (context, value, child) {
                                  return ValueListenableBuilder(
                                      valueListenable: AllMessages,
                                      builder: (context, value, child) {
                                        return Column(
                                          children: [
                                            for (var vacancy in AllMessages.value)
                                              Align(
                                                alignment: vacancy["user_type"] ==
                                                    "User"
                                                    ? Alignment.centerRight
                                                    : Alignment.centerLeft,
                                                child: Container(
                                                  margin: const EdgeInsets.only(
                                                      bottom: 10),
                                                  decoration: BoxDecoration(
                                                    boxShadow: [
                                                      BoxShadow(
                                                        color: Colors.grey
                                                            .withOpacity(0.2),
                                                        spreadRadius: 2,
                                                        blurRadius: 2,
                                                      ),
                                                    ],
                                                    color: vacancy["user_type"] ==
                                                        "User"
                                                        ? Color(0xFF118743)
                                                        : Colors.white38,
                                                    borderRadius: vacancy[
                                                    "user_type"] ==
                                                        "User"
                                                        ? const BorderRadius.only(
                                                      topLeft:
                                                      Radius.circular(
                                                          20.0),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          20.0),
                                                      bottomRight:
                                                      Radius.circular(
                                                          20.0),
                                                    )
                                                        : const BorderRadius.only(
                                                      topRight:
                                                      Radius.circular(
                                                          20.0),
                                                      bottomLeft:
                                                      Radius.circular(
                                                          20.0),
                                                      bottomRight:
                                                      Radius.circular(
                                                          20.0),
                                                    ),
                                                  ),
                                                  child: InkWell(
                                                    onTap: (){
                                                      String? url = extractFirstUrl(vacancy["message"]);
                                                      if (url != null) {
                                                        _launchURL(url);
                                                      }
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(
                                                          20.0),
                                                      child: Column(
                                                        crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                        children: [
                                                          Text(
                                                            vacancy["message"],
                                                            style:
                                                            GoogleFonts.rubik(
                                                                fontSize: 17),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                          ],
                                        );
                                      });
                                });
                          } else if (snapshot.hasError) {
                            // Handle errors
                            return const Text("Error loading messages");
                          } else {

                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              if(whatsup!="Rejected")
                Container(
                  padding: EdgeInsets.only(left: 10, bottom: 5, top: 10),
                  height: 65,
                  width: double.infinity,
                  color: Colors.white,
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextFormField(
                          maxLines: 100,
                          controller: msgcontroller,
                          cursorColor: Color(0xFF118743),
                          onChanged: (text) {
                            msg.value = text;
                          },
                          style: GoogleFonts.rubik(),
                          decoration: InputDecoration(
                            hintText: "Write message...",
                            hintStyle: GoogleFonts.rubik(color: Colors.black54),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      const SizedBox(width: 15),
                      FloatingActionButton(
                        onPressed: () async {
                          await SendMessage();
                         setState(() {
                           print("ASDASDAD");
                           msgcontroller.clear();
                           msgcontroller.value='' as TextEditingValue;
                         });
                        },
                        child: Icon(Icons.send, color: Colors.white, size: 18),
                        backgroundColor: Color(0xFF118743),
                        elevation: 0,
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
Fetchhere() async {
  HashMap<String, String> map = HashMap();
  map["updte"] = "1";
  map["user_id"] = user_id.toString();
  map["user_apply_jop_id"]=love.toString();

  var res = await http.post(
      Uri.parse("$mainurl/user_check_applicants_status.php"),
      body: jsonEncode(map));
print("+++");
  print(res.body);
  print("+++");

  dynamic jsondata = jsonDecode(res.body);
  print("+++");
  print("&&&");

  print("Mapped::::::$map");
  print("&&&");
  print("+++");

  print(jsondata);
  print("&&&");


  if (res.statusCode == 200) {
    if (jsondata["error"] == 0) {

      if (jsondata["user_rows"] != null) {
        setState(() {
          userlist = jsondata["user_detial"];
        });
      }

      if (jsondata["rows"] != null) {
        setState(() {
          emplist = jsondata["jop_vacancy"];
          neeraj=jsondata["rows"].toString();
          whatsup=emplist[0]["status"];
        });
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Error occurred while fetching data."),
          duration: Duration(seconds: 2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(40)),
        ),
      );
    }
  } else {
    print('Error: ${res.statusCode}');
  }
}

}
