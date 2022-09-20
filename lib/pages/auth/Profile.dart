import 'package:cached_network_image/cached_network_image.dart';
import 'package:edufly/pages/auth/login_screen.dart';
import 'package:edufly/utile/constants.dart';
import 'package:edufly/utile/size_config.dart';
import 'package:edufly/utile/tost.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:flutter/services.dart';

import '../../custom_widgets/product/nothingtoshow_container.dart';
import '../../data/firebase_firestore.dart';
import '../../models/User.dart';
import '../../models/modelsFirebase/MyUsres.dart';
import '../../models/modelsFirebase/my_product.dart';
import '../../provider/AppProvider.dart';
import '../courses/CoursesDetail.dart';
import '../data_streams/ordered_products_stream.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController phoneNumber;
  late TextEditingController _email;
  OrderedProductsStream orderedProductsStream = OrderedProductsStream();

  // TextEditingController bio = TextEditingController(text: " ");
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _email = TextEditingController();
    phoneNumber = TextEditingController(text: "0591234567");
    orderedProductsStream.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _email.dispose();
    phoneNumber.dispose();
    orderedProductsStream.dispose();
  }

  AppUser user = AppUser(
      name: 'اسم المستخدم',
      bio: '',
      // profilePicture:
      //     'https://scontent.fgza6-1.fna.fbcdn.net/v/t39.30808-6/281741899_689974098894613_1577816906459461245_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=qcBZPq3iE2IAX9RZE04&_nc_ht=scontent.fgza6-1.fna&oh=00_AT-JvnfSL797RxEHITaNGONjeq2esf0mYZhIrS1r3W1_1w&oe=62A4FB8A',
      profilePicture: 'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png',
      isplus: true,
      email: 'email@gmail.com');

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    MyUser myUser = Provider.of<AppProvider>(context, listen: false).loggedUser!;
    _email.text = myUser.email ?? 'email@gmail.com';
    phoneNumber.text = myUser.phoneNumber ?? '059123456789';

    return Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: AppTitle(
            title: "حسابي",
          ),
          titleTextStyle: const TextStyle(
            // color: Colors.red,
            fontWeight: FontWeight.bold,
            fontFamily: 'BesleyBlack',
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(
                    color: white,
                    boxShadow: [
                      BoxShadow(
                        color: grey.withOpacity(0.01),
                        spreadRadius: 10,
                        blurRadius: 3,
                        // changes position of shadow
                      ),
                    ],
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(2 * subMargin), bottomRight: Radius.circular(2 * subMargin))),
                child: Padding(
                  padding: EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 25),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsetsDirectional.only(start: 10),
                            width: (size.width - 40) * 0.6,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  myUser.name ?? user.name,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontFamilayTajawal,
                                      color: black),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      "تقييمك : 4.5",
                                      style: TextStyle(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: fontFamilayTajawal,
                                          color: kPrimaryColor),
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: kPrimaryColor,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: (size.width - 40) * 0.4,
                            child: Container(
                              child: Stack(
                                children: [
                                  RotatedBox(
                                    quarterTurns: 2,
                                    child: CircularPercentIndicator(
                                        circularStrokeCap: CircularStrokeCap.round,
                                        backgroundColor: grey.withOpacity(0.3),
                                        radius: 55.0,
                                        lineWidth: 6.0,
                                        percent: 0.53,
                                        progressColor: kPrimaryColor),
                                  ),
                                  Positioned(
                                    top: 5.5,
                                    left: 45.5,
                                    child: Center(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          // image: DecorationImage(
                                          //     image: CachedNetworkImageProvider(
                                          //         user.profilePicture),
                                          //     fit: BoxFit.fill)
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(42.5),
                                          child: CachedNetworkImage(
                                            imageUrl: myUser.display_picture ?? user.profilePicture,
                                            fit: BoxFit.fitWidth,
                                            placeholder: (context, url) => CircularProgressIndicator(
                                              valueColor: new AlwaysStoppedAnimation<Color>(kPrimaryColor),
                                              backgroundColor: grey,
                                            ),
                                            errorWidget: (context, url, error) => Container(
                                                width: 85,
                                                height: 85,
                                                color: kPrimaryColor,
                                                child: Icon(
                                                  CupertinoIcons.person_solid,
                                                  color: kPrimaryColor,
                                                  size: 50,
                                                )),
                                          ),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Visibility(
                        visible: myUser.isFreelancer ? true : false,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: kPrimaryColor,
                              borderRadius: BorderRadius.circular(subMargin),
                              boxShadow: [
                                BoxShadow(
                                  color: kPrimaryColor.withOpacity(0.01),
                                  spreadRadius: 10,
                                  blurRadius: 3,
                                  // changes position of shadow
                                ),
                              ]),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "الطلبات المكتملة",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: fontFamilayTajawal,
                                          fontSize: 14,
                                          color: white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "20",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          fontFamily: fontFamilayTajawal,
                                          color: white),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "مجموع الدخل",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: fontFamilayTajawal,
                                          fontSize: 14,
                                          color: white),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "\$246.90",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontFamily: fontFamilayTajawal,
                                          fontSize: 20,
                                          color: white),
                                    ),
                                  ],
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10), border: Border.all(color: white)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(13.0),
                                    child: Text(
                                      "تحديث",
                                      style: TextStyle(
                                        color: white,
                                        fontFamily: 'BesleyBlack',
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: mainMargin,
              ),
              Container(
                padding: const EdgeInsets.only(left: 20, right: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: white, borderRadius: BorderRadius.circular(subMargin), boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "البريد الالكتروني",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: kPrimaryColor,
                                      fontFamily: fontFamilayTajawal),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 30,
                                  width: size.width - 80,
                                  child: TextField(
                                    controller: _email,
                                    cursorColor: kPrimaryColor,
                                    style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: black),
                                    decoration: InputDecoration(
                                        hintText: "البريد الالكتروني",
                                        hintStyle: TextStyle(
                                            fontWeight: FontWeight.w500, fontSize: 14, fontFamily: fontFamilayTajawal),
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(subMargin),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryColor.withOpacity(0.01),
                              spreadRadius: 10,
                              blurRadius: 3,
                              // changes position of shadow
                            ),
                          ]),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "رقم الهاتف",
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 12,
                                      color: kPrimaryColor,
                                      fontFamily: fontFamilayTajawal),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 30,
                                  width: size.width - 80,
                                  child: TextField(
                                    controller: phoneNumber,
                                    cursorColor: black,
                                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: black),
                                    decoration: InputDecoration(
                                        hintText: "رقم الهاتف",
                                        contentPadding: EdgeInsets.zero,
                                        border: InputBorder.none),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: double.infinity,
                      decoration:
                          BoxDecoration(color: white, borderRadius: BorderRadius.circular(subMargin), boxShadow: [
                        BoxShadow(
                          color: kPrimaryColor.withOpacity(0.01),
                          spreadRadius: 10,
                          blurRadius: 3,
                          // changes position of shadow
                        ),
                      ]),
                      child: Visibility(
                        visible: myUser.isFreelancer ? false : true,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, right: 20, top: 25, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "قائمتي",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16,
                                        color: kPrimaryColor,
                                        fontFamily: fontFamilayTajawal),
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  StreamBuilder<List<String>>(
                                    stream: orderedProductsStream.stream as Stream<List<String>>,
                                    builder: (context, snapshot) {
                                      if (snapshot.hasData) {
                                        if (snapshot.data!.length == 0) {
                                          return Center(
                                            child: NothingToShowContainer(
                                              secondaryMessage: 'لا يوجد طلبات في قائمتك بعد',
                                            ),
                                          );
                                        } else {
                                          print('list of id products ${snapshot.data}');
                                          var listOfOrderedId = snapshot.data!;
                                          return Container(
                                            height: SizeConfig.screenHeight * 0.3,
                                            width: SizeConfig.screenWidth * 0.8,
                                            child: ListView.builder(
                                                itemCount: listOfOrderedId.length,
                                                itemBuilder: (context, index) {
                                                  return FutureBuilder<MyProduct>(
                                                      future: MyFirebaseFireStore.myFirebaseFireStore
                                                          .getProductWithID(listOfOrderedId[index]),
                                                      builder: (context, snap) {
                                                        if (snap.hasData) {
                                                          final MyProduct product = snap.data!;

                                                          return Row(
                                                            children: [
                                                              Container(
                                                                  margin: EdgeInsetsDirectional.only(bottom: 5),
                                                                  decoration: BoxDecoration(
                                                                      color: Colors.white,
                                                                      borderRadius: BorderRadius.circular(10),
                                                                      shape: BoxShape.rectangle),
                                                                  child: IconButton(
                                                                    onPressed: () async {
                                                                      await Clipboard.setData(
                                                                          ClipboardData(text: product.linkOfCourse));
                                                                      ToastMessage.showToast(
                                                                          'تم نسخ رابط التصميم للحافظة', true);
                                                                    },
                                                                    icon: Icon(
                                                                      Icons.copy,
                                                                      color: kPrimaryColor,
                                                                    ),
                                                                  )),
                                                              SizedBox(
                                                                width: 5,
                                                              ),
                                                              Text(
                                                                product.name ?? 'اسم التصميم',
                                                                style: TextStyle(
                                                                  fontSize: 14,
                                                                  fontFamily: fontFamilayTajawal,
                                                                  fontWeight: FontWeight.normal,
                                                                  color: Colors.black,
                                                                ),
                                                              ),
                                                              // SizedBox(
                                                              //   width: 5,
                                                              // ),
                                                              // InkWell(
                                                              //   onTap: () {},
                                                              //   child: Row(
                                                              //     children: [
                                                              //       Text(
                                                              //         product.linkOfCourse ?? 'رابط الكتاب',
                                                              //         style: TextStyle(
                                                              //           fontSize: 20,
                                                              //           fontFamily: fontFamilayTajawal,
                                                              //           fontWeight: FontWeight.bold,
                                                              //           color: kPrimaryColor,
                                                              //         ),
                                                              //       ),
                                                              //       Icon(Icons.library_add_check),
                                                              //     ],
                                                              //   ),
                                                              // )
                                                            ],
                                                          );
                                                        } else if (snapshot.connectionState ==
                                                            ConnectionState.waiting) {
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
                                                      });
                                                }),
                                          );
                                        }
                                      } else if (snapshot.connectionState == ConnectionState.waiting) {
                                        return const Center(
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
                                  ),

                                  // Container(
                                  //   height: 30,
                                  //   width: size.width - 80,
                                  //   child: TextField(
                                  //     controller: bio,
                                  //     cursorColor: black,
                                  //     style: TextStyle(
                                  //         fontSize: 17,
                                  //         fontWeight: FontWeight.bold,
                                  //         color: black),
                                  //     decoration: InputDecoration(
                                  //         hintText: "كتبي",
                                  //         contentPadding: EdgeInsets.zero,
                                  //         border: InputBorder.none),
                                  //   ),
                                  // ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
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
