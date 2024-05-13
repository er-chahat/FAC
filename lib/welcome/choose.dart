import 'package:fac/welcome/login.dart';
import 'package:fac/welcome/signupp.dart';
import 'package:fac/welcome/signup.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

var type="";
var sub_id="";
var Findthetype="";


class Choose extends StatefulWidget {
  const Choose({super.key});

  @override
  State<Choose> createState() => _ChooseState();
}

class _ChooseState extends State<Choose> {

  bool isTapped = false;
  bool isTappedd = false;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/bg.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 10, right: 10, top: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Center(child: Image(image: AssetImage("assets/hands.png"))),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Choose Your Job Type",
                  style: GoogleFonts.rubik(
                      fontSize: 27, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  "Choose whether you are looking for a job or you are an organization/company that needs employees.",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.rubik(color: Colors.grey),
                ),
                SizedBox(height: 40),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTapped = true;
                          isTappedd= false;
                        });
                      },
                      child: Container(
                        width:  MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isTapped ? Color(0xFF118743) : Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              SizedBox(height: 20,),
                              Center(child: Image(image: AssetImage(isTapped ? "assets/greenbag.png" : "assets/blackbag.png"))),
                              SizedBox(height: 20,),
                              Text("Job Seeker",style: GoogleFonts.rubik(fontWeight: FontWeight.w400,fontSize: 17),),
                              SizedBox(height: 10,),
                              Text("I am a job seeker.",style: GoogleFonts.rubik(color: Colors.grey),textAlign: TextAlign.center,),
                              SizedBox(height: 20,)
                            ],
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isTappedd = true;
                          isTapped= false;
                        });
                      },
                      child: Container(
                        width:  MediaQuery.of(context).size.width * 0.40,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: isTappedd ? Color(0xFF118743) : Colors.grey,
                            width: 2.0,
                          ),
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(3.4),
                          child: Column(
                            children: [
                              SizedBox(height: 24,),
                              Center(child: Image(image: AssetImage(isTappedd ? "assets/green.png" : "assets/black.png"))),
                              SizedBox(height: 20,),
                              Text("Employer",style: GoogleFonts.rubik(fontWeight: FontWeight.w400,fontSize: 17),textAlign: TextAlign.center,),
                              SizedBox(height: 10),
                              Text("I am an employer.",style: GoogleFonts.rubik(color: Colors.grey),textAlign: TextAlign.center,),
                              SizedBox(height: 24,),

                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(left: 20,right: 20,top: 8,bottom: 8),
                  child: Container(
                      width: double.infinity,
                      height: 45,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Color(0xFF118743),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10))),
                        onPressed: () {
                          if (isTapped) {
                            setState(() {
                              type="User";
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                          } else if (isTappedd) {
                            setState(() {
                              type="Employer";
                            });
                            Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
                          }
                        },
                        child: Text(
                          "Continue",
                          style: GoogleFonts.rubik(
                              color: Colors.white, fontSize: 15),
                        ),
                      )),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}