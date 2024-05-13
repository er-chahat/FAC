import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/welcome/choose.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/messages.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Message extends StatefulWidget {
  const Message({super.key});
  @override
  State<Message> createState() => _MessageState();
}

class _MessageState extends State<Message> {
  TextEditingController msgcontroller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ValueNotifier<List> AllMessages = ValueNotifier([]);
  // List<dynamic> AllMessages = [];

  List<dynamic> userlist = [];
  List<dynamic> emplist = [];
  String? vacancyMessage;
  var neeraj = "";
  var empst = "";
  var ohimg = "";


  Timer? timer;

  @override
  void initState() {
    super.initState();
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      GetMessage();
    });
    Fetchhere();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }
  Future<void> GetMessage() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["user_apply_jop_id"] = lovee.toString();
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
      map["user_apply_jop_id"] = lovee.toString();
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
      map["user_apply_jop_id"] = lovee.toString();
      map["message"] = msgcontroller.text;
      map["user_type"] = type;

      var res = await http.post(Uri.parse("$mainurl/send_messages.php"),
          body: jsonEncode(map));

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
    };

    Future<void> messagesFuture = GetMessage();
    Future<bool> _onWillPop() async {

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (BuildContext context) => Messages()));

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
              setState(() {

              });
            },
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.only(left: 15,right: 15,bottom: 15,top: 3),
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
                              if (cclogoe != "")
                                Container(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(50),
                                    child: Image(
                                      image: NetworkImage("$photo/$cclogoe"),
                                      height: 65,
                                      width: 65,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              if (cclogoe == "")
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
                                    ccnamee,
                                    style: GoogleFonts.rubik(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 15),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                    width: MediaQuery.of(context).size.width/2.5,
                                    child: Text(
                                      ccemaile,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 2,
                                      style: GoogleFonts.rubik(
                                          color: Colors.grey, fontSize: 13),
                                    ),
                                  ),
                                ],
                              ),
                              Spacer(flex: 2,),
                              GestureDetector(
                                onTap: (){
                                  setState(() {
                                    iid=lovee;
                                    iddname=ccnamee;
                                    iddem=ccemaile;

                                  });
                                  Navigator.pushNamed(context, "applicants");
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xFFEDF9F0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: IconButton(onPressed: (){
                                    setState(() {
                                      iid=lovee;
                                      iddname=ccnamee;
                                      iddem=ccemaile;

                                    });
                                    Navigator.pushNamed(context, "applicants");

                                  }, icon: Icon(Icons.mail,color: Colors.green,),),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
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
                            // Build your message list here
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
                                                    "Employer"
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
                                                        "Employer"
                                                        ? Colors.green[200]
                                                        : Colors.white38,
                                                    borderRadius: vacancy[
                                                    "user_type"] ==
                                                        "Employer"
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
                                          ],
                                        );
                                      });
                                });
                          } else if (snapshot.hasError) {
                            // Handle errors
                            return const Text("Error loading messages");
                          } else {
                            // Show a loading indicator
                            return const CircularProgressIndicator();
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 10, bottom: 5, top: 10),
                height: 65, // Increased height
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
                        msgcontroller.clear();
                      },
                      child: Icon(Icons.send, color: Colors.white, size: 18),
                      backgroundColor: Colors.green[700],
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
  map["employer_id"] = user_id;
  map["user_apply_jop_id"]=lovee.toString();

  var res = await http.post(
      Uri.parse("$mainurl/user_check_applicants_status.php"),
      body: jsonEncode(map));

  print(res.body);
  dynamic jsondata = jsonDecode(res.body);
  print("Mapped--->Now-->$map");
  print(jsondata);

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