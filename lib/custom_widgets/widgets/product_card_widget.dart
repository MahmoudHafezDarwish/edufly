import 'package:edufly/data/firebase_firestore.dart';
import 'package:edufly/models/modelsFirebase/my_product.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../utile/constants.dart';

class ProductCard extends StatelessWidget {
  final String? order_name;
  final String? order_price;
  final bool? add_to_cart;
  final String? image;
  final String productId;
  final GestureTapCallback press;

  ProductCard(
      {this.order_name,
      this.order_price,
      this.add_to_cart,
      this.image,
      required this.productId,
      required this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: FutureBuilder<MyProduct>(
          future: MyFirebaseFireStore.myFirebaseFireStore
              .getProductWithID(productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final MyProduct product = snapshot.data!;
              return buildProductCardItems(product);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              final error = snapshot.error.toString();
              Logger().e(error);
            }
            return Center(
              child: Icon(
                Icons.error,
                color: kTextColor,
                size: 60,
              ),
            );
          },
        ),
      ),
    );
  }

  Stack buildProductCardItems(MyProduct product) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: 340,
          clipBehavior: Clip.antiAlias,
          margin: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 7,
                  color: Colors.grey,
                  offset: Offset(0, 3),
                ),
              ]),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(product.image_url!),
                height: 200,
                width: double.infinity,
                fit: BoxFit.fill,

              ),
              SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  Text(product.name ?? 'titile',
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 14,
                        fontFamily: "Besley-Regular",
                        color: kPrimaryColor,
                      )),
                  Spacer(),
                  Text('${product.numberOfCourse} درس' ?? '!!!',
                      style:const TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        fontFamily: "Besley-Regular",
                        color: kSecondaryColor,
                      )),
                ],
              ),
              Text(
                product.description ?? '!!!',
                style: const TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  fontFamily: "Besley-Regular",
                  color: Colors.grey,
                ),
                textAlign: TextAlign.start,
                overflow: TextOverflow.ellipsis,


              ),
            ],
          ),
        ),
      ],
    );
  }
}
