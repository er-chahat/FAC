import 'dart:convert';

import 'package:fac/employeer/add_question.dart';
import 'package:fac/employeer/question_list.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:http/http.dart' as http;
import '../starting/splashscreen.dart';

class AddCategory extends StatefulWidget {
  const AddCategory({super.key});

  @override
  State<AddCategory> createState() => _AddCategoryState();
}

class _AddCategoryState extends State<AddCategory> {
  TextEditingController _category = TextEditingController();
  final GlobalKey<FormState> _key = GlobalKey();
  var data2;

  Future _showModal(var height,var width,var cate)async{
    return showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return MyModel(height,width,cate);
      },
    );
  }
  void callback(String s){
    setState(() {
      get_cate();
    });
  }

  Future _catPost(var cat_id) async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/employer_add_category.php");
      Map mapdata = {
        "updte":1,
        "category_name": _category.text,
        "user_id": user_id.toString(),
        "emp_category_id": cat_id,
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
            _category.clear();
            Navigator.pop(context);
            get_cate();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Category Added Successfully"),
              duration: Duration(seconds: 2 ),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );

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
  Future _delete(var cate_id) async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/employer_category_delete.php");
      Map mapdata = {
        "updte":1,
        "user_id": user_id.toString(),
        "emp_category_id": cate_id,
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
        print("your data 2 mesg data is :   in cate HIIIIIIIIIIIIIIIII$data");
        if(data["error"]==0 || data["error"] == 2){
          setState(() {
            get_cate();
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Category Deleted Successfully"),
              duration: Duration(seconds: 2 ),
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
            ),
          );

          // Navigator.pop(context);
          // setState(() {
          //   widget.callback("");
          // });
          print("your data 2 mesg data is :::::::::::::questons :::::::::::$data  HIIIIIIIIIIIIIIIII");
          return  data;
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Something went wrong in delete"),
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
  Future get_cate() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse(
          "$mainurl/employer_category_list.php");
      Map mapdata = {
        "updte":1,
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
        print("your data 2 mesg data is :  HIIIIIIIIIIIIIIIII$data");
        if(data["error"]==0){
          setState(() {
            data2=data["categories_list"];
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
  @override
  void initState() {
    get_cate();
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
          "Add Category",
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
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Categories",style: TextStyle(fontWeight: FontWeight.w600,fontSize: 14,color: Colors.black),),
                InkWell(
                  onTap: (){
                    _showModal(height, width,"");
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.green.shade800
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Text("+Add",style: TextStyle(color: Colors.white,fontSize: 14),),
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
                  child: subcate(width, "", data2[i], i,height),
                ),
          ],
        ),
      ),

    );
  }
  Widget subcate(var width,var img,var heading,var index,var height)=>InkWell(
    onTap: ()async{
      Navigator.push(context, MaterialPageRoute(builder: (context)=>QuestionList(cate: heading["emp_category_id"])));
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      width: width/2,
                      child: Text(heading["category_name"],
                        style: TextStyle(fontWeight: FontWeight.w700,fontSize: 16,color: Colors.black
                        ),softWrap: true,overflow: TextOverflow.ellipsis,)
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Text("Total Question : 5",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 14,color: Colors.black),),
                ],
              ),
            ),
            InkWell(
              onTap: (){
                _category.text=heading["category_name"]??"";
                _showModal(height, width,heading["emp_category_id"]);
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
            InkWell(
              onTap: (){
                delete(heading["emp_category_id"]);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xFFF9EDED),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child:Icon(Icons.delete,size: 25,color: Colors.red.shade800,),
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget MyModel(var height, var width,var cate)=>StatefulBuilder(
      builder:(BuildContext context,state) {
        return DraggableScrollableSheet(
          initialChildSize: 0.5,
          minChildSize: 0.3,
          maxChildSize: 0.9,
          builder: (_,controller) =>Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20))
            ),
            child: Form(
              key: _key,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(
                  controller: controller,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Add Question Category",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                        IconButton(onPressed: (){
                          Navigator.pop(context);
                        }, icon: Icon(Icons.clear,color: Colors.black,size: 28,))
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      controller: _category,
                      maxLines: 3,
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
                        hintText: "Enter Category",
                      ),
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    // GooglePayButton(paymentConfiguration: PaymentConfiguration.fromJsonString(
                    //     defaultGooglePays), paymentItems: _paymentItems,
                    //   type: GooglePayButtonType.pay,
                    //   margin: const EdgeInsets.only(top: 15.0),
                    //   onPaymentResult: onGooglePayResult,
                    //   loadingIndicator: const Center(
                    //     child: CircularProgressIndicator(),
                    //   ),
                    // ),
                    InkWell(
                      onTap: (){
                        if(_key.currentState!.validate()){
                          _catPost(cate);
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
                          child: Center(child:
                          Text("Save",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w500,color: Colors.white),)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }
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
  void delete(var cate) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        content: Container(
            height: 50,
            width: 50,
            child: Center(
                child: Text(
                  "Are You Sure? You Want to Delete this Category",
                  style: GoogleFonts.baloo2(
                      fontWeight: FontWeight.bold, fontSize: 17),
                ))),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Back",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743)),
                    )),
                Spacer(
                  flex: 2,
                ),
                Container(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        _delete(cate);
                        Navigator.pop(context);
                        // Delete(context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(color: Colors.white),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                      ),
                    )),
              ],
            ),
          )
        ],
      ));
}
