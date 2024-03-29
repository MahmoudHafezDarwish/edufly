import 'package:flutter/material.dart';

import '../../utile/constants.dart';
import '../../utile/size_config.dart';

class DefaultButton extends StatelessWidget {
  final String text;
  final VoidCallback ? press;
  final Color color;

  const DefaultButton({
     Key? key,
    required this.text,
    required this.press,
    this.color = kPrimaryColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: getProportionateScreenHeight(56),
      child: ElevatedButton(
       style: ElevatedButton.styleFrom(
         backgroundColor: color,
         shape: RoundedRectangleBorder(
           borderRadius: BorderRadius.circular(20),
         ),
       ),
        onPressed: press,
        child: Text(
          text,
          style: TextStyle(
            fontSize: getProportionateScreenWidth(18),
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
