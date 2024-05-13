import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                            "Gateway to Bright Future",
                            textAlign: TextAlign.center,
                            style: GoogleFonts.rubik(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Search best of jobs in your areas.",
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
                            "Schedule Interviews",
                            style: GoogleFonts.rubik(
                                fontSize: 28, fontWeight: FontWeight.w500),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Easiest way to interview right candidates.",
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
                            "Resume & Job Management",
                            style: GoogleFonts.rubik(
                                fontSize: 28, fontWeight: FontWeight.w500,),textAlign: TextAlign.center,
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                              "Upload / Create resumes.",
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
