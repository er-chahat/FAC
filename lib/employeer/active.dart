import 'dart:collection';
import 'dart:convert';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/home/wel.dart';
import 'package:http/http.dart'as http;
import 'package:fac/employeer/bottom.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class Active extends StatefulWidget {
  const Active({super.key});

  @override
  State<Active> createState() => _ActiveState();
}

class _ActiveState extends State<Active> {


  @override
  void initState() {
    super.initState();
    activevacancies(context);
  }

  List<dynamic> vacancies = [];
  bool _isLoading = true;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Active",style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
        ),
        leading: GestureDetector(
          child: Icon( Icons.arrow_back_ios, color: Colors.black,  ),
          onTap: () {
            Navigator.pop(context);
          } ,
        ) ,
      ),
      body:  _isLoading
          ? Center(
        child: CircularProgressIndicator(color: Colors.green[700],),
      )
          :SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              if(vacancies.isNotEmpty)
                for (var vacancy in vacancies)
                  vacancyContainer(vacancy,context),
              if(vacancies.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Container(
                    width: double.infinity,
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
                      padding: const EdgeInsets.all(15.0),
                      child: Text(
                        "No Jobs Yet",
                        style: GoogleFonts.rubik(
                            fontWeight: FontWeight.w500,
                            color: Colors.grey,
                            fontSize: 17),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),

              SizedBox(height: 20,),

            ],
          ),
        ),
      ),
      bottomNavigationBar: Bottom(),
    );
  }

  activevacancies(context) async{
    HashMap<String, String> map = HashMap();
    map["updte"] = "1";
    map["user_id"]= user_id;


    var res = await http.post(Uri.parse("$mainurl/active_vacancies.php"),
        body: jsonEncode(map));
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);


    if (res.statusCode == 200) {
      if(jsondata["error"]==0) {

        setState(() {
          if(jsondata["error_msg"]=="Employer Job Vacancy know Get"){
            vacancies=[];
          }else{
          vacancies = jsondata["user_skills"];}
          _isLoading=false;
        });

      }else{
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong"),
            duration: Duration(seconds: 2 ),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      print('error');
    }

  }

  Widget vacancyContainer(dynamic vacancy,BuildContext context) {
    bool isActive = vacancy["is_active"] == "1";

    return GestureDetector(
      onTap: (){
        print(":::::::::::::::::::::::::::::::::::::::::::::::::::: ${vacancy["jop_vacancy_id"]}");
        app_id=vacancy["jop_vacancy_id"];

        Navigator.pushNamed(context, "vj");

      },
      child: Container(
        margin: EdgeInsets.only(bottom: 16.0),
        width: double.infinity,
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
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Image(
                  image: NetworkImage("$photo/${vacancy["jop_image"]}"),
                  errorBuilder: (BuildContext context, Object error, StackTrace? stackTrace) {
                    return Container(
                      height: 55,
                      width: 50,
                      decoration: BoxDecoration(
                        color: Colors.grey[200], // Placeholder background color
                        borderRadius: BorderRadius.circular(8), // Adjust as needed
                      ),
                      child: Icon(
                        Icons.photo_library, // Placeholder icon, you can use any icon or asset
                        size: 30,
                        color: Colors.grey[400],
                      ),
                    );
                  },
                  height: 65,
                  width: 50,
                ),
              ),
              SizedBox(width: 15),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    vacancy["open_position"],
                    style: GoogleFonts.rubik(fontWeight: FontWeight.w500),
                  ),
                  SizedBox(height: 2),
                  Text(
                    vacancy["location"],
                    style: GoogleFonts.rubik(),
                  ),
                  Text(
                    "${vacancy["type"]}",
                    style: GoogleFonts.rubik(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                  Text(
                    "${vacancy["salary"]=="/null"?"Not given":vacancy["salary"]}",
                    style: GoogleFonts.rubik(
                      color: Colors.grey,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
              Spacer(flex: 2),
              Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: isActive ? Color(0xFFEDF9F0) : Color(0xFFF9EDED),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        isActive ? "Active" : "Inactive",
                        style: GoogleFonts.rubik(color: isActive ? Color(0xFF00C152) : Color(0xFFC10000)),
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Container(
                      width: MediaQuery.of(context).size.width * 0.22,
                      height: 35,
                      child: TextButton(
                        style: TextButton.styleFrom(
                            backgroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                              side: BorderSide(color: Color(0xFF118743)),
                            )),
                        onPressed: () {
                          setState(() {
                            app_id = vacancy["jop_vacancy_id"];
                          });
                          Navigator.pushNamed(context, "single");
                        },
                        child: Text(
                          "Applicants",
                          style: GoogleFonts.rubik(
                              color: Color(0xFF118743), fontSize: 12),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

}


