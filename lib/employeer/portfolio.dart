import 'package:fac/home/wel.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/port.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Portfolio extends StatefulWidget {
  var por_data;
  final Function(String) callback;
  Portfolio({required this.por_data,required this.callback});

  @override
  State<Portfolio> createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  void callback(String st){
    setState(() {
      widget.callback("");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Portfolio Details",
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
            children: [
              Container(
                height: MediaQuery.of(context).size.width/1.8,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(8.0),topRight: Radius.circular(8.0)),
                        child: Image.network(
                          "$photo/${widget.por_data["portfolio_image"]}",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(8.0),bottomRight: Radius.circular(8.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 2,
                      blurRadius: 2,
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                     Row(
                       children: [
                         Expanded(
                           child: Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("Title:",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 12),textAlign: TextAlign.start,),
                               Text(pt,style: GoogleFonts.rubik(fontWeight: FontWeight.w600,fontSize: 22),textAlign: TextAlign.center),
                             ],
                           ),
                         ),
                         InkWell(
                           onTap: (){
                             Navigator.push(context, MaterialPageRoute(builder: (context)=>Port(callback: callback,isEdit:true,port_id:"${widget.por_data["portfolio_id"]}")));
                           },
                           child: Container(
                             decoration: BoxDecoration(
                               borderRadius: BorderRadius.circular(8),
                               color: Colors.green
                             ),
                             child: Padding(
                               padding: const EdgeInsets.only(left: 18.0,right: 18,top: 8,bottom: 8),
                               child: Text("Edit",style: TextStyle(fontWeight: FontWeight.w400,fontSize: 16,color: Colors.white),),
                             ),
                           ),
                         )
                       ],
                     ),
                      SizedBox(height: 20,),
                      Text("Description:",style: GoogleFonts.rubik(color: Colors.grey,fontSize: 12),),
                      Text(pd,style: GoogleFonts.rubik(fontSize: 20),)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      )
    );
  }
}
