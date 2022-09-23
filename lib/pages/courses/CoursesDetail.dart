import 'package:Design/custom_widgets/widgets/dotted_text.dart';
import 'package:Design/provider/AppProvider.dart';
import 'package:Design/utile/constants.dart';
import 'package:Design/utile/tost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/widgets/imag_slider.dart';
import '../../data/firebase_firestore.dart';
import '../../models/modelsFirebase/my_product.dart';
import '../../models/quad_clipper.dart';
import '../../theme/color/light_color.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../theme/theme.dart';
import '../HomeCustomer/bottom_home_navigation.dart';

class CoursesDetails extends StatefulWidget {
  CoursesDetails({Key? key, required this.productId, this.order_name, this.order_price, this.add_to_cart, this.image})
      : super(key: key);
  final String? order_name;
  final String? order_price;
  final bool? add_to_cart;
  final String? image;
  final String productId;

  @override
  State<CoursesDetails> createState() => _CoursesDetailsState();
}

class _CoursesDetailsState extends State<CoursesDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  bool? isFav;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(top: 5, start: 8, end: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FutureBuilder<MyProduct>(
              future: MyFirebaseFireStore.myFirebaseFireStore.getProductWithID(widget.productId),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final MyProduct product = snapshot.data!;
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsetsDirectional.only(bottom: 10),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              child: Column(
                                // crossAxisAlignment: CrossAxisAlignment.end,
                                // mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  SizedBox(
                                    height: 50,
                                  ),
                                  ImagSlider(
                                    imagegList: [product.image_url ?? ''],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Text(
                        product.name ?? 'اسم المساق',
                        style: TextStyle(
                          fontSize: 22,
                          fontFamily: fontFamilayTajawal,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        // padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: Row(
                          children: [
                            Text(
                              'السعر : ${product.price} ر.س ',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontFamily: fontFamilayTajawal,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Text(
                              '${product.numberOfCourse} درس',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 22,
                                fontFamily: fontFamilayTajawal,
                                fontWeight: FontWeight.normal,
                                decorationStyle: TextDecorationStyle.solid,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            child: RatingBar.builder(
                              itemSize: 30,
                              initialRating: 4,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: kPrimaryColor,
                              ),
                              onRatingUpdate: (rating) {
                                print(rating);
                              },
                            ),
                          ),
                          Spacer(),
                          IconButton(
                            onPressed: () async {
                              setState(() {
                                if (isFav ?? false) {
                                  isFav = false;
                                } else {
                                  isFav = true;
                                }
                                print('isFav after :$isFav');
                              });
                              bool switchFav = await MyFirebaseFireStore.myFirebaseFireStore
                                  .switchProductFavouriteStatus(widget.productId, isFav ?? false);
                              print('switchFav :$switchFav');
                            },
                            icon: Icon(
                              size: 35,
                              Icons.favorite,
                              color: isFav ?? false ? Colors.red : Colors.grey,
                            ),
                          ),
                          SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(
                        'المحتويات :',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: fontFamilayTajawal,
                            fontWeight: FontWeight.w700,
                            color: kPrimaryColor),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DottedText(
                        '${product.description}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontFamilayTajawal,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          'المميزات :',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: fontFamilayTajawal,
                              fontWeight: FontWeight.w700,
                              color: kPrimaryColor),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      DottedText(
                        '${product.highlightCourse}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: fontFamilayTajawal,
                          fontWeight: FontWeight.normal,
                          fontSize: 14,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: Center(
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              width: 200,
                              height: 45,
                              padding: EdgeInsetsDirectional.all(5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.all(Radius.circular(15)),
                                color: kPrimaryColor,
                                boxShadow: [
                                  BoxShadow(
                                    blurRadius: 15,
                                    color: kPrimaryColor.withOpacity(0.5),
                                    offset: Offset(1, 1),
                                  ),
                                ],
                              ),
                              child: GestureDetector(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.shopping_cart,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'إضافة للسلة',
                                      style: TextStyle(color: Colors.white, fontSize: 16),
                                    )
                                  ],
                                ),
                                onTap: () async {
                                  bool isAddTOCart = await Provider.of<AppProvider>(context, listen: false)
                                      .addToCart(widget.productId);
                                  ToastMessage.showToast(isAddTOCart?'تم إضافة المنتج للسلة بنجاح':'هناك خطأ', isAddTOCart);
                                  print('isAddTOCart!$isAddTOCart');
                                  if(isAddTOCart){
                                    Navigator.pop(context);
                                  }



                                },
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
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
            // Container(
            //   margin: EdgeInsetsDirectional.only(bottom: 10),
            //   child: Stack(
            //     clipBehavior: Clip.none,
            //     children: [
            //       Container(
            //         child: Column(
            //           // crossAxisAlignment: CrossAxisAlignment.end,
            //           // mainAxisAlignment: MainAxisAlignment.end,
            //           children: [
            //             SizedBox(
            //               height: 50,
            //             ),
            //             ImagSlider()
            //           ],
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // SizedBox(
            //   height: 15,
            // ),
            // Text(
            //   'علوم رابع ابتدائي الفصل الثاني',
            //   style: TextStyle(
            //     fontSize: 22,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.bold,
            //     color: Colors.black,
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Container(
            //   // padding: EdgeInsets.only(left: 15, right: 15, top: 10),
            //   child: Row(
            //     children: [
            //       Text(
            //         ' السعر : 99  ر.س ',
            //         style: TextStyle(
            //           color: Colors.black,
            //           fontSize: 18,
            //           fontFamily: fontFamilayTajawal,
            //           fontWeight: FontWeight.bold,
            //         ),
            //       ),
            //       SizedBox(
            //         width: 5,
            //       ),
            //       Text(
            //         '150ر.س ',
            //         style: TextStyle(
            //             color: Colors.grey,
            //             fontSize: 14,
            //             fontFamily: fontFamilayTajawal,
            //             fontWeight: FontWeight.normal,
            //             decorationStyle: TextDecorationStyle.solid,
            //             decoration: TextDecoration.lineThrough),
            //       ),
            //       Spacer(),
            //     ],
            //   ),
            // ),
            // Row(
            //   children: [
            //     Container(
            //       child: RatingBar.builder(
            //         itemSize: 30,
            //         initialRating: 4,
            //         minRating: 1,
            //         direction: Axis.horizontal,
            //         allowHalfRating: true,
            //         itemCount: 5,
            //         itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
            //         itemBuilder: (context, _) => Icon(
            //           Icons.star,
            //           color: kPrimaryColor,
            //         ),
            //         onRatingUpdate: (rating) {
            //           print(rating);
            //         },
            //       ),
            //     ),
            //     Spacer(),
            //     IconButton(
            //       onPressed: () {},
            //       icon: Icon(
            //         size: 35,
            //         Icons.favorite,
            //         color: Colors.red,
            //       ),
            //     ),
            //     SizedBox(
            //       width: 5,
            //     ),
            //     // Text(
            //     //   ' تم شراءه وتم تقييمه 40 مرة',
            //     //   style: TextStyle(
            //     //     color: Colors.grey,
            //     //     fontFamily: "BesleyBlack",
            //     //     fontWeight: FontWeight.normal,
            //     //     fontSize: 12,
            //     //     decorationStyle: TextDecorationStyle.dashed,
            //     //   ),
            //     // ),
            //   ],
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // Text(
            //   'المحتويات :',
            //   style: TextStyle(
            //       fontSize: 16,
            //       fontFamily: fontFamilayTajawal,
            //       fontWeight: FontWeight.w700,
            //       color: kPrimaryColor),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            //
            // DottedText(
            //   'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'بوربوينت مميز وبشرح سلس ومبسط لكل درس بالمنهج.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'تمت إضافة استراتيجيات تعلّم نشط داخل بوربوينت الدرس.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'فيديو لكل درس داخل البوربوينت.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'ورقة عمل لكل درس.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'أوارق الاستراتيجيات المستخدمة ( إن لزم لها ).',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'تحضير ثلاثي بالاستراتيجيات المستخدمة بالدرس.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'ملحقات التحضير ( التوزيع , المسرد المفرغ , غلاف التحضير , الأهداف العامة والخاصة ).',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(top: 8.0),
            //   child: Text(
            //     'المميزات :',
            //     style: TextStyle(
            //         fontSize: 16,
            //         fontFamily: fontFamilayTajawal,
            //         fontWeight: FontWeight.w700,
            //         color: kPrimaryColor),
            //   ),
            // ),
            // SizedBox(
            //   height: 5,
            // ),
            // DottedText(
            //   'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'بوربوينت مميز وبشرح سلس ومبسط لكل درس بالمنهج.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'تمت إضافة استراتيجيات تعلّم نشط داخل بوربوينت الدرس.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'فيديو لكل درس داخل البوربوينت.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'ورقة عمل لكل درس.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'أوارق الاستراتيجيات المستخدمة ( إن لزم لها ).',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'تحضير ثلاثي بالاستراتيجيات المستخدمة بالدرس.',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            // DottedText(
            //   'ملحقات التحضير ( التوزيع , المسرد المفرغ , غلاف التحضير , الأهداف العامة والخاصة ).',
            //   style: TextStyle(
            //     color: Colors.black,
            //     fontFamily: fontFamilayTajawal,
            //     fontWeight: FontWeight.normal,
            //     fontSize: 14,
            //   ),
            // ),
            //
            // SizedBox(
            //   height: 10,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(bottom: 16.0),
            //   child: Center(
            //     child: InkWell(
            //       onTap: () {},
            //       child: Container(
            //         width: 200,
            //         height: 45,
            //         padding: EdgeInsetsDirectional.all(5),
            //         decoration: BoxDecoration(
            //           borderRadius: BorderRadius.all(Radius.circular(15)),
            //           color: kPrimaryColor,
            //           boxShadow: [
            //             BoxShadow(
            //               blurRadius: 15,
            //               color: kPrimaryColor.withOpacity(0.5),
            //               offset: Offset(1, 1),
            //             ),
            //           ],
            //         ),
            //         child: Row(
            //           mainAxisAlignment: MainAxisAlignment.center,
            //           children: [
            //             Icon(
            //               Icons.shopping_cart,
            //               color: Colors.white,
            //             ),
            //             Text(
            //               'إضافة للسلة',
            //               style: TextStyle(color: Colors.white, fontSize: 16),
            //             )
            //           ],
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
