import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Building extends StatefulWidget {
  const Building({super.key});

  @override
  State<Building> createState() => _BuildingState();
}

class _BuildingState extends State<Building> {
  Color radioColor = Colors.grey;
  String selectedOption = 'No';
  Color radioColorr = Colors.grey;
  String selectedOptionn = 'No';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
          child: Column(
            children: [
              Text(
                "Let’s start building your profile!",
                style: GoogleFonts.rubik(
                    fontSize: 22, fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 15),
              Text(
                "We will help you find the right job opportunities based on the details you enter here",
                style: GoogleFonts.rubik(fontSize: 14),
              ),
              SizedBox(
                height: 40,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage("assets/icom.png")),
                      ),
                      Text(
                        "Begineer",
                        style: GoogleFonts.rubik(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: selectedOption == 'Yes',
                        activeColor: Color(0xFF118743),
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOption = value! ? 'Yes' : 'No';
                            radioColor = selectedOption == 'Yes'
                                ? Color(0xFF118743)
                                : Colors.grey;
                            print(selectedOption);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 20, top: 10, bottom: 10, right: 20),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Image(image: AssetImage("assets/icomm.png")),
                      ),
                      Text(
                        "Intermediate",
                        style: GoogleFonts.rubik(
                            fontSize: 17, fontWeight: FontWeight.w400),
                      ),
                      Spacer(
                        flex: 2,
                      ),
                      Checkbox(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                        value: selectedOptionn == 'Yes',
                        activeColor: Color(0xFF118743),
                        onChanged: (bool? value) {
                          setState(() {
                            selectedOptionn = value! ? 'Yes' : 'No';
                            radioColorr = selectedOptionn == 'Yes'
                                ? Color(0xFF118743)
                                : Colors.grey;
                            print(selectedOptionn);
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                    width: double.infinity,
                    height: 50,
                    child: TextButton(
                      style: TextButton.styleFrom(
                          backgroundColor: Color(0xFF118743),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        if (selectedOptionn == "Yes") {
                          Navigator.pushNamed(context, "education");
                        } else if (selectedOption == "Yes") {
                          Navigator.pushNamed(context, "education");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text("Please Select a field"),
                              duration: Duration(seconds: 2),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                            ),
                          );
                        }
                      },
                      child: Text(
                        "Next",
                        style: GoogleFonts.rubik(
                            color: Colors.white, fontSize: 17),
                      ),
                    )),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
