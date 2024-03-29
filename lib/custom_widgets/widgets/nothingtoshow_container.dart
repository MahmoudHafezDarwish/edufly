
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utile/constants.dart';
import '../../utile/size_config.dart';



class NothingToShowContainer extends StatelessWidget {
  final String iconPath;
  final String primaryMessage;
  final String secondaryMessage;

  const NothingToShowContainer({
    required Key key,
    this.iconPath = "images/empty_box.png",
    this.primaryMessage = "لا يوجد بيانات",
    this.secondaryMessage = "",
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: SizeConfig.screenWidth * 0.75,
      height: SizeConfig.screenHeight * 0.2,
      child: Column(
        children: [
          Image.asset(
            iconPath,
            color: kTextColor,
            width: getProportionateScreenWidth(75),
          ),
          SizedBox(height: 16),
          Text(
            "$primaryMessage",
            style: TextStyle(
              color: kTextColor,
              fontSize: 15,
            ),
          ),
          Text(
            "$secondaryMessage",
            style: TextStyle(
              color: kTextColor,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
