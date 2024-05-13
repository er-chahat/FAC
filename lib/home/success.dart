import 'package:fac/home/job.dart';
import 'package:fac/home/mainprofile.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Success extends StatefulWidget {
  const Success({super.key});

  @override
  State<Success> createState() => _SuccessState();
}

class _SuccessState extends State<Success> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFfafafd),
     body: SingleChildScrollView(
       child: Padding(
         padding: const EdgeInsets.all(15.0),
         child: Column(
           children: [
             SizedBox( height: MediaQuery.of(context).size.height * 0.19),
             Center(child: Image(image: AssetImage("assets/Done.png"))),
             Text("Successful",style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 22),),
             SizedBox(height: 10,),
             Text("You’ve successfully applied to ""$op"" role.",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 17),textAlign: TextAlign.center,)
           ],
         ),
       ),
     ),
      bottomNavigationBar:  Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          height: 50,
          width: double.infinity,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[700],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
            ),
            onPressed: () {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Mainprofile(),), (route) => false);
            },
            child: Text(
              "Back To Home",
              style: GoogleFonts.baloo2(color: Colors.white,fontSize: 17),
            ),
          ),
        ),
      ),
    );
  }
}
