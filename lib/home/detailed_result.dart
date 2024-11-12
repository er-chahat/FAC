import 'dart:convert';

import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart'as http;
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
//import 'package:syncfusion_flutter_charts/charts.dart';


class DetailResult extends StatefulWidget {
  var show;
  var heading;
  var cor;
  var wrong;
  var userId;
  DetailResult({required this.heading,required this.show,required this.cor,required this.wrong,this.userId});

  @override
  State<DetailResult> createState() => _DetailResultState();
}

class _DetailResultState extends State<DetailResult> {
  late List<GDPData> _chartData;
  late List<GDP2Data> _chartData2;
  var detailedData ;
  var ansView ;
  var rult_data=[];
  bool viewAnswer = false;
  var optionAns =[
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
  ];

  Future _answer() async {
    try {
      print("hello i am the blogview");
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
      print("hello its your resut l ::: $data");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII");
        if(data["error"]==0){
          setState(() {
            rult_data=data;
          });
          return  data;
        }else{
          setState(() {
            rult_data=[];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Unable to get the data"),
              duration: Duration(seconds: 2),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      }else{
        setState(() {
          rult_data=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

      }

    }catch(e){
      setState(() {
        rult_data=[];
      });
      print("your excepton is :::: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
      //Get.snackbar('Exception',e.toString());
    }
  }

  Future _detailedResult() async {
    try {
      print("hello i am the blogview");
      var url = Uri.parse(
          "$mainurl/test_percentage.php");
      Map mapdata = {
        "updte":"1",
        "user_id": widget.userId,
        "category_name": widget.heading,
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII its sresult $data");
        if(data["error"]==0){
          setState(() {
            detailedData=data;
          });

          return  data;
        }else{
          setState(() {
            detailedData=[];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Unable to get the data"),
              duration: Duration(seconds: 2),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      }else{
        setState(() {
          detailedData=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

      }

    }catch(e){
      print("your excepton is :::: $e");
      setState(() {
        detailedData=[];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
      //Get.snackbar('Exception',e.toString());
    }
  }
  Future _viewAns() async {
    try {
      print("hello i am the blogview");
      var url = Uri.parse(
          "$mainurl/test_ques_ans_list.php");
      Map mapdata = {
        "updte":"1",
        "user_id": widget.userId,
        "category_name": widget.heading,
      };
      print("$mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII its sresult $data");
        if(data["error"]==0){
          setState(() {
            ansView=data["qus"];
          });

          return  data;
        }else{
          setState(() {
            ansView=[];
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Unable to get the data"),
              duration: Duration(seconds: 2),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
        }
      }else{
        setState(() {
          ansView=[];
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );

      }

    }catch(e){
      print("your excepton is :::: $e");
      setState(() {
        ansView=[];
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
          duration: Duration(seconds: 2),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
      //Get.snackbar('Exception',e.toString());
    }
  }


  @override
  void initState() {
    _chartData = getChartData((widget.cor).toInt(),(widget.wrong).toInt());
    _chartData2 = getChartData2();
    // _answer();
    _detailedResult();
    _viewAns();
    print("your chart data is ::::: $_chartData");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
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
                            child: Icon(Icons.arrow_back_ios_new,color: Colors.black,)),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Container(
                    //   height: height/3,
                    //   width: width,
                    //   child: SvgPicture.asset(second),
                    // ),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Complete Test Result",style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),),
                    SizedBox(
                      height: 10,
                    ),
                    Text(widget.heading,style: TextStyle(decoration: TextDecoration.none,fontSize: 24,fontWeight: FontWeight.w600,color: Colors.black),),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Test results:",style: TextStyle(decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black),),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFD6FDEF),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(16.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(detailedData==null?"Loading...":detailedData.length==0?"Data is Inclusive":"Total score is : ${detailedData["total_correct_ans"]}",style: TextStyle(decoration: TextDecoration.none,fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                            if(detailedData!=null && detailedData.length!=0)
                            Text("Time taken : ${detailedData["total_test_hours"]=="0"?"":"${detailedData["total_test_hours"]} hours , "}${detailedData["total_test_minutes"]=="0"?"":"${detailedData["total_test_minutes"]} min , "}${detailedData["total_test_seconds"]=="0"?"":"${detailedData["total_test_seconds"]} sec "}",style: TextStyle(decoration: TextDecoration.none,fontSize: 16,fontWeight: FontWeight.w500,color: Colors.black),),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Text("Detailed Result",style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    if(detailedData!=null && detailedData.length!=0)
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFF8F7F9),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //if(detailedData == null)
                            _chartData==null?_chartData.length!=0?Container(
                              child: Text("Data not fount"),
                            ):Center(child: CircularProgressIndicator(color: Color(0xFF118743),)):Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Text("Answers",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black),),
                                    //SfCircularChart(),
                                    // Stack(
                                    //   children: [
                                    //     Container(
                                    //       height: 180,
                                    //       width: width/2.2,
                                    //       child: SfCircularChart(
                                    //         series: <CircularSeries>[
                                    //           DoughnutSeries<GDPData,String>(
                                    //             dataSource: _chartData,
                                    //             innerRadius: "60%",
                                    //             radius: "100%",
                                    //             pointColorMapper: (GDPData data, _)=>data.clr,
                                    //             xValueMapper: (GDPData data, _)=>data.continent,
                                    //             yValueMapper: (GDPData data, _)=>data.gdp,
                                    //           )
                                    //         ],
                                    //       ),
                                    //     ),
                                    //     Positioned(
                                    //       top: 80,
                                    //       bottom: 4,
                                    //       left: 4,
                                    //       right: 4,
                                    //       child: Column(
                                    //         children: [
                                    //           Text("${detailedData==null?Text("loading.."):detailedData["percentage_correct_ans"].toInt()} %",style: TextStyle(color: Colors.black,fontSize: 25,fontWeight: FontWeight.w700,height: 1),),
                                    //         ],
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    colorResponse(Color(0xFF8FBF00), "Correct Answer", detailedData==null?"0":"${detailedData["total_correct_ans"]}"),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    colorResponse(Color(0xFFDD2E2E), "Wrong Answer", detailedData==null?"0":"${detailedData["total_wrong_ans"]}"),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    // colorResponse(Color(0xFFDD2E2E), "Unanswered", "6"),
                                    // SizedBox(
                                    //   height: 8,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 24,
                    ),
                    if(viewAnswer==false)
                      InkWell(
                        onTap: (){
                          setState(() {
                            viewAnswer=true;
                          });
                          //Navigator.push(context, MaterialPageRoute(builder: (context)=>ViewCorrectAns(img: quan_iq, heading: widget.heading)));
                        },
                        child: Container(
                          width: width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(width: 1,color: Color(0xFF118743))
                          ),
                          child: Center(
                            child: Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: Text("View answers",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Color(0xFF118743)),),
                            ),
                          ),
                        ),
                      ),
                    if(viewAnswer==false)
                      SizedBox(
                        height: 24,
                      ),
                    if(viewAnswer ==  true && ansView != null)
                    Text("Questions",style: TextStyle(decoration: TextDecoration.none,fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                    SizedBox(
                      width: 10,
                    ),
                    if(viewAnswer ==  true && ansView != null)
                      for(int i=0;i<ansView.length;i++)
                        Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.black12,width: 1)
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Text("Q. ${i+1}",style: TextStyle(decoration: TextDecoration.none,fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    width: width/1.6,
                                      child: Text("${ansView[i]["question"]}?",softWrap: true,maxLines: 4,overflow: TextOverflow.ellipsis,style: TextStyle(decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black),)),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              for(int j=0;j<ansView[i]["total_answer"];j++)
                              options(optionAns[j], ansView[i]["answers"][j]["answer"], j,ansView[i]["correct_answer"][0],ansView[i]["user_answer"][0]),
                              SizedBox(
                                height: 10,
                              ),
                              // options("B", "531", 1),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // options("C", "321", 2),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // options("D", "654", 3),
                              // SizedBox(
                              //   height: 10,
                              // ),
                              // options("E", "I don’t know", 4),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],

                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget clredBox(var width,var colr,var heading,var emoji,var data){
    return Container(
      width: width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: colr,
      ),
      child:Padding(
        padding: const EdgeInsets.all(20.0),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              children: [
                Text(emoji,style: TextStyle(decoration: TextDecoration.none,fontSize: 15,fontWeight: FontWeight.w800,color: Colors.amber),),
                SizedBox(
                  width: 10,
                ),
                // Text(heading,style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w700,color: theme_color),),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 26.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(heading,style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black54),textAlign: TextAlign.justify,),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget colorResponse(var clr,var text, var numb){
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(width: 1,color: Colors.black12)
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(2),
                      color: clr
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(text,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),)
              ],
            ),
            Text(numb,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),)

          ],
        ),
      ),
    );
  }
  Widget options(var op_n ,var op ,var index,var cor,var user_ans){
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: InkWell(
        onTap: (){
          setState(() {
          });
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(width: 1,color: op==cor?Color(0xFF8FBF00):op==user_ans?Color(0xFFDD2E2E):Colors.black12),
            borderRadius: BorderRadius.circular(12),
            color: op==cor?Color(0xFFF4FBC9):op==user_ans?Color(0xFFFDE3D5):Colors.white,
          ),
          child:Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(op_n,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 14,color: Colors.black),),
                    SizedBox(
                      width: 16,
                    ),
                    Text(op,style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black))
                  ],
                ),
                op!=user_ans?op==cor?Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.check_circle,size: 24,color: Color(0xFF8FBF00),)):Container(
                  height: 20,
                  width: 20,
                  decoration: BoxDecoration(
                    border: Border.all(width: 1,color: Colors.black26),
                    shape: BoxShape.circle,
                  ),
                ):op==cor?Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: Icon(Icons.check_circle,size: 24,color: Color(0xFF118743),)):Container(
                    padding: EdgeInsets.zero,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFFDD2E2E),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(2),
                      child: Icon(Icons.clear,size: 16,color: Colors.white,),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<GDPData> getChartData(int per,int per2){
    final List<GDPData> chartData =[
      GDPData("correct", per,Color(0xFF8FBF00)),
      GDPData("wrong", per2,Color(0xFFDD2E2E)),
    ];
    return chartData;
  }
  List<GDP2Data> getChartData2(){
    final List<GDP2Data> chartData =[
      GDP2Data("Oceania", 40,Color(0xFF8D0CCA),"100%"),
      GDP2Data("Africa", 40,Color(0xFFF9AE00),"100%"),
      GDP2Data("Asia",70,Color(0xFF00BCBF),"100%"),
      GDP2Data("Asia", 50,Color(0xFF8FBF00),"100%"),
      GDP2Data("Asia", 20,Color(0xFFDD2E2E),"50%"),
    ];
    return chartData;
  }
}

class GDPData{
  GDPData(this.continent,this.gdp,this.clr);
  final String continent;
  final int gdp;
  final Color clr;

}
class GDP2Data{
  GDP2Data(this.continent,this.gdp,this.clr,this.radius);
  final String continent;
  final int gdp;
  final Color clr;
  final String radius;

}


