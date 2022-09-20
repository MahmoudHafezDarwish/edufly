import 'package:edufly/data/firebase_firestore.dart';
import 'package:edufly/models/modelsFirebase/my_product.dart';
import 'package:edufly/utile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../utile/constants.dart';

const _kMaxShortTextLength = 100;

class ProductCard extends StatefulWidget {
  final String? order_name;
  final String? order_price;
  final bool? add_to_cart;
  final String? image;
  final String productId;
  final GestureTapCallback press;

  ProductCard(
      {this.order_name, this.order_price, this.add_to_cart, this.image, required this.productId, required this.press});

  @override
  State<ProductCard> createState() => _ProductCardState();
}

class _ProductCardState extends State<ProductCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print('product widget.productId  ${widget.productId} ');

    return GestureDetector(
      onTap: widget.press,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        child: FutureBuilder<MyProduct>(
          future: MyFirebaseFireStore.myFirebaseFireStore.getProductWithID(widget.productId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final MyProduct product = snapshot.data!;
              print(
                  'product name ${product.name} product img ${product.image_url} product is enrolled ${product.enrolled ?? false}');
              return buildProductCardItems(product);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (snapshot.hasError) {
              final error = snapshot.error.toString();
              Logger().e(error);
            }
            return const Center(
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

  Widget buildProductCardItems(MyProduct product) {
    bool isFav = false;

    return Container(
      width: SizeConfig.screenWidth * 0.8,
      height: SizeConfig.screenHeight * 0.8,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [
        BoxShadow(
          blurRadius: 7,
          color: Colors.grey,
          offset: Offset(0, 3),
        ),
      ]),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: IconButton(
                onPressed: () async {
                  setState(() {
                    if (isFav) {
                      isFav = false;
                    } else {
                      isFav = true;
                    }
                    print('isFav after :$isFav');
                  });
                  bool switchFav = await MyFirebaseFireStore.myFirebaseFireStore
                      .switchProductFavouriteStatus(widget.productId!, isFav ?? false);
                  print('switchFav :$switchFav');
                },
                icon: Icon(
                  size: 35,
                  Icons.favorite,
                  color: isFav ?? false ? Colors.red : Colors.grey,
                ),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image(
                image: NetworkImage(product.image_url ?? ''),
                height: 180.h,
                width: SizeConfig.screenWidth * 0.67,
                fit: BoxFit.fill,
              ),
              SizedBox(
                height: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12.sp,
                            fontFamily: "Besley-Regular",
                            color: kPrimaryColor,
                          ),
                          text: product.name,
                        ),
                      ),
                    ),
                    Text('${product.numberOfCourse} درس' ?? '!!!',
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20.sp,
                          fontFamily: "Besley-Regular",
                          color: kSecondaryColor,
                        )),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8),
                child: Text(
                  product.description ?? '!!!',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    fontFamily: "Besley-Regular",
                    color: Colors.grey,
                    // overflow: TextOverflow.ellipsis,
                  ),
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  overflow: TextOverflow.clip,
                ),
              ),
              // RichText(
              //   text: TextSpan(
              //     text: product.description!.length<=_kMaxShortTextLength?product.description:product.description!.substring(0,_kMaxShortTextLength) ,
              //     style: TextStyle(
              //       fontWeight: FontWeight.normal,
              //       fontSize: 20.sp,
              //       fontFamily: "Besley-Regular",
              //       color: kSecondaryColor,
              //     ),
              //     children: [
              //       TextSpan(
              //         text: 'اقرأ المزيد'
              //       )
              //     ]
              //   ),
              //
              // )
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> checkISFAV(String id) async {
    return await MyFirebaseFireStore.myFirebaseFireStore.isProductFavourite(widget.productId);
    ;
  }
}
