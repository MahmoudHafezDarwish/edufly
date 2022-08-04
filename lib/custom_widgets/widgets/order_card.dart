import 'package:edufly/provider/AppProvider.dart';
import 'package:edufly/utile/RouterHelper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainOrderCard extends StatelessWidget {
  late final String image;
  late final String category;
  late Color backgroudItem = Color(0xffCEE0FF);

  MainOrderCard(
      {required this.image,
      required this.category,
      required this.backgroudItem});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Provider.of<AppProvider>(context,listen: false).setSelectedCategory(category);
        RouterHelper.routerHelper.pushToSpecificScreenByNameWithoutPop('/StageCourses');
      },
      child: Container(
        width: 260,
        child: Card(
          elevation: 1,
          color: this.backgroudItem,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
            side: BorderSide(
              width: 0,
              color: Color(0xffE8E9EE),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(image),
                height: 93.48,
                width: 93.48,
                fit: BoxFit.fill,
              ),
              Text(
                '${this.category.toUpperCase()}',
                style: TextStyle(
                    fontFamily: 'BesleyBlack',
                    fontWeight: FontWeight.w900,
                    fontSize: 16,
                    color: Colors.black,
                    backgroundColor: Colors.transparent),
              )
            ],
          ),
        ),
      ),
    );
  }
}
