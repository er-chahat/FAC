import 'dart:collection';
import 'dart:convert';
import 'package:fac/welcome/choose.dart';
import 'package:http/http.dart'as http;
import 'package:fac/employeer/subscription.dart';
import 'package:fac/starting/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:google_fonts/google_fonts.dart';
class Cardd extends StatefulWidget {
  const Cardd({super.key});

  @override
  State<Cardd> createState() => _CarddState();
}

class _CarddState extends State<Cardd> {
  bool isLightTheme = false;
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  bool useGlassMorphism = false;
  bool useBackgroundImage = false;
  bool useFloatingAnimation = true;
  final OutlineInputBorder border = OutlineInputBorder(
    borderSide: BorderSide(
      color: Colors.grey.withOpacity(0.7),
      width: 2.0,
    ),
  );
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      isLightTheme ? SystemUiOverlayStyle.dark : SystemUiOverlayStyle.light,
    );
    return MaterialApp(
      title: '',
      debugShowCheckedModeBanner: false,
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,

      home: Scaffold(
        resizeToAvoidBottomInset: false,
        appBar:  AppBar(
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back_ios),
          ),
          centerTitle: true,
          title: Text("Card Details", style: GoogleFonts.rubik()),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: ExactAssetImage(
                    isLightTheme ? 'assets/back.png' : 'assets/back.png',
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              child: SafeArea(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[

                    SizedBox(height: 30,),

                    CreditCardWidget(
                      enableFloatingCard: useFloatingAnimation,
                      cardNumber: cardNumber,
                      expiryDate: expiryDate,
                      cardHolderName: cardHolderName,
                      cvvCode: cvvCode,
                      bankName: 'Visa',
                      frontCardBorder: useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      backCardBorder: useGlassMorphism
                          ? null
                          : Border.all(color: Colors.grey),
                      showBackView: isCvvFocused,
                      obscureCardNumber: true,
                      obscureCardCvv: true,
                      isHolderNameVisible: true,
                      cardBgColor: isLightTheme
                          ? Colors.blueAccent
                          : Colors.lightBlue,
                      backgroundImage:
                      useBackgroundImage ? 'assets/back.png' : null,
                      isSwipeGestureEnabled: true,
                      onCreditCardWidgetChange:
                          (CreditCardBrand creditCardBrand) {},
                      customCardTypeIcons: <CustomCardTypeIcon>[
                        CustomCardTypeIcon(
                          cardType: CardType.mastercard,
                          cardImage: Image.asset(
                            'assets/mastercard.png',
                            height: 48,
                            width: 48,
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: <Widget>[
                            CreditCardForm(
                              formKey: formKey,
                              obscureCvv: true,
                              obscureNumber: true,
                              cardNumber: cardNumber,
                              cvvCode: cvvCode,
                              isHolderNameVisible: true,
                              isCardNumberVisible: true,
                              isExpiryDateVisible: true,
                              cardHolderName: cardHolderName,
                              expiryDate: expiryDate,
                              inputConfiguration: const InputConfiguration(
                                cardNumberDecoration: InputDecoration(
                                  labelText: 'Number',
                                  hintText: 'XXXX XXXX XXXX XXXX',
                                ),
                                expiryDateDecoration: InputDecoration(
                                  labelText: 'Expired Date',
                                  hintText: 'XX/XX',
                                ),
                                cvvCodeDecoration: InputDecoration(
                                  labelText: 'CVV',
                                  hintText: 'XXX',
                                ),
                                cardHolderDecoration: InputDecoration(
                                  labelText: 'Card Holder',
                                ),
                              ),
                              onCreditCardModelChange: onCreditCardModelChange,
                            ),

                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
        bottomNavigationBar:  Padding(
          padding: const EdgeInsets.all(8.0),
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
                paynow(context);
              },
              child: Text(
                "Buy Now",
                style: GoogleFonts.baloo2(color: Colors.white,fontSize: 17),
              ),
            ),
          ),
        ),
      ),
    );
  }


  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode.length <= 3
          ? creditCardModel.cvvCode
          : creditCardModel.cvvCode.substring(0, 3);
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  paynow(context) async {
    HashMap<String, String> map = HashMap();
    String cleanCardNumber = cardNumber.replaceAll(' ', '');
    map["updte"] = "1";
    map["subscription_id"] = sub_id;
    map["user_id"] = user_id;
    map["payment_status"] = "Successfully";
    map["card_number"]=cleanCardNumber.toString();
    map["month_year"]=expiryDate.toString();
    map["cvv"]=cvvCode.toString();
    


    var res = await http.post(Uri.parse("$mainurl/employer_subscribe.php"),
        body: jsonEncode(map));
    print(map);
    print(res.body);
    dynamic jsondata = jsonDecode(res.body);
    print("Mapped::::::$map");
    print(jsondata);

    if (res.statusCode == 200) {
      if (jsondata["error"] == 0) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.white,
              content: Container(
                  height: 100,
                  width: 50,
                  child: Center(
                      child: Column(
                        children: [
                          Image(image: AssetImage("assets/check.png")),
                          SizedBox(height: 10,),
                          Text(
                            "Succesfull",
                            style: GoogleFonts.rubik(fontWeight: FontWeight.bold,fontSize: 17),
                          ),
                        ],
                      ))),
            ));
        Future.delayed(Duration(seconds: 1),(){
          Navigator.pushNamed(context, "emphome");
        });

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Something went wrong, Check Details"),
            duration: Duration(seconds: 2),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
          ),
        );
      }
    } else {
      print('error');
    }
  }

}
