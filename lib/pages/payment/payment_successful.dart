import 'package:flutter/material.dart';

import '../../utile/constants.dart';

class PaymentSuccessfulScreen extends StatelessWidget {
  const PaymentSuccessfulScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: kPrimaryColor,
        title: Text('إنهاء الدفع'),
      ),
      body: Center(
        child: Container(
          width: 319,
          height: 350,
          color: Colors.white,
          margin: EdgeInsetsDirectional.only(start: 28, end: 28, top: 40),
          child: Column(
            children: [
              Image(
                image: AssetImage('images/success_pay_image.png'),
                height: 98,
                width: 89,
                fit: BoxFit.fill,
                alignment: Alignment.center,
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "تم الدفع بنجاح",
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 22,
                  fontFamily: "Besley-Regular",
                  color: Colors.black,
                ),
              ),
              Text(
                "لقد أرسلنا لك  العمل والإيصال عبر البريد الإلكتروني.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 18,
                  fontFamily: "Besley-Regular",
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/RatingScreen");
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: kPrimaryColor,
                    textStyle: TextStyle(color: Colors.white70),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: Text(
                    "إنهاء!",
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      fontFamily: "Besley-Regular",
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
