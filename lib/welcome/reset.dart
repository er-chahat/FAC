import 'package:fac/API/reseted.dart';
import 'package:fac/welcome/login.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Reset extends StatefulWidget {
  const Reset({super.key});

  @override
  State<Reset> createState() => ResetState();
}

class ResetState extends State<Reset> {
  bool _isObscuree = true;
  bool _isObscur = true;

  String pas = "";
  String pass = "";
  final TextEditingController pascontroller = TextEditingController();
  final TextEditingController passcontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          Navigator.pop(context);
        },
        child: SingleChildScrollView(
          padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * 0.17,),
              StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                "Reset Password",
                                style: GoogleFonts.rubik(
                                    fontSize: 24, fontWeight: FontWeight.w500),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Set the new password for your account so you can login and access all the features.",
                                style: GoogleFonts.rubik(color: Colors.grey),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: TextField(
                                      controller: pascontroller,
                                      obscureText: _isObscuree,
                                      cursorColor: Color(0xFF2c444e),
                                      onChanged: (text) {
                                        setState(() {
                                          pas = text;
                                        });
                                      },
                                      style: GoogleFonts.montserrat(),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Set the border radius
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          // Remove border color
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Set the border radius
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Set the border radius
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscuree
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscuree = !_isObscuree;
                                            });
                                          },
                                        ),
                                        hintText: "Password",
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.symmetric(horizontal: 8),
                                    child: TextField(
                                      controller: passcontroller,
                                      obscureText: _isObscur,
                                      cursorColor: Color(0xFF2c444e),
                                      onChanged: (text) {
                                        setState(() {
                                          pass = text;
                                        });
                                      },
                                      style: GoogleFonts.montserrat(),
                                      decoration: InputDecoration(
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Set the border radius
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          // Remove border color
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Set the border radius
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide:
                                          BorderSide(color: Colors.white),
                                          borderRadius: BorderRadius.circular(
                                              25.0), // Set the border radius
                                        ),
                                        suffixIcon: IconButton(
                                          icon: Icon(
                                            _isObscur
                                                ? Icons.visibility_off_outlined
                                                : Icons.visibility_outlined,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _isObscur = !_isObscur;
                                            });
                                          },
                                        ),
                                        hintText: "Re-enter Password",
                                      ),
                                    ),
                                  ),
                                  if (pas.isNotEmpty &&
                                      pass.isNotEmpty &&
                                      pas != pass)
                                    Padding(
                                      padding: EdgeInsets.symmetric(horizontal: 8),
                                      child: Text(
                                        "Passwords do not match",
                                        style: TextStyle(color: Colors.red),
                                      ),
                                    ),
                                ],
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(15),
                                child: Container(
                                    width: double.infinity,
                                    height: 45,
                                    child: TextButton(
                                      style: TextButton.styleFrom(
                                          backgroundColor: Color(0xFF118743),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(10))),
                                      onPressed: () async {
                                        if (pas.isNotEmpty &&
                                            pass.isNotEmpty &&
                                            pas != pass){
                                          ScaffoldMessenger.of(context).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  "Password Mismatch"),
                                              duration: Duration(seconds: 2),
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius.circular(40)),
                                            ),
                                          );
                                        }else{
                                          await context.read<Reseted>().reseted(
                                              context, passcontroller.text, for_uid);

                                        }

                                      },
                                      child: Consumer<Reseted>(builder:
                                          (context, resetedProvider, child) {
                                        return resetedProvider.isLoading
                                            ? const Center(
                                          child: CircularProgressIndicator(
                                            color: Colors.white,
                                          ),
                                        )
                                            : Text(
                                          "Update Password",
                                          style: GoogleFonts.rubik(
                                              color: Colors.white,
                                              fontSize: 15),
                                        );
                                      }),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// void cont(BuildContext context) {
//     .then((result) {
//       controller1.clear();
//       controller2.clear();
//       controller3.clear();
//       controller4.clear();
//     });
//   }