import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/home/subb.dart';
import 'package:fac/starting/stripe.dart';
import 'package:fac/starting/stripee.dart';
import 'package:fac/welcome/login.dart';
import 'package:http/http.dart'as http;
import 'package:fac/home/Userbottom.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Usersubsub extends StatefulWidget {
  final Function(String) callback;
  Usersubsub({required this.callback});

  @override
  State<Usersubsub> createState() => _UsersubsubState();
}

class _UsersubsubState extends State<Usersubsub> {
  Map<String, dynamic>? paymentIntent;

  void callback(String s){
    setState(() {
      widget.callback("");
      Nextnow(context);
    });
  }

  _freeala(context) async {


    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["payment_status"] = "Successfully";
    map["transaction_id"]="";
    map["subscription_id"]="1";
    map["user_id"]=user_id.toString();


    var res = await http.post(
        Uri.parse("$mainurl/employer_subscribe.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("New----Mapped::::::$map");
    print(jsondata);
    print('MR.BOSS--->`');

    if (res.statusCode == 200) {

      showDialog<void>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return AlertDialog(
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  SizedBox(height:40),
                  Text('Sucessfully Downgrade to "Free"',textAlign: TextAlign.center,style: GoogleFonts.rubik(fontWeight: FontWeight.w400),),
                  Text('Enjoy Free Features!',textAlign: TextAlign.center,style: GoogleFonts.rubik(fontWeight: FontWeight.w400),),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Continue',style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.green[700]),),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      Timer(Duration(seconds: 3), () {
        setState(() {
          widget.callback("");
        });
        Navigator.pop(context);
       // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile()), (route) => false);
      });

    } else {
      print('error');
    }
  }




  List<dynamic> allsub = [];
  bool _isLoading = true;

  var subname = "";
  var subdes = "";
  var subpr = "";
  var subday = "";
  var ig = "";

  @override
  void initState() {
    Nextnow(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Subscription",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            setState(() {
              widget.callback("");
            });
            Navigator.pop(context);
          },
        ),
      ),
      body:_isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.grey,
                    width: 1.0,
                    style: BorderStyle.solid,
                  ),
                  borderRadius: BorderRadius.circular(20.0)),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                      image: NetworkImage("$photos$ig"),
                      errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                        return Container(
                          height: 55,
                          width: 55,
                          decoration: BoxDecoration(
                            color: Colors.grey[200], // Placeholder background color
                            borderRadius: BorderRadius.circular(8), // Adjust as needed
                          ),
                          child: Icon(
                            Icons.photo_library, // Placeholder icon, you can use any icon or asset
                            size: 30,
                            color: Colors.grey[400],
                          ),
                        );
                      },
                      height: 120,
                      width: 120,
                    ),
                    SizedBox(height: 10,),
                    Text(
                      subdes,
                      style: GoogleFonts.rubik(
                          fontSize: 22, fontWeight: FontWeight.w500,),textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if(subpr=="Free")
                          Text(subpr,style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20),),
                        if(subpr!="Free")
                          Text("\$$subpr",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20),),
                        Text("/$subday Days",style: GoogleFonts.rubik(color: Colors.green,fontSize: 10),)
                      ],
                    ),

                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: allsub.length,
                        itemBuilder: (context, index) {
                          var subscriptionContent = allsub[index];
                          return ListTile(
                            leading: Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            title: Text(
                              subscriptionContent['content'],
                              style: GoogleFonts.rubik(),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 40,),
                    // if(subpr!="Free")
                    //   if(membertype!="Paid")
                    //     Container(
                    //       height: 50,
                    //       width: double.infinity,
                    //       child: ElevatedButton(
                    //         style: ElevatedButton.styleFrom(
                    //           backgroundColor: Colors.green[700],
                    //           shape: RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(20.0),
                    //           ),
                    //         ),
                    //         onPressed: () {
                    //           // paynow(context);
                    //           print("hello");
                    //          // _showMyDialog(subpr);
                    //           StripeeService().makePayment(
                    //             context,
                    //             subpr,
                    //           );
                    //
                    //         },
                    //         child: Text(
                    //           "Buy Now",
                    //           style: GoogleFonts.baloo2(color: Colors.white),
                    //         ),
                    //       ),
                    //     ),
                    if(current_subscription==sub_id)
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                          },
                          child: Text(
                            "Subscription Active",
                            style: GoogleFonts.baloo2(color: Colors.white,fontSize: 17),
                          ),
                        ),
                      ),
                    if(current_subscription==sub_id && subpr!="Free")
                      SizedBox(
                        height: 10,
                      ),
                    if(current_subscription==sub_id && subpr!="Free")
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            _freeala(context);
                          },
                          child: Text(
                            "Cancel Subscription",
                            style: GoogleFonts.baloo2(color: Colors.white,fontSize: 17),
                          ),
                        ),
                      ),
                    if(current_subscription!=sub_id)
                      Container(
                        height: 50,
                        width: double.infinity,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.amber,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            if(subpr=="Free"){
                              _freeala(context);
                            }else{
                              StripeeService().makePayment(
                                context,
                                subpr,callback);
                            }

                          },
                          child: Text(
                            userdes,
                            style: GoogleFonts.baloo2(color: Colors.white,fontSize: 17),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      bottomNavigationBar: Userbottom(),
    );
  }

  Nextnow(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["subscription_id"] = sub_id;

    var res = await http.post(Uri.parse("$mainurl/subscription_details.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        setState(() {
          subname = jsondata["subscription_name"];
          subdes = jsondata["subscription_description"];
          subpr = jsondata["price"];
          subday = jsondata["days"];
          ig = jsondata["image"];

          if (jsondata["rows"] != 0) {
            allsub = jsondata["user_skills"];
          }
          _isLoading = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      print('error');
    }
  }

  Future<void> _showMyDialog(String subscriptionPrice) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                SizedBox(height:40),
                Text('You are upgrading to "Premium"',textAlign: TextAlign.center,style: GoogleFonts.rubik(fontWeight: FontWeight.w400),),
                Text('Would you like to continue?',textAlign: TextAlign.center,style: GoogleFonts.rubik(fontWeight: FontWeight.w400),),
                Text('It will change \$ $subscriptionPrice',textAlign: TextAlign.center,style: GoogleFonts.rubik(fontWeight: FontWeight.w400),),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Continue',style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.green[700]),),
              onPressed: () {
                Navigator.of(context).pop();
                StripeeService().makePayment(
                  context,
                  subpr,callback
                );
              },
            ),
          ],
        );
      },
    );
  }


}
