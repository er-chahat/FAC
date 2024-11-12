import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../starting/splashscreen.dart';

class PostChat extends StatefulWidget {
  var jobPostId;
  var profile;
  var name;
  var emp;
  var emp_id;
  var isEmployer;
  PostChat({required this.jobPostId,required this.name,required this.emp,required this.profile,required this.isEmployer,required this.emp_id});

  @override
  State<PostChat> createState() => _PostChatState();
}

class _PostChatState extends State<PostChat> {
  TextEditingController msgcontroller = TextEditingController();
  ScrollController _scrollController = ScrollController();
  ValueNotifier<String> msg = ValueNotifier(" ");
  ValueNotifier<List> AllMessages = ValueNotifier([]);
  String? vacancyMessage;
  var keyValue ;
  bool loading = false;
  Timer? timer;

  Future<void> GetMessage() async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"] = user_id;
    map["job_seeker_post_id"] = widget.jobPostId.toString();
    map["employer_id"] = widget.emp_id.toString();

    var res = await http.post(Uri.parse("$mainurl/job_post_messages.php"),
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
    try{
      setState(() {
        loading=true;
      });
      if(msgcontroller.text.isNotEmpty) {
        HashMap<String, String> map = HashMap();
        map["updte"] = "1";
        map["user_id"] = user_id;
        map["job_seeker_post_id"] = widget.jobPostId.toString();
        map["message"] = msgcontroller.text;
        map["employer_id"] = widget.emp_id.toString();

        var res = await http.post(
            Uri.parse("$mainurl/job_post_send_messages.php"),
            body: jsonEncode(map));
        msgcontroller.clear();

        print(res.body);
        dynamic jsondata = jsonDecode(res.body);
        print("Mapped::::::send mesag $map");
        print(jsondata);

        if (res.statusCode == 200) {
          print("send msg");
          setState(() {
            loading = false;
          });
          GetMessage();
        } else {
          setState(() {
            loading = false;
          });
          print('Error: ${res.statusCode}');
        }
      }else{
        setState(() {
          loading=false;
          msgcontroller.clear();
        });
      }
    }catch(e){
      setState(() {
        loading=false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    timer = Timer.periodic(Duration(seconds: 3), (timer) {
      GetMessage();
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future<void> messagesFuture = GetMessage();
    var size = MediaQuery.of(context).size;
    var height= size.height;
    var width = size.width;
    return Scaffold(
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
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                widget.profile == "" ?Container(
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
                                          image: NetworkImage("$photo/${widget.profile}"),
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
                                    Text(widget.name,style: TextStyle(fontWeight: FontWeight.w600),),
                                    if(widget.emp !=null)
                                    Text("Employment : ${widget.emp}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 12),),
                                  ],
                                ),

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
                                            widget.isEmployer==true ?Align(
                                              alignment: (vacancy["user_type"] == "Employer")
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
                                            ):Align(
                                              alignment: (vacancy["user_type"] != "Employer")
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
                                                  color: vacancy["user_type"] !=
                                                      "Employer"
                                                      ? Colors.green[200]
                                                      : Colors.white38,
                                                  borderRadius: vacancy[
                                                  "user_type"] !=
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
                      print("your loading is  $loading");
                      if(loading == false) {
                        await SendMessage();
                      }
                      print("your loading is  $loading");

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
    );
  }
}
