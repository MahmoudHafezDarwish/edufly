import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Design/models/modelsFirebase/MyUsres.dart';
import 'package:Design/provider/AppProvider.dart';
import 'package:Design/utile/constants.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../data/firebase_firestore.dart';
import '../../models/modelsFirebase/OrderedProduct.dart';
import '../../utile/utils.dart';
import 'async_progress_dialog.dart';

class PaymentInput extends StatefulWidget {
  @override
  _PaymentInputState createState() => _PaymentInputState();
}

class _PaymentInputState extends State<PaymentInput> {
  late TextEditingController pay_number;
  late TextEditingController pay_date;
  late TextEditingController pay_ccv;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pay_number = TextEditingController();
    pay_date = TextEditingController();
    pay_ccv = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 319,
              height: 320,
              color: Colors.white,
              margin: EdgeInsetsDirectional.only(start: 28, end: 28, top: 40),
              child: Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.number,
                    controller: pay_number,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      fontSize: 20,
                      fontFamily: fontFamilayTajawal,
                      color: kPrimaryColor,
                    ),
                    decoration: InputDecoration(
                      hintText: "6524 2541 2164",
                      // prefixIcon: Icon(
                      //   Icons.person,
                      //   color: Colors.blue,
                      // ),
                      hintStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        fontFamily: fontFamilayTajawal,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      keyboardType: TextInputType.datetime,
                      controller: pay_date,
                      obscureText: false,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        fontFamily: fontFamilayTajawal,
                        color: kPrimaryColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.only(start: 10),
                        hintText: "MM/YY",
                        // prefixIcon: Icon(
                        //   Icons.password,
                        //   color: Colors.blue,
                        // ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          fontFamily: fontFamilayTajawal,
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      keyboardType: TextInputType.text,
                      controller: pay_ccv,
                      obscureText: true,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 20,
                        fontFamily: fontFamilayTajawal,
                        color: kPrimaryColor,
                      ),
                      decoration: InputDecoration(
                        contentPadding: EdgeInsetsDirectional.only(start: 10),
                        hintText: "CCV",
                        // prefixIcon: Icon(
                        //   Icons.password,
                        //   color: Colors.blue,
                        // ),
                        hintStyle: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          fontFamily: fontFamilayTajawal,
                          color: Colors.black.withOpacity(.5),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsetsDirectional.all(20),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        backgroundColor: kPrimaryColor,
                        textStyle: TextStyle(
                          color: Colors.white70,
                        ),
                      ),
                      onPressed: () async {
                        await checkoutButtonCallback();
                        Navigator.pushNamed(context, "/PaymentSuccessful");
                        print("Email: ${pay_number.text}  Password : ${pay_date.text}");
                      },
                      child: Text(
                        " تابع الدفع",
                        style: TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 20,
                          fontFamily: fontFamilayTajawal,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> checkoutButtonCallback() async {
    final confirmation = await showConfirmationDialog(
      context,
      "إنه مجرد تطبيق لاختبار المشروع ، لذا لا توجد واجهة دفع فعلية متاحة.\n هل تريد متابعة الطلب الوهمي للمنتجات؟",
    );
    if (confirmation == false) {
      return;
    }
    final orderFuture = MyFirebaseFireStore.myFirebaseFireStore.emptyCart();
    orderFuture.then((orderedProductsUid) async {
      if (orderedProductsUid != null) {
        print(orderedProductsUid);
        final dateTime = DateTime.now();
        final formatedDateTime = "${dateTime.day}-${dateTime.month}-${dateTime.year}";
        List<OrderedProduct> orderedProducts =
            orderedProductsUid.map((e) => OrderedProduct('', productUid: e, orderDate: formatedDateTime)).toList();
        bool addedProductsToMyProducts = false;
        String snackbarmMessage = '';
        try {
          addedProductsToMyProducts = await MyFirebaseFireStore.myFirebaseFireStore.addToMyOrders(orderedProducts);
          if (addedProductsToMyProducts) {
            snackbarmMessage = "تم طلب المنتجات بنجاح";

            orderedProducts.forEach((order) async {
              print('my Order orderedProducts :${order.productUid}+${order.orderDate}');
              //
              // final myOrderProduct =
              //     await MyFirebaseFireStore.myFirebaseFireStore.getOrderedProductFromId(order.productUid!);
              // print('my Order Product :${myOrderProduct.productUid}+${myOrderProduct.orderDate}');
              final myProducts = await MyFirebaseFireStore.myFirebaseFireStore.getProductWithID(order.productUid!);
              print(
                  'my Order Product :${myProducts!.name ?? ''}+${myProducts!.linkOfCourse} product is enrolled ${myProducts.enrolled ?? false}');

              MyUser user = Provider.of<AppProvider>(context, listen: false).loggedUser!;
              String message = ' شكرا ${user.name} ' ' لتعاملك معنا نتمنى أن تنال التصاميم إعجابكم';
              String message1 = ' رابط التصميم  ${myProducts!.linkOfCourse} تصميم  ${myProducts.name}';
              //
              await openWhatsapp('${message}}\n ${message1} \n المصدر من تطبيق Design', user.phoneNumber ?? '');
            });
          } else {
            throw "لا يمكن طلب المنتجات بسبب مشكلة غير معروفة";
          }
        } on FirebaseException catch (e) {
          Logger().e(e.toString());
          snackbarmMessage = e.toString();
        } catch (e) {
          Logger().e(e.toString());
          snackbarmMessage = e.toString();
        } finally {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(snackbarmMessage ?? "Something went wrong"),
            ),
          );
        }
      } else {
        throw "Something went wrong while clearing cart";
      }
      await showDialog(
        context: context,
        builder: (context) {
          return AsyncProgressDialog(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            onError: () {},
            progress: CircularProgressIndicator(),
            orderFuture,
            message: Text("Placing the Order"),
          );
        },
      );
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Something went wrong"),
        ),
      );
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AsyncProgressDialog(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
          onError: () {},
          progress: CircularProgressIndicator(),
          orderFuture,
          message: Text("Placing the Order"),
        );
      },
    );
  }

  openWhatsapp(String message, String phoneNumber) async {
    var whatsapp = "$phoneNumber";
    var whatsappUrl = "whatsapp://send?phone=${whatsapp}+&text=${Uri.encodeComponent(message)}";
    try {
      await launch(whatsappUrl);
    } catch (e) {
      print(e.toString());
    }
  }
}
