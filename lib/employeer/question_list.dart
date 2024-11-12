import 'dart:convert';

import 'package:fac/employeer/add_question.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../starting/splashscreen.dart';

class QuestionList extends StatefulWidget {
  var cate;
  QuestionList({required this.cate});

  @override
  State<QuestionList> createState() => _QuestionListState();
}

class _QuestionListState extends State<QuestionList> {
  var cat_id="";
  var data2;


  Future get_question() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/employer_category_question_list.php");
      Map mapdata = {
        "updte":1,
        "emp_category_id":widget.cate,
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
            data2=data["question_list"];
          });
          // Navigator.pop(context);
          // setState(() {
          //   widget.callback("");
          // });
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
          return  data;
        }else{
          setState(() {
            data2=[];
          });
          // ScaffoldMessenger.of(context).showSnackBar(
          //   SnackBar(
          //     content: Text("Something went wrong"),
          //     duration: Duration(seconds: 2 ),
          //     shape:
          //     RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          //   ),
          // );
          //MotionToast.error(description: Text(data["error_msg"]));
        }
      }else{
        setState(() {
          data2=[];
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
      setState(() {
        data2=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }
  void callback(String s){
    setState(() {
      get_question();
    });
  }
  @override
  void initState() {
    get_question();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var width = size.width;
    var height = size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Question List",
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Categories",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black),),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddQuestion(cat_id: widget.cate,callback: callback,isEdit: false,ques_id: "",)));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.green.shade800
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text("+Add Question",style: TextStyle(color: Colors.white,fontSize: 14),),
                      ),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: 10,
              ),
              if(data2 == null )
                CircularProgressIndicator(color: Colors.green,),
              if(data2 != null && data2.length ==0)
                Center(child: Text("No data found !",style: TextStyle(color: Colors.black),)),
              if(data2 != null && data2.length >0)
                for(int i =0;i<data2.length;i++)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 12.0),
                    child: subcate(width, "", data2[i], i),
                  ),
            ],
          ),
        ),
      ),

    );
  }
  Widget subcate(var width,var img,var heading,var index)=>InkWell(
    onTap: ()async{
      //Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionsDescription(cate: heading,callback: callback,)));
      print("Yrs you are using correct play pagr::::::::::: ");
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
            Container(
              decoration: BoxDecoration(
                color: Color(0xFFEDF9F0),
                shape: BoxShape.circle
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child:Text("${index+1}",style: TextStyle(fontWeight: FontWeight.w500,fontSize: 26,color: Colors.green.shade800),),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          width: width/1.8,
                          child: Text(heading["question"],style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black),softWrap: true,overflow: TextOverflow.ellipsis,)),
                      SizedBox(
                        height: 4,
                      ),
                      Text("Total Options : 5",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),),
                    ],
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>AddQuestion(cat_id: widget.cate,callback: callback,isEdit: true,ques_id: heading["question_id"],)));
                      // _category.text=heading["category_name"]??"";
                      // _showModal(height, width,heading["emp_category_id"]);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFEDF9F0),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(6.0),
                        child:Icon(Icons.edit,size: 25,color: Colors.green.shade800,),
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
