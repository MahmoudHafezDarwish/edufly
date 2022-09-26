import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import '../../custom_widgets/product/nothingtoshow_container.dart';
import '../../custom_widgets/widgets/async_progress_dialog.dart';
import '../../custom_widgets/widgets/cart_item_widget.dart';
import '../../data/firebase_firestore.dart';
import '../../models/courseModel.dart';
import '../../models/modelsFirebase/CartItem.dart';
import '../../models/modelsFirebase/my_product.dart';
import '../../utile/RouterHelper.dart';
import '../../utile/constants.dart';
import '../../utile/size_config.dart';
import '../../utile/utils.dart';
import '../courses/StageCourses.dart';
import '../data_streams/cart_items_stream.dart';

class HomeCartScreen extends StatefulWidget {
  const HomeCartScreen({Key? key}) : super(key: key);

  @override
  _HomeCartScreenState createState() => _HomeCartScreenState();
}

class _HomeCartScreenState extends State<HomeCartScreen> {
  final CartItemsStream cartItemsStream = CartItemsStream();

  // PersistentBottomSheetController bottomSheetHandler;

  @override
  void initState() {
    // TODO: implement initState
    cartItemsStream.init();

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    cartItemsStream.dispose();
    super.dispose();
  }

  List cart_list = CourseList.list.where((element) => element.addToCart).toList();

  Widget _courseListView(BuildContext context) {
    return ListView.builder(
        itemCount: cart_list.length,
        itemBuilder: (context, index) {
          return StageCourses.itemList(context, index);
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: refreshPage,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                    height: SizeConfig.screenHeight * 0.9,
                    child: Center(child: buildCartItemsList())),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    cartItemsStream.reload();
    return Future<void>.value();
  }

  Widget buildCartItemsList() {
    return StreamBuilder<List<String>>(
      stream: cartItemsStream.stream as Stream<List<String>>,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<String> cartItemsId = snapshot.data!;
          if (cartItemsId.length == 0) {
            return Center(
              child: NothingToShowContainer(
                iconPath: "assets/icons/empty_cart.svg",
                secondaryMessage: "Your cart is empty",
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Positioned(
                      right: 30,
                      top: 20,
                      left: 30,
                      bottom: 10,
                      child: Text(
                        "عدد العناصر المتاحة ${cartItemsId.length}",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontFamily: fontFamilayTajawal,
                        ),
                      ),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.symmetric(vertical: 16),
                      physics: BouncingScrollPhysics(),
                      itemCount: cartItemsId.length,
                      itemBuilder: (context, index) {
                        if (index >= cartItemsId.length) {
                          return SizedBox(height: getProportionateScreenHeight(80));
                        }
                        return buildCartItem(cartItemsId[index], index);
                        // return buildCartItemDismissible(
                        //     context, cartItemsId[index], index);
                      },
                    ),
                    Container(
                      margin: EdgeInsetsDirectional.only(start: 20, end: 20, top: 20),
                      child: FutureBuilder<num>(
                          future: MyFirebaseFireStore.myFirebaseFireStore.cartTotal,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              final cartTotal = snapshot.data;
                              final sumTotal = cartTotal! * 0.15;
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Row(
                                    children: [
                                      Text("المجموع الجزئي :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: fontFamilayTajawal,
                                            color: Colors.black.withOpacity(0.5),
                                          )),
                                      Spacer(),
                                      Text('${cartTotal} ر.س',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            fontFamily: fontFamilayTajawal,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Text("الضريبة :(15%)",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: fontFamilayTajawal,
                                            color: Colors.black.withOpacity(0.5),
                                          )),
                                      Spacer(),
                                      Text('${sumTotal.round()} ر.س',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            fontFamily: fontFamilayTajawal,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  Divider(
                                    thickness: 2,
                                    height: 15,
                                    color: Colors.grey.shade300,
                                  ),
                                  Row(
                                    children: [
                                      Text("المجموع :",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: fontFamilayTajawal,
                                            color: Colors.black.withOpacity(0.5),
                                          )),
                                      Spacer(),
                                      Text('${sumTotal + cartTotal} ر.س',
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 20,
                                            fontFamily: fontFamilayTajawal,
                                            color: Colors.grey,
                                          )),
                                    ],
                                  ),
                                  Container(
                                    width: 315,
                                    height: 53,
                                    margin: EdgeInsetsDirectional.only(top: 10),
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/PaymentMode");
                                      },
                                      child:const Text('طلب الدفع'),
                                      style: ElevatedButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontFamily: fontFamilayTajawal,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Colors.white,
                                        ),
                                        primary: Colors.blue,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  Container(
                                    width: 315,
                                    height: 53,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(context, "/homeCartScreen");
                                      },
                                      style: ElevatedButton.styleFrom(
                                        textStyle: TextStyle(
                                          fontFamily: fontFamilayTajawal,
                                          fontWeight: FontWeight.w800,
                                          fontSize: 16,
                                          color: Colors.yellow,
                                        ),
                                        primary: Colors.white,
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                                      ),
                                      child:const Text(
                                        'إلغاء الطلب',
                                        style: TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            } else if (snapshot.hasError) {
                              final error = snapshot.error;
                              Logger().w(error.toString());
                              return Center(
                                child: Text(
                                  error.toString(),
                                ),
                              );
                            } else {
                              return Center(
                                child: Icon(
                                  Icons.error,
                                ),
                              );
                            }
                          }),
                    ),
                  ],
                ),
              ),
            ),
          );
        } else if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          final error = snapshot.error;
          Logger().w(error.toString());
        }
        return Center(
          child: NothingToShowContainer(
            iconPath: "assets/icons/network_error.svg",
            primaryMessage: "Something went wrong",
            secondaryMessage: "Unable to connect to Database",
          ),
        );
      },
    );
  }

  Widget buildCartItem(String cartItemId, int index) {
    return Container(
      padding: const EdgeInsets.only(
        bottom: 4,
        top: 4,
        right: 2,
      ),
      margin: EdgeInsets.symmetric(vertical: 4),
      decoration: BoxDecoration(
        border: Border.all(color: kTextColor.withOpacity(0.15)),
        borderRadius: BorderRadius.circular(15.r),
      ),
      // margin: EdgeInsetsDirectional.only(start: 10, end: 10, top: 46),
      child: FutureBuilder<MyProduct>(
          future: MyFirebaseFireStore.myFirebaseFireStore.getProductWithID(cartItemId),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              MyProduct product = snapshot.data!;
              return Container(
                width: double.infinity,
                padding: EdgeInsets.only(top: 5),
                child: Card(
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: Colors.white,
                      width: 1,
                    ),
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                  child: Wrap(
                    spacing: 5,
                    crossAxisAlignment: WrapCrossAlignment.start,
                    children: [
                      Image(
                        image: NetworkImage(product.image_url!),
                        height: 72.h,
                        width: 72.w,
                        fit: BoxFit.contain,
                        alignment: Alignment.topCenter,
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(product.name ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 12.sp,
                                fontFamily: fontFamilayTajawal,
                                color: Colors.black,
                              ),

                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(product.categoryOfCourses ?? '',
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 14.sp,
                                fontFamily: fontFamilayTajawal,
                                color: Color(0xffA1A1B4),
                              )),
                          SizedBox(
                            height: 10,
                          ),
                          Text("${product.price} ر.س ",
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 16,
                                fontFamily: fontFamilayTajawal,
                                color: kPrimaryColor,
                              )),
                        ],
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(Icons.add),
                                iconSize: 30,
                                color: Colors.black,
                                onPressed: () async {
                                  await increaseCountCallback(cartItemId);
                                },
                              ),
                              FutureBuilder<CartItem>(
                                  future: MyFirebaseFireStore.myFirebaseFireStore.getCartItemFromId(cartItemId),
                                  builder: (context, snapshot) {
                                    int itemCount = 0;
                                    if (snapshot.hasData) {
                                      final cartItem = snapshot.data;
                                      itemCount = cartItem!.itemCount;
                                      return Text("$itemCount",
                                          style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontSize: 22,
                                            fontFamily: fontFamilayTajawal,
                                            color: Colors.black,
                                          ));
                                    } else if (snapshot.hasError) {
                                      final error = snapshot.error.toString();
                                      Logger().e(error);
                                    }
                                    return Center(
                                      child: Icon(
                                        Icons.error,
                                      ),
                                    );
                                  }),
                              IconButton(
                                icon: Icon(Icons.remove),
                                iconSize: 30,
                                color: Colors.black,
                                onPressed: () async {
                                  await decreaseCountCallback(cartItemId);
                                  print("decreaseCountCallback");
                                },
                              ),
                              Spacer(),
                              IconButton(
                                icon: Icon(Icons.cancel_outlined),
                                iconSize: 30,
                                color: Colors.red.shade500,
                                onPressed: () async {
                                  final confirmation = await showConfirmationDialog(
                                    context,
                                    "Remove Product from Cart?",
                                  );
                                  if (confirmation) {
                                    bool result = false;
                                    String snackbarMessage = '';
                                    try {
                                      result =
                                      await MyFirebaseFireStore.myFirebaseFireStore.removeProductFromCart(cartItemId);
                                      if (result == true) {
                                        snackbarMessage = "Product removed from cart successfully";
                                        await refreshPage();
                                      } else {
                                        throw "Coulnd't remove product from cart due to unknown reason";
                                      }
                                    } on FirebaseException catch (e) {
                                      Logger().w("Firebase Exception: $e");
                                      snackbarMessage = "Something went wrong";
                                    } catch (e) {
                                      Logger().w("Unknown Exception: $e");
                                      snackbarMessage = "Something went wrong";
                                    } finally {
                                      Logger().i(snackbarMessage);
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(snackbarMessage),
                                        ),
                                      );
                                    }
                                    print("$result delete");

                                    // return result;
                                  }
                                  // return false;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              final error = snapshot.error;
              Logger().w(error.toString());
              return Center(
                child: Text(
                  error.toString(),
                ),
              );
            } else {
              return Center(
                child: Icon(
                  Icons.error,
                ),
              );
            }
          }),
    );
  }

  Future<void> increaseCountCallback(String cartItemId) async {
    final future = MyFirebaseFireStore.myFirebaseFireStore.increaseCartItemCount(cartItemId);
    future.then((status) async {
      if (status) {
        await refreshPage();
      } else {
        throw "Couldn't perform the operation due to some unknown issue";
      }
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AsyncProgressDialog(
          future,
          message: Text("Please wait"),
          progress: CircularProgressIndicator(),
          onError: () {},
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        );
      },
    );
  }

  Future<void> decreaseCountCallback(String cartItemId) async {
    final future = MyFirebaseFireStore.myFirebaseFireStore.decreaseCartItemCount(cartItemId);
    future.then((status) async {
      if (status) {
        await refreshPage();
      } else {
        throw "Couldn't perform the operation due to some unknown issue";
      }
    }).catchError((e) {
      Logger().e(e.toString());
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Something went wrong"),
      ));
    });
    await showDialog(
      context: context,
      builder: (context) {
        return AsyncProgressDialog(
          future,
          message: Text("Please wait"),
          progress: CircularProgressIndicator(),
          onError: () {},
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
        );
      },
    );
  }
}
