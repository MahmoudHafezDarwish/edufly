import 'package:edufly/utile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OutBoardingContentScreen extends StatelessWidget {
  late final String title;

  late String subTitle;

  final String image;

  OutBoardingContentScreen({required this.title,required this.subTitle,required this.image});

  @override
  Widget build(BuildContext context) {
    return Column(

      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image(
          alignment: Alignment.topCenter,
          fit: BoxFit.fill,
          image: AssetImage(image),
          height: 260,
          width: 270,
        ),
        SizedBox(height: 50,),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Besley-Bold',
              fontWeight: FontWeight.normal,
              fontSize: 24,
              color: kPrimaryColor,
              backgroundColor: Colors.transparent),
        ),
        SizedBox(height: 10,),

        Text(
          subTitle,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Besley-Regular',
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: kTextLightColor,
              backgroundColor: Colors.transparent),
        ),
      ],
    );
  }
}
