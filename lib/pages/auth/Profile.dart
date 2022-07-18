import 'package:cached_network_image/cached_network_image.dart';
import 'package:edufly/pages/auth/login_screen.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';

import '../../models/User.dart';

class ProfilePage extends StatefulWidget {
  static const routeName = '/profile';

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController dateOfBirth = TextEditingController(text: "0591234567");
  TextEditingController bio = TextEditingController(text: " ");
  AppUser user = AppUser(
      name: 'محمود درويش',
      bio: 'abo hafez',
      // profilePicture:
      //     'https://scontent.fgza6-1.fna.fbcdn.net/v/t39.30808-6/281741899_689974098894613_1577816906459461245_n.jpg?_nc_cat=107&ccb=1-7&_nc_sid=09cbfe&_nc_ohc=qcBZPq3iE2IAX9RZE04&_nc_ht=scontent.fgza6-1.fna&oh=00_AT-JvnfSL797RxEHITaNGONjeq2esf0mYZhIrS1r3W1_1w&oe=62A4FB8A',
      profilePicture:
          'https://cdn.pixabay.com/photo/2018/08/28/12/41/avatar-3637425_960_720.png',
      isplus: true,
      email: 'email@gmail.com');
  TextEditingController _email = TextEditingController(text: "email@gmail.com");

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: grey,
        appBar: AppBar(
          backgroundColor: kPrimaryColor,
          title: AppTitle(
            title: "حسابي",
          ),
          titleTextStyle: TextStyle(
            // color: Colors.red,
            fontWeight: FontWeight.bold,
            fontFamily: 'BesleyBlack',
          ),
          // actions: [
          //   Padding(
          //     padding: EdgeInsets.only(right: mainMargin),
          //     child: IconButton(
          //       icon: Icon(
          //         Icons.logout,
          //         color: Colors.black,
          //       ),
          //       onPressed: () {
          //         // FirebaseAuth.instance.signOut().then((value) {
          //         //   Navigator.pushAndRemoveUntil(
          //         //       context,
          //         //       MaterialPageRoute(
          //         //           builder: (context) => Onboarding()),
          //         //       (route) => false);
          //         // });
          //       },
          //     ),
          //   )
          // ],
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
                        bottomLeft: Radius.circular(2 * subMargin),
                        bottomRight: Radius.circular(2 * subMargin))),
                child: Padding(
                  padding:
                      EdgeInsets.only(top: 20, right: 20, left: 20, bottom: 25),
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
                                  user.name,
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
                                        circularStrokeCap:
                                            CircularStrokeCap.round,
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
                                          borderRadius:
                                              BorderRadius.circular(42.5),
                                          child: CachedNetworkImage(
                                            imageUrl: user.profilePicture,
                                            fit: BoxFit.fitWidth,
                                            placeholder: (context, url) =>
                                                CircularProgressIndicator(
                                              valueColor:
                                                  new AlwaysStoppedAnimation<
                                                      Color>(kPrimaryColor),
                                              backgroundColor: grey,
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Container(
                                                        width: 85,
                                                        height: 85,
                                                        color: kPrimaryColor,
                                                        child: Icon(
                                                          CupertinoIcons
                                                              .person_solid,
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
                      Container(
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
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 25, bottom: 25),
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
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: white)),
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
                      decoration: BoxDecoration(
                          color: white,
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
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 25, bottom: 25),
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
                                      fontSize: 12,
                                      color: kPrimaryColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 30,
                                  width: size.width - 80,
                                  child: TextField(
                                    controller: _email,
                                    cursorColor: black,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: black),
                                    decoration: InputDecoration(
                                        hintText: "البريد الالكتروني",
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
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 25, bottom: 25),
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
                                      color: kPrimaryColor),
                                ),
                                SizedBox(
                                  height: 5,
                                ),
                                Container(
                                  height: 30,
                                  width: size.width - 80,
                                  child: TextField(
                                    controller: dateOfBirth,
                                    cursorColor: black,
                                    style: TextStyle(
                                        fontSize: 17,
                                        fontWeight: FontWeight.bold,
                                        color: black),
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
                      decoration: BoxDecoration(
                          color: white,
                          borderRadius: BorderRadius.circular(subMargin),
                          boxShadow: [
                            BoxShadow(
                              color: kPrimaryColor.withOpacity(0.01),
                              spreadRadius: 10,
                              blurRadius: 3,
                              // changes position of shadow
                            ),
                          ]),
                      child: Visibility(
                        visible: LoginScreen.typeUser=='user',
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 25, bottom: 25),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "قائمتي",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 12,
                                        color: kPrimaryColor),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                          margin: EdgeInsetsDirectional.only(
                                              bottom: 5),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              shape: BoxShape.rectangle),
                                          child: Icon(
                                            Icons.check,
                                            color: kPrimaryColor,
                                          )),
                                      Text(
                                        'علوم رابع ابتدائي الفصل الثاني',
                                        style: TextStyle(
                                          fontSize: 14,
                                          fontFamily: fontFamilayTajawal,
                                          fontWeight: FontWeight.normal,
                                          color: Colors.black,
                                        ),
                                      ),
                                      SizedBox(width: 5,),
                                      InkWell(
                                        onTap: () {},
                                        child: Row(
                                          children: [
                                            Text(
                                              'رابط الكتاب',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontFamily: fontFamilayTajawal,
                                                fontWeight: FontWeight.bold,
                                                color: kPrimaryColor,
                                              ),
                                            ),
                                            Icon(Icons.library_add_check),
                                          ],
                                        ),
                                      )
                                    ],
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
}
