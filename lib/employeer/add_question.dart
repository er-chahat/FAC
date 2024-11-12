import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import '../starting/splashscreen.dart';

class AddQuestion extends StatefulWidget {
  var cat_id;
  var ques_id;
  var isEdit;
  final Function(String) callback;
  AddQuestion({required this.cat_id,required this.callback,required this.isEdit,required this.ques_id});

  @override
  State<AddQuestion> createState() => _AddQuestionState();
}

class _AddQuestionState extends State<AddQuestion> {
  List<Widget> _textFields = [];
  List<TextEditingController> _controllers = [];
  List<TextEditingController> _controllers2 = [];
  TextEditingController _question = TextEditingController();
  var ans =[];
  var score=[];
  var editDetails;
  List<String> itemListt = ['Active', 'Inactive'];
  List<String> _dropdownValues = [];
  String? selectedItemm;

  final GlobalKey<FormState> _key = GlobalKey();

  Future _addQuestion() async {
    try {
      print("hello iam   the blogview");
      print("its your length ${_controllers.length}");
      print("its your length ${_dropdownValues.length}");
      if(ans.isNotEmpty){
        ans.clear();
      }
      if(score.isNotEmpty){
        score.clear();
      }
      for (int i = 0; i < _controllers.length; i++) {
        ans.add( _controllers[i].text.toString());
      }
      for (int i = _controllers.length-1; i >=0 ; i--) {
        if(_dropdownValues[i]=="Correct") {
          score.add(int.parse("1"));
        }else{
          score.add(int.parse("0"));
        }
      }
      var url = Uri.parse("$mainurl/employer_add_question.php");

      Map<String, dynamic> mapdata = {
        "updte": "1",
        "emp_category_id": widget.cat_id,
        "user_id": user_id.toString(),
        "question": _question.text,
        "answer_val":ans,
        "score":score
      };


      print("it your map data $mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello hi ka ");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII${data}");
        if(data["error"]==0){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Question Added Successfully"),
              duration: Duration(seconds: 2 ),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
          setState(() {
            Navigator.pop(context);
            widget.callback("");
          });

          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
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

      }

    }catch(e){
      print("your excepton is :::: $e");

    }
  }
  Future _editQues() async {
    try {
      print("hello i am   the blogview");

      var url = Uri.parse("$mainurl/employer_add_question.php");
      if(ans.isNotEmpty){
        ans.clear();
      }
      if(score.isNotEmpty){
        score.clear();
      }
      for (int i = 0; i < _controllers.length; i++) {
        ans.add( _controllers[i].text.toString());
        if(_dropdownValues[i]=="Correct") {
          score.add(int.parse("1"));
        }else{
          score.add(int.parse("0"));
        }
      }
      Map<String, dynamic> mapdata = {
        "updte": "1",
        "emp_category_id": widget.cat_id,
        "user_id": user_id.toString(),
        "question": _question.text,
        "question_id": widget.ques_id,
        "answer_val":ans,
        "score":score
      };


      print("it your map data $mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello hi ka ");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII${data}");
        if(data["error"]==0){
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Question Updated Successfully"),
              duration: Duration(seconds: 2 ),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );
          setState(() {
            Navigator.pop(context);
            widget.callback("");
          });


          // Navigator.pop(context);
          // setState(() {
          //   widget.callback("");
          // });
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
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
  Future _getEdit() async {
    try {
      print("hello iam   the blogview");
      print("its your length ${_controllers2.length}");
      var url = Uri.parse("$mainurl/employer_question_detials.php");
      // Map mapdata = {
      //   "updte":1,
      //   "emp_category_id": widget.cat_id,
      //   "user_id": user_id.toString(),
      //   "question": _question.text,
      //   for(int i =0;i< _controllers.length;i++)"answer_val": _controllers[i].text,
      //   for(int i =0;i< _controllers2.length;i++)"score": _controllers2[i].text,
      //   // "score": cat_id,
      //
      //   //"category_name": widget.heading,
      // };
      Map<String, dynamic> mapdata = {
        "updte": "1",
        "question_id": widget.ques_id,
        "user_id": user_id.toString(),
      };


      print("it your map data $mapdata");
      print("hello");
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      print("hello hi ka ");

      var data = json.decode(response.body);
      //print("its compleeter data ${copleteData}");

      if(response.statusCode ==200){
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII ${data}");
        if(data["error"]==0){
          setState(() {
            editDetails=data;
            _question.text = editDetails["question"];
          });
          // Navigator.pop(context);
          // setState(() {
          //   widget.callback("");
          // });
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
          return  data;
        }else{
          setState(() {
            editDetails=[];
          });
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
        setState(() {
          editDetails=[];
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
        editDetails=[];
      });
      print("your excepton is :::: $e");
      // MotionToast.warning(
      //     title:  Text("$e"),
      //     description:  Text("try again later ")
      // ).show(context);
      //Get.snackbar('Exception',e.toString());
    }
  }


  void _addNewField(var i) {
    var width = MediaQuery.of(context).size.width;

    // Create a new TextEditingController for the answer field
    TextEditingController answerController = TextEditingController();
    _controllers.add(answerController);

    // Create a new controller for the dropdown value

    String dropdownValue = widget.isEdit==true?"${editDetails["answers"][i]["score"] == "0"?"Wrong":"Correct"}":"Wrong";

    setState(() {
      if (widget.isEdit) {
        answerController.text = editDetails["answers"][i]["answer_val"];
        _dropdownValues.add(dropdownValue);
      }
      if(!widget.isEdit)
        _dropdownValues.add(dropdownValue);

      _textFields.add(
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: width / 2.2,
              child: Column(
                children: [
                  Row(
                    children: [
                      Text("Answer", style: GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 17)),
                      Text("*", style: GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 5),
                  TextFormField(
                    controller: answerController,
                    maxLines: 2,
                    minLines: 1,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter ";
                      }
                      return null;
                    },
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Enter Option",
                    ),
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: width / 3,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text("Score", style: GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 17)),
                      Text("*", style: GoogleFonts.rubik(fontWeight: FontWeight.w600, fontSize: 17, color: Colors.red)),
                    ],
                  ),
                  SizedBox(height: 5),
                  DropdownButtonFormField<String>(
                    value: dropdownValue,
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                        _dropdownValues[i] = newValue;
                      });
                    },
                    items: <String>["Wrong", "Correct"]
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: Colors.white,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      hintText: "Score",
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Enter Score";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            if (!widget.isEdit && _controllers.length >1)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.cancel, color: Colors.red),
                    onPressed: () {
                      _removeField(answerController);
                    },
                  ),
                ),
              ),
            if (!widget.isEdit && _controllers.length <=1)
              Padding(
                padding: const EdgeInsets.only(top: 20.0),
                child: Align(
                  alignment: Alignment.center,
                  child: IconButton(
                    icon: Icon(Icons.cancel, color: Colors.transparent),
                    onPressed: () {
                      // _removeField(answerController);
                    },
                  ),
                ),
              ),
          ],
        ),
      );
    });
  }

  void _removeField(TextEditingController controller) {
    // Find the index of the controller and remove it from the list
    int index = _controllers.indexOf(controller);
    setState(() {
      _controllers.removeAt(index);
      _dropdownValues.removeAt(index);
      _textFields.removeAt(index);
    });
  }


  // Method to expose the list of controllers
  List<TextEditingController> getControllers() {
    return _controllers;
  }
  
  void func()async{
    Future.delayed(Duration(seconds: 1),(){
      if(widget.isEdit == true) {
        print("hello its rows $editDetails");
        if(editDetails != null && editDetails.length != 0) {
          print("hello its rows $editDetails");
          for (int i = 0; i < editDetails["rows"]; i++) {
            print("hello its rows  $i");
            _addNewField(i);

          }
        }
      }else{
        _addNewField(0);
      }
    });
  }

  @override
  void initState() {
    if(widget.isEdit) {
      _getEdit();
    }
    func();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    // TODO: implement dispose
    super.dispose();
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
          "Add Question",
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
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Form(
                  key: _key,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text("Questions",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                          Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                        ],
                      ),
                      SizedBox(height: 5,),
                      TextFormField(
                        controller: _question,
                        maxLines: 4,
                        minLines: 1,
                        validator: (value){
                          if(value == null || value!.isEmpty){
                            return "Enter Category";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          contentPadding:
                          EdgeInsets.symmetric(horizontal: 16),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          border: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey), // Set the border color
                            borderRadius: BorderRadius.circular(10),
                          ),
                          hintText: "Enter Question",
                        ),
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      ..._textFields,
                      SizedBox(
                        height: 20,
                      ),
                      if(widget.isEdit != true)
                        InkWell(
                        onTap: (){
                          _addNewField(0);
                        },
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Color(0xFF118743)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Text("+Add Options",style: TextStyle(color: Colors.white,fontSize: 14),),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            InkWell(
              onTap: (){
                if(_key.currentState!.validate()){
                  if(widget.isEdit){
                    _editQues();
                  }else {
                    _addQuestion();
                  }
                }
              },
              child: Container(
                width: width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: Color(0xFF118743),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(14.0),
                  child: Center(child:
                  Text("Save",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
