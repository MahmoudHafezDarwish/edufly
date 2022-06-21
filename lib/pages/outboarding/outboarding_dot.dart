import 'package:flutter/material.dart';


class OutBoardingDot extends StatelessWidget {
  final int index;

  final int currentIndex;

  OutBoardingDot({required this.index,required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 37,
      height: 9,
      decoration: BoxDecoration(
        color: index==currentIndex ?Color(0xFF3A58F5):Colors.white,
        shape: BoxShape.rectangle,
          border: Border.all(
            width: 2,
            color: Color(0xff707070)//                   <--- border width here
          ),
        borderRadius: BorderRadius.circular(10)
      ),
    );
  }
}
