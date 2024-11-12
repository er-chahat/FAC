import 'package:fac/API/forgottenPass.dart';
import 'package:fac/API/loginAPI.dart';
import 'package:fac/API/reseted.dart';
import 'package:fac/API/vLogin.dart';
import 'package:fac/API/verify_fg.dart';
import 'package:fac/employeer/active.dart';
import 'package:fac/employeer/analysis.dart';
import 'package:fac/employeer/applicants.dart';
import 'package:fac/employeer/application.dart';
import 'package:fac/employeer/cp.dart';
import 'package:fac/employeer/drawer.dart';
import 'package:fac/employeer/emphome.dart';
import 'package:fac/employeer/empnotification.dart';
import 'package:fac/employeer/empss.dart';
import 'package:fac/employeer/faq.dart';
import 'package:fac/employeer/inactive.dart';
import 'package:fac/employeer/message.dart';
import 'package:fac/employeer/messages.dart';
import 'package:fac/employeer/notification.dart';
import 'package:fac/employeer/portfolio.dart';
import 'package:fac/employeer/pp.dart';
import 'package:fac/employeer/profile.dart';
import 'package:fac/employeer/ratingss.dart';
import 'package:fac/employeer/requirements.dart';
import 'package:fac/employeer/seeresume.dart';
import 'package:fac/employeer/seereviewsemp.dart';
import 'package:fac/employeer/single.dart';
import 'package:fac/employeer/subscription.dart';
import 'package:fac/employeer/subsub.dart';
import 'package:fac/employeer/talent.dart';
import 'package:fac/employeer/talentpool.dart';
import 'package:fac/employeer/tnc.dart';
import 'package:fac/employeer/vacancyjob.dart';
import 'package:fac/employeer/viewallemp.dart';
import 'package:fac/home/advance.dart';
import 'package:fac/home/alljobs.dart';
import 'package:fac/home/allnotifications.dart';
import 'package:fac/home/applied.dart';
import 'package:fac/home/de.dart';
import 'package:fac/home/drawres.dart';
import 'package:fac/home/edit.dart';
import 'package:fac/home/hereweare.dart';
import 'package:fac/home/job.dart';
import 'package:fac/home/jobapply.dart';
import 'package:fac/home/mainprofile.dart';
import 'package:fac/home/ohhhere.dart';
import 'package:fac/home/ratingsinuser.dart';
import 'package:fac/home/recjob.dart';
import 'package:fac/home/seereviewsuser.dart';
import 'package:fac/home/subb.dart';
import 'package:fac/home/success.dart';
import 'package:fac/home/userdrwa.dart';
import 'package:fac/home/usermain.dart';
import 'package:fac/home/usermsg.dart';
import 'package:fac/home/usersubsub.dart';
import 'package:fac/home/wel.dart';
import 'package:fac/notificationservice/local_notification_service.dart';
import 'package:fac/starting/cardd.dart';
import 'package:fac/starting/carddd.dart';
import 'package:fac/starting/searchrec.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/about.dart';
import 'package:fac/welcome/adsearched.dart';
import 'package:fac/welcome/building.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/education.dart';
import 'package:fac/welcome/keyskills.dart';
import 'package:fac/welcome/login.dart';
import 'package:fac/welcome/port.dart';
import 'package:fac/welcome/rnp.dart';
import 'package:fac/welcome/signup.dart';
import 'package:fac/welcome/signupp.dart';
import 'package:fac/welcome/social.dart';
import 'package:fac/welcome/yourwork.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'API/firebase_api.dart';


var token="";

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();
  //await FirebaseApi().initNotifications();
  Stripe.publishableKey = 'pk_live_51OWG8sAGSiZ99v5pu7A4WH6zakJ09HUxk6hDV5titE8VeXmWhJWNzueS1TRbb9YKOxke9FV6eDd7kRnyV0x5QvEw00s8RvVEke';
 // FirebaseMessaging.onBackgroundMessage(backgroundHandler);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LoginAPI(),
        ),
        ChangeNotifierProvider(
          create: (context) => Reseted(),
        ),
        ChangeNotifierProvider(
          create: (context) => VerifyFg(),
        ),
        ChangeNotifierProvider(
          create: (context) => Vlogin(),
        ),
        ChangeNotifierProvider(
          create: (context) => Forgot(),
        ),
      ],
      child: MyApp(),
    ),
  );
}


Future<void> backgroundHandler(RemoteMessage message) async {

  print(RemoteMessage);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  await sharedPreferences.setString(
    "notification",
    message.toMap().toString(),
  );
  print("m from bz");
  print("Message data: ${message.data}");
  print("Notification title: ${message.notification?.title}");

  // FlutterRingtonePlayer.play(
  //   android: AndroidSound(2), ios: IosSounds.glass,volume: 7);
   //LocalNotificationService.display(message);

}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(textTheme: GoogleFonts.montserratTextTheme()),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      routes: {
        "login":(context)=> Login(),
        "signup":(context)=>Signup(),
        "wel":(context)=>Wel(),
        //"social":(context)=>Social(),
        "choose":(context)=>Choose(),
        "signupp":(context)=>Signupp(),
        "building":(context)=>Building(),
        // "education":(context)=>Education(),
        // "keyskills":(context)=>Keyskills(),
        "work":(context)=>YourWork(),
       // "about":(context)=>About(),
        // "rnp":(context)=>Rnp(),
        "mp":(context)=>Mainprofile(),
        // "port":(context)=>Port(),
        "job":(context)=>Job(),
        "edit":(context)=>EditPro(),
        "app":(context)=>Applied(),
        // "de":(context)=>De(),
        "ud":(context)=>Userdrwa(),
        "rjj":(context)=>Recjob(),
        "semp":(context)=>Empss(),
        "alljobs":(context)=>Alljobs(),
       // "portfolio":(context)=>Portfolio(),
        "single":(context)=>Single(),
        "allnotifications":(context)=>AllNotifications(),
        "empnotification":(context)=>EmpNotification(),
        "allnotemp":(context)=> ViewAllEmp(),
        "ratingss":(context)=>Ratingss(),
        "ratingsinuser":(context)=>RatingInUser(),
        "sru":(context)=>SeeReviewUser(),
        "sre":(context)=>SeeReviewsEmp(),
        "emphome":(context)=>Emphome(),
        "msg":(context)=> Messages(),
        "msgg":(context)=>Message(),
        "application":(context)=>Application(),
        "active":(context)=>Active(),
        "in":(context)=>Inactive(),
        "vj":(context)=>Vacancyjob(),
        "req":(context)=>Requirements(),
        "sr":(context)=>Seeresume(),
        "applicants":(context)=>Applicants(),
        "drawer":(context)=>Last(),
        "profile":(context)=>Profile(),
        "tp":(context)=>Talent(),
        "ana":(context)=>Analysis(),
        "tnc":(context)=>Tnc(),
        "pp":(context)=>Privacy(),
        "cp":(context)=>Cp(),
        "faq":(context)=>Faq(),
        "talentpool":(context)=>Talentpool(),
        "notification":(context)=> Not(),
        // "subscription":(context)=>Subscription(),
        //"subsub":(context)=>Subsub(),
        "ja":(context)=>Jobapply(),
        "suc":(context)=>Success(),
        "cardd":(context)=>Cardd(),
        // "usersubs":(context)=>Subb(),
        //"uss":(context)=>Usersubsub(),
        "cdd":(context)=>Carddd(),
        "searched":(context)=>Searchrec(),
        "usermsg":(context)=>Usermsg(),
        "usermain":(context)=>Usermain(),
        "drawres":(context)=>Drawres(),
        "hwr":(context)=>hereweare(),
        "advance":(context)=>Advance(),
        //"asd":(context)=>Adsearched(),
        "ohhhere":(context)=>OhhHere(),

      },);
  }
}


//
// import 'dart:convert';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
//
// void main() {
//   runApp(const MyApp());
// }
//
// String prettyPrint(Map json) {
//   JsonEncoder encoder = const JsonEncoder.withIndent('  ');
//   String pretty = encoder.convert(json);
//   return pretty;
// }
//
// class MyApp extends StatefulWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   Map<String, dynamic>? _userData;
//   AccessToken? _accessToken;
//   bool _checking = true;
//
//   @override
//   void initState() {
//     super.initState();
//     _checkIfIsLogged();
//   }
//
//   Future<void> _checkIfIsLogged() async {
//     final accessToken = await FacebookAuth.instance.accessToken;
//     setState(() {
//       _checking = false;
//     });
//     if (accessToken != null) {
//       print("is Logged:::: ${prettyPrint(accessToken.toJson())}");
//       // now you can call to  FacebookAuth.instance.getUserData();
//       final userData = await FacebookAuth.instance.getUserData();
//       // final userData = await FacebookAuth.instance.getUserData(fields: "email,birthday,friends,gender,link");
//       _accessToken = accessToken;
//       setState(() {
//         _userData = userData;
//         _printCredentials();
//       });
//     }
//   }
//
//   Future<void> _login() async {
//     final LoginResult result = await FacebookAuth.instance.login(permissions: ['email', 'public_profile']);
//
//     if (result.status == LoginStatus.success) {
//       _accessToken = result.accessToken;
//       try {
//         final userData = await FacebookAuth.instance.getUserData(fields: "name,email");
//         _userData = userData;
//       } catch (e) {
//         print("Error fetching user data: $e");
//       }
//     } else {
//       print(result.status);
//       print(result.message);
//     }
//     _checkIfIsLogged();
//     setState(() {
//       _checking = false;
//     });
//   }
//
//
//   void _printCredentials() {
//     print("harleen---->");
//     print(_userData);
//     print("Access Token:");
//     print(prettyPrint(_accessToken!.toJson()));
//     print(_userData);
//     if (_userData != null) {
//       print("User Data:");
//       print("Name: ${_userData!['name']}");
//       print("Email: ${_userData!['email']}");
//       print(prettyPrint(_userData!));
//     }
//   }
//
//
//   Future<void> _logOut() async {
//     print("Logging out...");
//     await FacebookAuth.instance.logOut();
//     _accessToken = null;
//     _userData = null;
//     setState(() {});
//     print("Logged out successfully.");
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Facebook Auth Example'),
//         ),
//         body: _checking
//             ? const Center(
//           child: CircularProgressIndicator(),
//         )
//             : SingleChildScrollView(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   _userData != null ? prettyPrint(_userData!) : "NO LOGGED",
//                 ),
//                 const SizedBox(height: 20),
//                 _accessToken != null
//                     ? Text(
//                   prettyPrint(_accessToken!.toJson()),
//                 )
//                     : Container(),
//                 const SizedBox(height: 20),
//                 CupertinoButton(
//                   color: Colors.blue,
//                   child: Text(
//                     _userData != null ? "LOGOUT" : "LOGIN",
//                     style: const TextStyle(color: Colors.white),
//                   ),
//                   onPressed: _userData != null ? _logOut : _login,
//                 ),
//                 const SizedBox(height: 50),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
