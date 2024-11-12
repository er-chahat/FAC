import 'dart:async';
import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/bottom.dart';
import 'package:fac/home/usermsg.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/starting/stripe.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:fac/employeer/subscription.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';

class Subsub extends StatefulWidget {
  final Function(String) callback;
  Subsub({required this.callback});

  @override
  State<Subsub> createState() => _SubsubState();
}

class _SubsubState extends State<Subsub> {
  Map<String, dynamic>? paymentIntent;


  bool _isLoading = true;
  List<dynamic> allsub = [];


  var subname = "";
  var subdes = "";
  var subpr = "";
  var subday = "";
  var ig = "";

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
    map["subscription_id"]="5";
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
                child: Text('Continue',style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xFF118743)),),
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
              widget.callback;
            });
            Navigator.pop(context);
          },
        ),
      ),
      body:
      _isLoading
          ? Center(
        child: CircularProgressIndicator(color: Color(0xFF118743),),
      )
          :SingleChildScrollView(
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
                          fontSize: 22, fontWeight: FontWeight.w500),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if(subpr=="Free")
                          Text(subpr,style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,),),
                        if(subpr!="Free")
                          Text("\$$subpr",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20),),
                        Text("/$subday Days",style: GoogleFonts.rubik(color: Color(0xFF118743),fontSize: 10),)
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
                              color: Color(0xFF118743),
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
                    //           //_showMyDialog(subpr);
                    //           StripeService().makePayment(
                    //             context,
                    //             subpr,callback
                    //           );
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
                            backgroundColor: Color(0xFF118743),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          onPressed: () {
                            setState(() {
                              _freeala(context);
                            });
                          },
                          child: Text(
                            "Cancel Subscription",
                            style: GoogleFonts.baloo2(color: Colors.white,fontSize: 17),
                          ),
                        ),
                      ),
                    if(current_subscription!=sub_id)
                      SizedBox(
                        height: 10,
                      ),
                    if(current_subscription!=sub_id )
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
                              setState(() {
                                StripeService().makePayment(
                                    context,
                                    subpr,callback
                                );
                                Timer(Duration(seconds: 3), () {
                                  setState(() {
                                    callback("s");
                                  });
                                  //Navigator.of(context).popUntil((route) => route.settings.name == "drawer");
                                  //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Emphome()), (route) => false);
                                });
                              });

                            }
                          },
                          child: Text(
                            userdes_em,
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
      bottomNavigationBar: Bottom(),
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
  paynow(context) async {
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["subscription_id"] = sub_id;
    map["user_id"] = user_id;
    map["payment_status"] = "Successfully";


    var res = await http.post(Uri.parse("$mainurl/employer_subscribe.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                  height: 100,
                  width: 50,
                  child: Center(
                      child: Column(
                        children: [
                          Image(image: AssetImage("assets/check.png")),
                          SizedBox(height: 10,),
                          Text(
                            "Succesfull",
                            style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 17),
                          ),
                        ],
                      ))),
            ));
        Future.delayed(Duration(seconds: 1),(){
          Navigator.pushNamed(context, "emphome");
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
              child: Text('Continue',style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,color: Color(0xFF118743)),),
              onPressed: () {
                Navigator.of(context).pop();
                StripeService().makePayment(
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
