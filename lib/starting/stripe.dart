import 'dart:async';
import 'dart:collection';
import 'dart:convert';

import 'package:fac/employeer/emphome.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:fac/welcome/choose.dart';
import 'package:fac/welcome/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

class StripeService {
  payFee(BuildContext context, txId,final Function(String) callback) async {
    try {
      paymentIntentData = null;

      print("done ");
      print(txId);
      print("done ");

      HashMap<String, String> map = HashMap();
      map["updte"] = "1";
      map["payment_status"] = "Successfully";
      map["transaction_id"]=txId.toString();
      map["subscription_id"]=sub_id.toString();
      map["user_id"]=user_id.toString();

      var res = await http.post(
          Uri.parse("$mainurl/employer_subscribe.php"),
          body: jsonEncode(map));
      print(res.body);
      dynamic jsondata = jsonDecode(res.body);
      print("i am here sucess $map");
      print(jsondata);

      if (res.statusCode == 200) {
        print("asdfghjkl;dfghjkdfghjkdfghjkdfghjkdfghjk");
        print(jsondata);
        membertype=="Paid";
        showDialog<void>(
          context: context,
          barrierDismissible: false, // user must tap button!
          builder: (BuildContext context) {
            return AlertDialog(
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    SizedBox(height:40),
                    Text('Sucessfully upgraded to "Premium"',textAlign: TextAlign.center,style: GoogleFonts.rubik(fontWeight: FontWeight.w400),),
                    Text('Enjoy Premium Features!',textAlign: TextAlign.center,style: GoogleFonts.rubik(fontWeight: FontWeight.w400),),
                  ],
                ),
              ),
              actions: <Widget>[
                // TextButton(
                //   child: Text('Continue',style: GoogleFonts.rubik(fontWeight: FontWeight.w500,fontSize: 20,color: Colors.green[700]),),
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                // ),
              ],
            );
          },
        );
        Timer(Duration(seconds: 2), () {
          Navigator.of(context).pop();
          callback("");
          Navigator.pop(context);
          //Navigator.of(context).popUntil((route) => route.settings.name == "drawer");
        //  Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Emphome()), (route) => false);
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something Went wrong"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } catch (e,stackTrace) {
      print("Error: $e");
      print("Stack Trace: $stackTrace");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Failed $e"),
          duration: Duration(seconds: 2 ),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        ),
      );
    }
  }

  Map<String, dynamic>? paymentIntentData;
  displayPaymentSheet(BuildContext context,final Function(String) callback) async {
    try {
      await Stripe.instance.presentPaymentSheet().then((newValue) {
        final transactionId = paymentIntentData?['id'] ?? "";
        payFee(context, transactionId,callback);
        paymentIntentData = null;
      }).onError((error, stackTrace) {
        if (kDebugMode) {
          print('Exception/DISPLAYPAYMENTSHEET==> $error $stackTrace');
        }
      });
    } on StripeException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    } catch (e) {
      if (kDebugMode) {
        print('$e');
      }
    }
  }

  String calculateAmount(double amount) {
    final intAmount = (amount * 100).round();
    return intAmount.toString();
  }

  createPaymentIntent(String amount, String currency, context) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(double.parse(amount)),
        'currency': currency,
        'payment_method_types[]': 'card'
      };

      var header = {
        'Authorization':
        'Bearer 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',
        'Content-Type': 'application/x-www-form-urlencoded'
      };

      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: header);

      return jsonDecode(response.body);
    } catch (err) {
      debugPrint('err charging user: ${err.toString()}');
    }
  }

  Future<void> makePayment(BuildContext context, String amount,final Function(String) callback) async {
    //Stripe takes only integer value

    try {
      paymentIntentData = await createPaymentIntent(amount, 'USD', context);

      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            customFlow: false,
            paymentIntentClientSecret: paymentIntentData?['client_secret'],
            style: ThemeMode.dark,
            merchantDisplayName: "FAC App"),
      )
          .then((value) async {});

      ///now finally display payment sheeet
      displayPaymentSheet(context,callback);
    } catch (e, s) {
      debugPrint('exception:$e$s');
    }
  }
}