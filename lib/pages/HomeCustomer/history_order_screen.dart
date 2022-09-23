import 'package:Design/custom_widgets/product/products_order_section.dart';
import 'package:Design/pages/data_streams/ordered_products_stream.dart';
import 'package:Design/utile/constants.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/product/products_section.dart';
import '../../custom_widgets/widgets/cart_item_history.dart';
import '../courses/CoursesDetail.dart';

class HistoryOrderScreen extends StatefulWidget {
  const HistoryOrderScreen({Key? key}) : super(key: key);

  @override
  _HistoryOrderScreenState createState() => _HistoryOrderScreenState();
}

class _HistoryOrderScreenState extends State<HistoryOrderScreen> {
  OrderedProductsStream orderedProductsStream = OrderedProductsStream();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    orderedProductsStream.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    orderedProductsStream.dispose();
  }

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
      body: ProductsOrderSection(
        sectionTitle: "أرشيف الطلبات",
        productsStreamController: orderedProductsStream,
        emptyListMessage: "لا يوجد طلبات بعد !!",
        onProductCardTapped: onProductCardTapped,
      ),
      // body: Column(
      //   children: [
      //     Stack(
      //       children: [
      //         Positioned(
      //           right: 30,
      //           top: 20,
      //           left: 30,
      //           bottom: 10,
      //           child: Text(
      //             '3 طلبات',
      //             style: TextStyle(
      //               fontSize: 20,
      //               fontWeight: FontWeight.w500,
      //               fontFamily: fontFamilayTajawal,
      //             ),
      //           ),
      //         ),
      //         Container(
      //           width: double.infinity,
      //           margin: EdgeInsetsDirectional.only(start: 10, end: 10, top: 46),
      //           padding: EdgeInsets.only(right: 10, left: 10, bottom: 13, top: 10),
      //           child: Column(
      //             children: [
      //               CardItemForHistoryCart(
      //                 image: Assets.images.out1.path,
      //                 product_name: 'منهج الصف السادس',
      //               ),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               CardItemForHistoryCart(
      //                 image: Assets.images.out2.path,
      //                 product_name: 'منهج الصف الخامس',
      //               ),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //               CardItemForHistoryCart(
      //                 image: Assets.images.out3.path,
      //                 product_name: 'منهج الصف الرابع',
      //               ),
      //               SizedBox(
      //                 height: 10,
      //               ),
      //             ],
      //           ),
      //         ),
      //       ],
      //     ),
      //   ],
      // ),
    );
  }

  Future<void> refreshPage() {
    orderedProductsStream.reload();
    return Future<void>.value();
  }

  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoursesDetails(productId: productId),
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
