import 'package:edufly/gen/assets.gen.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/widgets/cart_item_history.dart';

class HistoryOrderScreen extends StatefulWidget {
  const HistoryOrderScreen({Key? key}) : super(key: key);

  @override
  _HistoryOrderScreenState createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'أرشيف الطلبات',
          style: TextStyle(
            fontFamily: fontFamilayTajawal,

            // fontSize:
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Stack(
            children: [
              Positioned(
                right: 30,
                top: 20,
                left: 30,
                bottom: 10,
                child: Text(
                  '3 طلبات',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                    fontFamily: fontFamilayTajawal,
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                margin: EdgeInsetsDirectional.only(start: 10, end: 10, top: 46),
                padding:
                    EdgeInsets.only(right: 10, left: 10, bottom: 13, top: 10),
                child: Column(
                  children: [
                    CardItemForHistoryCart(
                      image: Assets.images.out1.path,
                      product_name: 'منهج الصف السادس',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CardItemForHistoryCart(
                      image: Assets.images.out2.path,
                      product_name: 'منهج الصف الخامس',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CardItemForHistoryCart(
                      image: Assets.images.out3.path,
                      product_name: 'منهج الصف الرابع',
                    ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
                // child: GridView(
                //   scrollDirection: Axis.vertical,
                //   padding: EdgeInsets.all(5),
                //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //       crossAxisCount: 1,
                //       crossAxisSpacing: 10,
                //       mainAxisSpacing: 10),
                //   children: [
                //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                //     CardItemForCart(image: 'images/bag_black.png',product_name: 'HAND BAG',),
                //
                //   ],
                // ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
