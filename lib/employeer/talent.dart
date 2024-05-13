import 'package:fac/employeer/bottom.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

String selectedText = '';

class Talent extends StatefulWidget {
  const Talent({super.key});

  @override
  State<Talent> createState() => _TalentState();
}

class _TalentState extends State<Talent> {


  String? name="";
  TextEditingController namecontroller = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Talent Pool",
          style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 30,),

              Text("Which Profile you need?",style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 22),),
              SizedBox(height: 20,),
              Row(
                children: [
                  Text("Role/Position",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17),),
                  Text("*",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 17,color: Colors.red),),

                ],
              ),
              SizedBox(height: 5,),
              TextFormField(
                controller: namecontroller,
                cursorColor: Color(0xFF118743),
                onChanged: (text) {
                  setState(() {
                    name = text;
                  });
                },
                style: GoogleFonts.rubik(),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'This field is required';
                  }
                  return null;
                },
                autovalidateMode: AutovalidateMode.onUserInteraction,
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
                  hintText: "Developer,Hr etc",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.50,),

              Container(
                  width: double.infinity,
                  height: 45,
                  child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Color(0xFF118743),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30))),
                    onPressed: () {
                     setState(() {
                       selectedText=namecontroller.text;
                       print(selectedText);
                     });
                      Navigator.pushNamed(context, "talentpool");

                    },
                    child: Text(
                      "Search",
                      style: GoogleFonts.rubik(
                          color: Colors.white, fontSize: 15),
                    ),
                  )),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

}
