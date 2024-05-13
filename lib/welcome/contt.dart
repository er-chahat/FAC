import 'package:fac/API/vLogin.dart';
import 'package:fac/API/verify_fg.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class Contt extends StatefulWidget {
  final String emailController;
  const Contt({
    Key? key,
    required this.emailController,
  }) : super(key: key);

  @override
  State<Contt> createState() => ConttState();
}

class ConttState extends State<Contt> {
  var otpp = "";
  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();
  final TextEditingController controller5 = TextEditingController();
  final TextEditingController controller6 = TextEditingController();

  final FocusNode focusNode1 = FocusNode();
  final FocusNode focusNode2 = FocusNode();
  final FocusNode focusNode3 = FocusNode();
  final FocusNode focusNode4 = FocusNode();
  final FocusNode focusNode5 = FocusNode();
  final FocusNode focusNode6 = FocusNode();

  final TextEditingController controller7 = TextEditingController();
  final TextEditingController controller8 = TextEditingController();
  final TextEditingController controller9 = TextEditingController();
  final TextEditingController controller10 = TextEditingController();
  final TextEditingController controller11 = TextEditingController();
  final TextEditingController controller12 = TextEditingController();

  final FocusNode focusNode7 = FocusNode();
  final FocusNode focusNode8 = FocusNode();
  final FocusNode focusNode9 = FocusNode();
  final FocusNode focusNode10 = FocusNode();
  final FocusNode focusNode11 = FocusNode();
  final FocusNode focusNode12 = FocusNode();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: StatefulBuilder(
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
                          "Enter 4 Digit Code",
                          style: GoogleFonts.rubik(
                              fontSize: 24, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          "Enter 4 digit code that you have recieved on your email.",
                          style: GoogleFonts.rubik(color: Colors.grey),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: SizedBox(
                                      width: double.infinity,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                7,
                                            child: Card(
                                              color: Color.fromARGB(
                                                  255, 208, 208, 208),
                                              elevation: 0,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 2, 2),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                          focusNode2);
                                                    }
                                                  },
                                                  controller: controller1,
                                                  focusNode: focusNode1,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                7,
                                            child: Card(
                                              color: Color.fromARGB(
                                                  255, 208, 208, 208),
                                              elevation: 0,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 2, 2),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                          focusNode3);
                                                    }
                                                  },
                                                  controller: controller2,
                                                  focusNode: focusNode2,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                7,
                                            child: Card(
                                              color: Color.fromARGB(
                                                  255, 208, 208, 208),
                                              elevation: 0,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 2, 2),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                          focusNode4);
                                                    }
                                                  },
                                                  controller: controller3,
                                                  focusNode: focusNode3,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width /
                                                7,
                                            child: Card(
                                              color: Color.fromARGB(
                                                  255, 208, 208, 208),
                                              elevation: 0,
                                              child: Padding(
                                                padding: EdgeInsets.fromLTRB(
                                                    10, 2, 2, 2),
                                                child: TextFormField(
                                                  onChanged: (value) {
                                                    if (value.length == 1) {
                                                      FocusScope.of(context)
                                                          .requestFocus(
                                                          focusNode5);
                                                    }
                                                  },
                                                  controller: controller4,
                                                  focusNode: focusNode4,
                                                  keyboardType:
                                                  TextInputType.number,
                                                  decoration: InputDecoration(
                                                      border: InputBorder.none),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
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
                                  print(
                                      "${controller1.text}${controller2.text}${controller3.text}${controller4.text}");
                                  otpp =
                                  "${controller1.text}${controller2.text}${controller3.text}${controller4.text}";
                                  print(otpp);
                                  await context.read<Vlogin>().V_login(
                                      context, widget.emailController, otpp);
                                },
                                child: Consumer<Vlogin>(builder:
                                    (context, verifyfgprovider, child) {
                                  return verifyfgprovider.isLoading
                                      ? const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.white,
                                    ),
                                  )
                                      : Text(
                                    "Continue",
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