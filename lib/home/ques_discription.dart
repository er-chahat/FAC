import 'dart:convert';

import 'package:fac/home/question.dart';
import 'package:fac/home/result.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../starting/splashscreen.dart';

class QuestionsDescription extends StatefulWidget {
  var cate;
  final Function(String) callback;
  QuestionsDescription({required this.cate,required this.callback});

  @override
  State<QuestionsDescription> createState() => _QuestionsDescriptionState();
}

class _QuestionsDescriptionState extends State<QuestionsDescription> {
  var data_ques;
  var id ;
  var result;
  bool toResult = false;

  Future _getresult() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/question_result.php");

      Map mapdata = {
        "updte":"1",
        "user_id": user_id.toString(),
        "category_name":widget.cate["category_name"],
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII $data");
        if(data["error"]==0){
          setState(() {
            result=data;
            toResult=true;
            // percent = total/atmpt;
          });
          return  data;
        }else{
          setState(() {
            result=[];
            toResult = false;
          });
        }
      }else{
        setState(() {
          result=[];
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
        result=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
  void callback(string){
    setState(() {
      _getresult();
      widget.callback("");
    });
  }

  Future<void> getSession() async{
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      // var ids=prefs.getInt(FirstScreenState.UNIQEId);
      // id=ids != null?ids:2;
    });
    print("hIIIIIIII :::::::::${id}");
  }
  @override
  void initState() {
    _getresult();
    //getSession();
    //_questions();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: PopScope(
        onPopInvoked: (val){
          setState(() {
            widget.callback("");
          });
        },
        child: SingleChildScrollView(
          child: Container(
            height: height,
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
            child:Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                          onTap: (){
                            Navigator.pop(context);
                            setState(() {
                              widget.callback("");
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(Icons.arrow_back_ios_new,color: Colors.white,),
                          )),
                    ],
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: Colors.white
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(18.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 30,
                                ),
                                Text("${widget.cate["category_name"]}",style: TextStyle(decoration: TextDecoration.none,fontSize: 24,fontWeight: FontWeight.w600,color: Colors.black),),
                                SizedBox(
                                  height: 10,
                                ),
                                Text("Objective",style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),),
                                SizedBox(
                                  height: 4,
                                ),
                                Text("Spatial reasoning tests is used to assess your capacity to manipulate 2D and 3D objects, spot patterns between shapes, "
                                    "and to visualise movements and change in those option is a rotation of a given 2D image.",
                                  style: TextStyle(decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black),textAlign: TextAlign.left,),
                                SizedBox(
                                  height: 14,
                                ),
                                Container(
                                  width: width,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Color(0xFFFEF5CB),
                                  ),
                                  child:Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child:Column(
                                      children: [
                                        Row(
                                          children: [
                                            Icon(Icons.error_outlined,color:Color(0xFFEFD032),size: 24,),
                                            Text("  Note:",style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),)
                                          ],
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(14.0),
                                          child: Text("There is no time limit in this test.Please complete the questions as "
                                              "accurately as you can.At the end, you will be able to view detailed results of your progress.",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: InkWell(
                            onTap: (){
                              if(toResult == true){
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultQuestion(cate: widget.cate["category_name"],callback: callback,)));
                              }else{
                                Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionOptions(cate: widget.cate["category_name"],callback: callback,moveResult: false,job_aply_id: "",)));
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
                                child: Center(child: Text("Begin test",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
