import 'package:edufly/utile/size_config.dart';
import 'package:flutter/material.dart';

import '../custom_widgets/widgets/LinearGradientText.dart';
import '../utile/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacementNamed(context, "/OutBoardingScreen");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            GradientText(
              ' edufly',
              gradient: kPrimaryGradientColor,
              style: const TextStyle(
                  fontFamily: 'BesleyBlack',
                  fontWeight: FontWeight.w900,
                  letterSpacing: 10,
                  fontSize: 24,
                  color: Colors.black,
                  backgroundColor: Colors.transparent),
            ),

            SizedBox(
              height: 5,
            ),
            // Text(
            //   "E-LEARNING",
            //   style: TextStyle(
            //       fontFamily: 'Lobster-Regular',
            //       fontWeight: FontWeight.w400,
            //       fontSize: 20,
            //       color: Colors.black,
            //       backgroundColor: Colors.transparent),
            // ),
          ],
        ),
      ),
    );
  }
}
