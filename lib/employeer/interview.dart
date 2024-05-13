import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InterView extends StatefulWidget {
  var inter_data;
  InterView({required this.inter_data});

  @override
  State<InterView> createState() => _InterViewState();
}

class _InterViewState extends State<InterView> {

  @override
  void initState() {
    print("your inter view data is :::::::::::::::::::: \n\n ${widget.inter_data}");
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (widget.inter_data["profile_img"]!= "")
                  ClipRRect(
                    borderRadius: BorderRadius.circular(60),
                    child: CircleAvatar(
                      radius: 20,
                      child: Image(
                        image: NetworkImage("$photo/${widget.inter_data["profile_img"]}"),
                        fit: BoxFit.cover,
                        height: 65,
                        width: 50,
                      ),
                    ),
                  ),
                  if (widget.inter_data["profile_img"]== "")
                    ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: Image(
                          image: AssetImage("assets/person.png"),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                        )),
                  SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: Text("${widget.inter_data["name"]}",
                        style:
                        GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 16)),
                  ),
                ],
              ),
              SizedBox(height: 4),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(""
                          "Date of interview :",style: TextStyle(fontWeight: FontWeight.w700),),
                      SizedBox(width: 20),
                      Expanded(child: Text("${widget.inter_data["schedule_date"]}",softWrap: true,overflow: TextOverflow.ellipsis,))
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            Text("Time :",style: TextStyle(fontWeight: FontWeight.w700),),
                            SizedBox(width: 20),
                            Expanded(child: Text("${widget.inter_data["schedule_time"]} ,",softWrap: true,overflow: TextOverflow.ellipsis,))
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          children: [
                            Text("Status :",style: TextStyle(fontWeight: FontWeight.w700),),
                            SizedBox(width: 20),
                            Expanded(child: Text("${widget.inter_data["status"]}",softWrap: true,overflow: TextOverflow.ellipsis,))
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Text("Mobile :",style: TextStyle(fontWeight: FontWeight.w700),),
                      SizedBox(width: 20),
                      Expanded(child: Text("${widget.inter_data["mobile_number"]}",softWrap: true,overflow: TextOverflow.ellipsis,))
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
