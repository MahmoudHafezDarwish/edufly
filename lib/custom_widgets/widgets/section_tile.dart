import 'package:flutter/material.dart';

import '../../utile/size_config.dart';


class SectionTile extends StatelessWidget {
  final String title;
  final GestureTapCallback press;
  const SectionTile({
    Key? key,
    required this.title,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontSize: 22,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
