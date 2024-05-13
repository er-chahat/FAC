import 'package:flutter/material.dart';

class ResultQuestion extends StatefulWidget {
  const ResultQuestion({super.key});

  @override
  State<ResultQuestion> createState() => _ResultQuestionState();
}

class _ResultQuestionState extends State<ResultQuestion> {
  var rult_data;
  var detailedData ;
  var plan ;

  bool showSub = false;

  var data_test_IQ;


  void callback(String s){
    setState(() {
    });
  }



  @override
  void initState() {
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
                    Icon(Icons.check_circle,color: Colors.green,size: 60,),
                    SizedBox(
                      height: 30,
                    ),
                    Text("You have completed test",style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w400,color: Colors.black),),
                    SizedBox(
                      height: 2,
                    ),
                    Text("IQ Test",style: TextStyle(decoration: TextDecoration.none,fontSize: 24,fontWeight: FontWeight.w600,color: Colors.black),),
                    SizedBox(
                      height: 30,
                    ),
                    Text("Here are Your results:",style: TextStyle(decoration: TextDecoration.none,fontSize: 12,fontWeight: FontWeight.w400,color: Colors.black),),
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
                          children: [
                            Text("Result descriptions",style: TextStyle(decoration: TextDecoration.none,fontSize: 16,fontWeight: FontWeight.w400,color: Colors.black),),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // Text("120",style: TextStyle(decoration: TextDecoration.none,fontSize:32,fontWeight: FontWeight.w600,color: black),),
                            // Padding(
                            //   padding: const EdgeInsets.all(14.0),
                            //   child: Text("Congratulations. You are above average",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 16,color: Colors.black),textAlign: TextAlign.center,),
                            // )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: (){

                      },
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xFFF1F0F4),
                        ),
                        child:Padding(
                          padding: const EdgeInsets.all(20.0),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Container(
                                  //   height: 16,
                                  //   width: 16,
                                  //   decoration: BoxDecoration(
                                  //       image: DecorationImage(
                                  //           image: AssetImage(
                                  //               stack
                                  //           ),
                                  //           fit: BoxFit.contain
                                  //
                                  //       )
                                  //   ),
                                  // ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text("Detailed Result",style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w600,color: Colors.black),),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                              Icon(Icons.lock,color: Colors.black,size: 16,),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      width: width,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Color(0xFFD5FAE4),
                      ),
                      child:Padding(
                        padding: const EdgeInsets.all(20.0),
                        child:Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Row(
                              children: [
                                Icon(Icons.error_outlined,color:Colors.green,size: 24,),
                                Text("  Detailed Result",style: TextStyle(decoration: TextDecoration.none,fontSize: 14,fontWeight: FontWeight.w700,color: Colors.black),)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 26.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text("Your detailed result will contain the following information",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Correct answers",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Possible career tracks",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Mental strength",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                    ],
                                  ),SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("Mental weaknesses",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: new BoxDecoration(
                                          color: Colors.black,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text("More",style: TextStyle(decoration: TextDecoration.none,fontWeight: FontWeight.w400,fontSize: 12,color: Colors.black),textAlign: TextAlign.left,),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],

                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color(0xFFF1F0F4),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(14.0),
                    child: Center(child: Icon(Icons.share,color: Colors.black54,)),
                  ),
                ),
                InkWell(
                  onTap: (){
                    //showAlertDiaoage(width, height);
                    //Navigator.push(context, MaterialPageRoute(builder: (context)=>Questions(img: widget.img, heading: widget.heading)));
                  },
                  child: Container(
                    width: width/1.4,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.green,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14.0),
                      child: Center(child: Text("Proceed to next test",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  // void showAlertDiaoage(var width,var height) async{
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         backgroundColor: Color(0xFFFFFFFF),
  //         title: Row(
  //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //           children: [
  //             Text("Suggested Tests",style: TextStyle(fontSize:14,fontWeight: FontWeight.w600,color: Colors.black),),
  //             InkWell(
  //                 onTap: (){
  //                   Navigator.pop(context);
  //                 },
  //                 child: Icon(Icons.clear,size: 24,color: Colors.black,))
  //           ],
  //         ),
  //         contentPadding: EdgeInsets.all(14),
  //         content: SingleChildScrollView(
  //           child: Column(
  //             mainAxisAlignment: MainAxisAlignment.start,
  //             children: [
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         music();
  //                       });
  //                       if(data_test_IQ[4]["completed_questions"]!=data_test_IQ[4]["total_questions"]) {
  //                         Navigator.pushReplacement(context,
  //                             MaterialPageRoute(builder: (context) =>
  //                                 TestDiscrip(img: sp_iq,
  //                                   heading: "General IQ",
  //                                   prog: 0,
  //                                   callback: callback,)));
  //                       }else{
  //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteTest(heading: "General IQ")));
  //                       }
  //                     },
  //                     child: Stack(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top:20.0),
  //                           child: Container(
  //                             width: width/2.8,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               color: Color(0xFFF9CCFC),
  //                             ),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(20.0),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: 40,
  //                                   ),
  //                                   Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text("General IQ Test",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),textAlign: TextAlign.center,),
  //                                     ],
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 0,
  //                           left: -10,
  //                           child: Container(
  //                             height: (height/4)/3.1,
  //                             width: width/4.2,
  //                             child: SvgPicture.asset(
  //                                 sp_iq
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         music();
  //                       });
  //                       if(data_test_IQ[1]["completed_questions"]!=data_test_IQ[1]["total_questions"]) {
  //                         Navigator.pushReplacement(context,
  //                             MaterialPageRoute(builder: (context) =>
  //                                 TestDiscrip(img: an_iq,
  //                                   heading: "Emotional IQ",
  //                                   prog: 0,
  //                                   callback: callback,)));
  //                       }else{
  //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteTest(heading: "Emotional IQ")));
  //                       }
  //                     },
  //                     child: Stack(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top:20.0),
  //                           child: Container(
  //                             width: width/3,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               color: Color(0xFFC2C2C2),
  //                             ),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(20.0),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: 40,
  //                                   ),
  //                                   Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text("Emotional IQ Test",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),textAlign: TextAlign.center,),
  //                                     ],
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 0,
  //                           left: -6,
  //                           child: Container(
  //                             height: (height/4)/3.1,
  //                             width: width/4.2,
  //                             child: SvgPicture.asset(
  //                                 an_iq
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //               Row(
  //                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                 children: [
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         music();
  //                       });
  //                       if(data_test_IQ[2]["completed_questions"]!=data_test_IQ[2]["total_questions"]) {
  //                         Navigator.pushReplacement(context,
  //                             MaterialPageRoute(builder: (context) =>
  //                                 TestDiscrip(img: gen_iq,
  //                                   heading: "Memory IQ",
  //                                   prog: 0,
  //                                   callback: callback,)));
  //                       }else{
  //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteTest(heading: "Memory IQ")));
  //                       }
  //                     },
  //                     child: Stack(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top:20.0),
  //                           child: Container(
  //                             width: width/3,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               color: Color(0xFFF4FBC9),
  //                             ),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(20.0),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: 40,
  //                                   ),
  //                                   Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text("Memory IQ Test",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),textAlign: TextAlign.center,),
  //                                     ],
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 0,
  //                           left: -10,
  //                           child: Container(
  //                             height: (height/4)/3.1,
  //                             width: width/4.2,
  //                             child: SvgPicture.asset(
  //                                 gen_iq
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                   InkWell(
  //                     onTap: (){
  //                       setState(() {
  //                         music();
  //                       });
  //                       if(data_test_IQ[3]["completed_questions"]!=data_test_IQ[3]["total_questions"]) {
  //                         Navigator.pushReplacement(context,
  //                             MaterialPageRoute(builder: (context) =>
  //                                 TestDiscrip(img: quan_iq,
  //                                   heading: "Qualitative IQ",
  //                                   prog: 0,
  //                                   callback: callback,)));
  //                       }else{
  //                         Navigator.push(context, MaterialPageRoute(builder: (context)=>CompleteTest(heading: "Qualitative IQ")));
  //                       }
  //                     },
  //                     child: Stack(
  //                       children: [
  //                         Padding(
  //                           padding: const EdgeInsets.only(top:20.0),
  //                           child: Container(
  //                             width: width/3,
  //                             decoration: BoxDecoration(
  //                               borderRadius: BorderRadius.circular(10),
  //                               color: Color(0xFFC9FBEB),
  //                             ),
  //                             child: Padding(
  //                               padding: const EdgeInsets.all(20.0),
  //                               child: Column(
  //                                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                                 crossAxisAlignment: CrossAxisAlignment.start,
  //                                 children: [
  //                                   SizedBox(
  //                                     height: 40,
  //                                   ),
  //                                   Column(
  //                                     crossAxisAlignment: CrossAxisAlignment.start,
  //                                     children: [
  //                                       Text("Qualitative IQ Test",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 16,color: Colors.black),textAlign: TextAlign.center,),
  //                                     ],
  //                                   )
  //                                 ],
  //                               ),
  //                             ),
  //                           ),
  //                         ),
  //                         Positioned(
  //                           top: 0,
  //                           child: Container(
  //                             height: (height/4)/3.1,
  //                             width: width/4.2,
  //                             child: SvgPicture.asset(
  //                                 quan_iq
  //                             ),
  //                           ),
  //                         )
  //                       ],
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           InkWell(
  //             onTap: (){
  //               setState(() {
  //                 music();
  //               });
  //               Navigator.pop(context);
  //               //Navigator.push(context, MaterialPageRoute(builder: (context)=>Questions(img: widget.img, heading: widget.heading)));
  //             },
  //             child: Container(
  //               width: width/1.4,
  //               decoration: BoxDecoration(
  //                 borderRadius: BorderRadius.circular(12),
  //                 color: theme_color,
  //               ),
  //               child: Padding(
  //                 padding: const EdgeInsets.all(14.0),
  //                 child: Center(child: Text("Skip",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
  //               ),
  //             ),
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }

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
                Icon(Icons.error_outline,size: 28,color: Colors.orange,),
                SizedBox(
                  height: 10,
                ),
                Text("To See Detailed Result Buy Subscription First!!"),
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
