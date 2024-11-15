import 'dart:convert';

import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart'as http;
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class IntroScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _IntroScreen();
  }
}

class _IntroScreen extends State<IntroScreen> {
  PageController _controller = PageController();
  bool onLast = false;
  var dataSc;
  Future _getData() async {
    try {
      print("hello iam   the blogview");
      var url = Uri.parse("$mainurl/splash_screen.php");
      Map<String, dynamic> mapdata = {
        "updte": "1",
      };
      //http.Response response = await http.post(url,body: mapdata);
      http.Response response = await http.post(url, body: jsonEncode(mapdata));
      var data = json.decode(response.body);
      if(response.statusCode ==200){
        print("your Splash Screen Data is ${data}");
        if(data["error"]==0){
          setState(() {
            dataSc=data["deta"];
          });
         return data;
        }else{
          setState(() {
            dataSc=[];
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
          dataSc=[];
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
        dataSc=[];
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
    _getData();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: dataSc==null?CircularProgressIndicator(color: Color(0xFF118743),):Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLast = (index == 2);
              });
            },
            children: [
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Image(image: AssetImage("assets/image.jpg")),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "${dataSc[0]["heading"]}",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "${dataSc[0]["sub_heading"]}",
                              style: GoogleFonts.rubik(
                                  color: Colors.grey, fontSize: 15),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Image(image: AssetImage("assets/imagee.jpg")),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "${dataSc[1]["heading"]}",
                            style: GoogleFonts.rubik(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "${dataSc[1]["sub_heading"]}",
                              style: GoogleFonts.rubik(
                                  color: Colors.grey, fontSize: 15),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/bg.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  children: [
                    Image(image: AssetImage("assets/imageee.jpg")),
                    SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text(
                            "${dataSc[2]["heading"]}",
                            style: GoogleFonts.rubik(
                                fontSize: 28, fontWeight: FontWeight.w500,),textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "${dataSc[2]["sub_heading"]}",
                              style: GoogleFonts.rubik(
                                  color: Colors.grey, fontSize: 15),
                              textAlign: TextAlign.center)
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Container(
                alignment: Alignment(
                  0,
                  0.90,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    SmoothPageIndicator(
                      controller: _controller,
                      count: 3,
                      effect: SwapEffect(
                          spacing: 8.0,
                          radius: 50,
                          dotColor: Colors.grey,
                          activeDotColor: Color(0xFF118743)),
                    ),

                    SizedBox(height: 10),
                    onLast
                        ?  Padding(
                          padding: const EdgeInsets.only(left: 30,right: 30),
                          child: Container(
                          width: double.infinity,
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "choose");
                            },
                            child: Text(
                              "Get Started",
                              style: GoogleFonts.rubik(color: Colors.white),
                            ),
                            style: TextButton.styleFrom(
                                backgroundColor: Color(0xFF118743)),
                          )),
                        )
                        :  Padding(
                      padding: const EdgeInsets.only(left: 30,right: 30),
                      child: Container(
                          width: double.infinity,
                          height: 40,
                          child: TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, "choose");
                            },
                            child: Text(
                              "Skip",
                              style: GoogleFonts.rubik(color: Color(0xFF118743)),
                            ),

                          )),
                    )
                  ],
                )),
          )
        ],
      ),
    );
  }
}
