import 'dart:convert';

import 'package:fac/home/ques_discription.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuestionsScreen extends StatefulWidget {
  const QuestionsScreen({super.key});

  @override
  State<QuestionsScreen> createState() => _QuestionsScreenState();
}

class _QuestionsScreenState extends State<QuestionsScreen> {

  var selected = 0;
  double percent=0;
  var data_test;
  var data_test1;
  var test_taken;
  var category;

  Future _getCateg() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/question_category_list.php");
      var prefs = await SharedPreferences.getInstance();

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
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII");
        if(data["error"]==0){
          setState(() {
            category=data["deta"];
            // percent = total/atmpt;
          });
          return  data;
        }else{
          setState(() {
            category=[];
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
          category=[];
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
        category=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }

  // Future _answer(var name) async {
  //   try {
  //     print("hello iam   the blogview");
  //     var url = Uri.parse(
  //         "$baseUrl/tests.php");
  //     var prefs = await SharedPreferences.getInstance();
  //     var ids=prefs.getInt(FirstScreenState.UNIQEId);
  //     var session_id=ids != null?ids:2;
  //     Map mapdata = {
  //       "updte":"1",
  //       "session": "$session_id",
  //       "category_name":name
  //     };
  //     print("$mapdata");
  //     print("hello");
  //     //http.Response response = await http.post(url,body: mapdata);
  //     http.Response response = await http.post(url, body: jsonEncode(mapdata));
  //     print("hello");
  //
  //     var data = json.decode(response.body);
  //     //print("its compleeter data ${copleteData}");
  //     print("data test $data");
  //
  //     if(response.statusCode ==200){
  //       print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII");
  //       if(data["error"]==0){
  //         setState(() {
  //           data_test=data["tests"];
  //         });
  //         print("data test $data_test");
  //         return  data;
  //       }else{
  //         setState(() {
  //           data_test=[];
  //         });
  //         MotionToast.error(description: Text(data["error_msg"]));
  //       }
  //     }else{
  //       setState(() {
  //         data_test=[];
  //       });
  //       MotionToast.warning(
  //           title:  Text("${data["error_msg"]}"),
  //           description:  Text("try again later ")
  //       ).show(context);
  //
  //     }
  //
  //   }catch(e){
  //     setState(() {
  //       data_test=[];
  //     });
  //     print("your excepton is :::: in your answer code :::: :$e");
  //     MotionToast.warning(
  //         title:  Text("$e"),
  //         description:  Text("try again later ")
  //     ).show(context);
  //     //Get.snackbar('Exception',e.toString());
  //   }
  // }
  // Future _subcat(int cat_id) async {
  //   try {
  //     print("hello iam inside the blogview");
  //     var url = Uri.parse(
  //         "$baseUrl/categories_wise_list.php");
  //     Map mapdata = {
  //       "updte":"1",
  //       "category_id": cat_id
  //     };
  //     //http.Response response = await http.post(url,body: mapdata);
  //     http.Response response = await http.post(url,body: jsonEncode(mapdata));
  //     print("hello");
  //
  //     var data = json.decode(response.body);
  //     //print("its compleeter data ${copleteData}");
  //
  //     if(response.statusCode ==200){
  //       print("h200 ::::::: hello its you subcat api ::::::::::::::::::::::::::::${data}");
  //       if(data["error"]==0) {
  //         setState(() {
  //           data_test1=data;
  //         });
  //         print("h200 ::::::: hello its you subcat api ::::::::::::::::::::::::::::${data}");
  //         return data;
  //       }else{
  //         setState(() {
  //           data_test1=[];
  //         });
  //         MotionToast.warning(
  //             title:  Text("${data["error_msg"]}"),
  //             description:  Text("Try Again!!")
  //         ).show(context);
  //         return data;
  //       }
  //     }else{
  //       setState(() {
  //         data_test1=[];
  //       });
  //       MotionToast.warning(
  //           title:  Text("${data["message"]}"),
  //           description:  Text("try again later ")
  //       ).show(context);
  //     }
  //
  //   }catch(e){
  //     setState(() {
  //       data_test1=[];
  //     });
  //     print("your excepton is :::: $e");
  //     MotionToast.warning(
  //         title:  Text("$e"),
  //         description:  Text("try again later ")
  //     ).show(context);
  //     //Get.snackbar('Exception',e.toString());
  //   }
  // }

  void callback(String name){
    setState(() {
      // _answer(name);

    });
  }

  @override
  void initState() {
    _getCateg();
    // _answer("IQ Test");
    // _testTaken();
    // _subcat(1);
    //music();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              if(Navigator.canPop(context))
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Icon(Icons.arrow_back_ios_new,color: Colors.black,),
                        )),
                  ],
                ),
              SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        text: 'All available categories',
                        style:TextStyle(fontSize: 32,color: Colors.black,fontWeight: FontWeight.w600),
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    width: 60,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Text("Recents",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: width/2.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF8F7F9),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // Container(
                              //   height: 87,
                              //   width: 93,
                              //   child: SvgPicture.asset(
                              //       gen_iq
                              //   ),
                              // ),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  width: width/2.4,
                                  child: Text("IQ Test",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),softWrap: true,overflow: TextOverflow.ellipsis,)),
                              SizedBox(
                                height: 4,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Completed",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),),
                                  Text("50 %",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.green),),
                                ],
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              LinearPercentIndicator(
                                padding: EdgeInsets.zero,
                                width: width/2.6,
                                animation: true,
                                animationDuration: 1000,
                                lineHeight: 8.0,
                                percent: 0.5,

                                linearStrokeCap: LinearStrokeCap.roundAll,
                                barRadius: Radius.circular(10),
                                progressColor: Colors.green,
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                    Container(
                      width: width/2.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF8F7F9),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                // Container(
                                //   height: 87,
                                //   width: 93,
                                //   child: SvgPicture.asset(
                                //       prsnlty
                                //   ),
                                // ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                Container(
                                    width: width/2.4,
                                    child: Text("IQ Tests",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),softWrap: true,overflow: TextOverflow.ellipsis,)),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("Completed",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),),
                                    Text("20 %",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.green),),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                LinearPercentIndicator(
                                  padding: EdgeInsets.zero,
                                  width: width/2.6,
                                  animation: true,
                                  animationDuration: 1000,
                                  lineHeight: 8.0,
                                  percent: 0.2,

                                  linearStrokeCap: LinearStrokeCap.roundAll,
                                  barRadius: Radius.circular(10),
                                  progressColor: Colors.green,
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text("Categories",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black),),
              SizedBox(
                height: 10,
              ),
              if(category == null)
                Center(child: CircularProgressIndicator(color: Colors.green,)),
              if(category != null)
                for(int i=0;i<category.length; i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 14.0),
                    child: subcate(width, "",category[i]["category_name"], 2+i,i),
                  ),
              // if(selected==0)
              //   data_test==null?Center(child: CircularProgressIndicator(color: theme_color,)):testIQ(width),
              // if(selected==1)
              //   data_test==null?Center(child: CircularProgressIndicator(color: theme_color,)):personalityTest(width),
              // if(selected==2)
              //   data_test==null?Center(child: CircularProgressIndicator(color: theme_color,)):MentalHelTest(width)
            ],
          ),
        ),
      ),
    );
  }


  Widget subcate(var width,var img,var heading, var percent,var index)=>InkWell(
    onTap: ()async{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsDescription(cate: heading,callback: callback,)));
      print("Yrs you are using correct play pagr::::::::::: ");
     // print("::::::::::::::::::::::::::::${(int.parse(data_test[index]["completed_questions"])/int.parse(data_test[index]["total_questions"]))/10}");
      //await player.play(AssetSource('sound/tune.mp3'));
    },
    child: Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFFF8F7F9),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                // Container(
                //   height: 40,
                //   width: 43,
                //   child: SvgPicture.asset(
                //       img
                //   ),
                // ),
                SizedBox(
                  width: 16,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        width: width/2.1,
                        child: Text(heading,style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black),softWrap: true,overflow: TextOverflow.ellipsis,)),
                    SizedBox(
                      height: 4,
                    ),
                    Text("4|10 completed",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),),
                  ],
                ),
              ],
            ),
            SizedBox(
              width: 4,
            ),
            Container(
              height: 80,
              child: CircularPercentIndicator(
                radius: 34.0,
                lineWidth: 6.0,
                animation: true,
                percent: percent/10,
                center: new Text(
                  "${percent*10} %",
                  style:
                  new TextStyle(fontWeight: FontWeight.bold, fontSize: 14.0),),
                circularStrokeCap: CircularStrokeCap.round,
                progressColor: Colors.green,
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Future<void> showErrorAlert()async{
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title:  Text(''),
          content:  SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Icon(Icons.error_outline,size: 28,color: Colors.red,),
                SizedBox(
                  height: 10,
                ),
                Text("!!Oops no Questions available"),
              ],
            ),
          ),
          actions: <Widget>[

          ],
        );
      },
    );
  }
}
