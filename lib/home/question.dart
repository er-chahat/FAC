import 'dart:convert';

import 'package:fac/home/result.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class QuestionOptions extends StatefulWidget {
  var cate;
  QuestionOptions({required this.cate});

  @override
  State<QuestionOptions> createState() => _QuestionOptionsState();
}

class _QuestionOptionsState extends State<QuestionOptions> {
  var ques_data;
  var total =0;
  String a="ABCDE";
  bool loading=true;
  bool moveToResult =false;

  Future _questions() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/question_list.php");
      var prefs = await SharedPreferences.getInstance();
      //var ids=prefs.getInt(FirstScreenState.UNIQEId);
     // var session_id=ids != null?ids:2;
      Map mapdata = {
        "updte":1,
        "category_name": "${widget.cate}",
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
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
          setState(() {
            ques_data=data;
            loading=false;
          });
          return  data;
        }else{
          //MotionToast.error(description: Text(data["error_msg"]));
        }
      }else{
        setState(() {
          ques_data=[];
          loading=false;
        });
        // MotionToast.warning(
        //     title:  Text("${data["error_msg"]}"),
        //     description:  Text("try again later ")
        // ).show(context);

      }

    }catch(e){
      setState(() {
        ques_data=[];
        loading=false;
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
  Future _answer(var user_ids,var ans_id) async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/question_answers.php");
      var prefs = await SharedPreferences.getInstance();
      // var ids=prefs.getInt(FirstScreenState.UNIQEId);
      // var session_id=ids != null?ids:2;
      Map mapdata = {
        "updte":"1",
        "category_name":widget.cate,
        "user_id": user_id.toString(),
        "user_result_id":"$user_ids",
        "answer_id":"$ans_id",
        //"category_name":widget.heading
      };
      print(":::::::::::::::: ans ::: $mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII");
        if(data["error"]==0){
          if(data["test_finish"]!="No"){
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>ResultQuestion()));
          }else{
            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>QuestionOptions(cate: widget.cate)));
          }
          return  data;
        }else{
          //MotionToast.error(description: Text(data["error_msg"]));
        }
      }else{
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
  Future _total() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/test_details.php");
      var prefs = await SharedPreferences.getInstance();
      // var ids=prefs.getInt(FirstScreenState.UNIQEId);
      // var session_id=ids != null?ids:2;
      Map mapdata = {
        "updte":"1",
        "session":"$session_id",
        //"category_name":widget.heading
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
            total=int.parse(data["total_questions"]);
          });
          return data;

        }else{
         // MotionToast.error(description: Text(data["error_msg"]));
        }
      }else{
        setState(() {
          ques_data=[];
          loading=false;
        });
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
  var selected = -1;
  @override
  void initState() {
    // _total();
    _questions();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
        backgroundColor: Colors.green.shade600,
        body:SingleChildScrollView(
          child: ques_data==null?Center(
            child: CircularProgressIndicator(
              color: Colors.green,
            ),
          ):ques_data.length == 0 ?Center(child: Text("No Question Yet",style: TextStyle(color: Colors.black),)):Container(
            width: width,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.centerLeft,
                  colors: [
                    Colors.green.shade800,
                    Color(0xFFFCFCFC),
                  ],
                )
            ),
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  Stack(
                    children: [
                      Column(
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                  onTap: (){

                                    Navigator.pop(context);
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 50,
                          ),
                          Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      LinearPercentIndicator(
                                        padding: EdgeInsets.zero,
                                        width: width/1.3,
                                        animation: true,
                                        animationDuration: 1000,
                                        lineHeight: 8.0,
                                        percent: 0.3,

                                        linearStrokeCap: LinearStrokeCap.roundAll,
                                        barRadius: Radius.circular(10),
                                        progressColor: Colors.green.shade800,
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Text(widget.cate,style: TextStyle(decoration: TextDecoration.none,fontSize: 24,fontWeight: FontWeight.w600,color: Colors.black),),
                                  SizedBox(
                                    height: 14,
                                  ),
                                  Text("Question ${ques_data["current_question"]}",style: TextStyle(decoration: TextDecoration.none,fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                                  SizedBox(
                                    height: 0,
                                  ),
                                  //Text(widget.data["${widget.ques_no-1}"]["cat_question"],style: TextStyle(decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.w400,color: black),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: width,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Color(0xFFE0FAE8),
                                    ),
                                    child:Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child:Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(14.0),
                                            child: Text("${ques_data["question"]}",
                                              style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w700,fontSize: 24,color: Colors.black),textAlign: TextAlign.center,),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  for(var i=0;i<ques_data["total_answers"];i++)
                                    options(String.fromCharCode(a.codeUnitAt(i)), ques_data["answers"][i]["answer_val"], i,width),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // options("B", ques_data["answers"][2]["answer_val"], 1,width),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // options("C", widget.data["${widget.ques_no-1}"]["option_3"], 2,width),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // options("D", widget.data["${widget.ques_no-1}"]["option_4"], 3,width),
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  // options("E", "I don’t know", 4,width),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: InkWell(
                                      onTap: (){
                                        if(selected>-1) {
                                          _answer(ques_data["user_result_id"],
                                              ques_data["answers"][selected]["answer_id"]);
                                        }else{
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text("Please Select Answer!!"),
                                              duration: Duration(seconds: 2),
                                              shape:
                                              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
                                            ),
                                          );
                                        }
                                      },
                                      child: Container(
                                        width: width,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.green.shade800,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Center(child: Text("Next",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20.0,right: 20,bottom: 10),
                            child: Row(
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                Text("9mins remaining",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.white),),
                                Text("${ques_data["current_question"]} of ${ques_data["total_questions"]}",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.white),),
                              ],
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
  Widget options(var op_n ,var op ,var index,var width){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: (){
          setState(() {
            selected=index;
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: index==selected?Colors.green.shade800:Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: index==selected?Color(0xFFD5FAE4):
            Colors.white,
          ),
          child:Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(op_n,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                    SizedBox(
                      width: 16,
                    ),
                    Container(
                        width: width/1.6,
                        child: Text(op,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),textAlign: TextAlign.left,softWrap: true,maxLines: 2,))
                  ],
                ),
                index!=selected?Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1,color: Colors.black26),
                      shape: BoxShape.circle
                  ),
                ):Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.check_circle,size: 24,color: Colors.green.shade800,)),
              ],
            ),
          ),

        ),
      ),
    );
  }

}
