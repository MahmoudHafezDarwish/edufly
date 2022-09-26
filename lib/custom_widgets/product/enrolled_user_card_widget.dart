import 'package:Design/data/firebase_firestore.dart';
import 'package:Design/models/modelsFirebase/MyUsres.dart';
import 'package:Design/models/modelsFirebase/my_product.dart';
import 'package:Design/utile/size_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:logger/logger.dart';

import '../../utile/constants.dart';

class UserEnrolledCard extends StatefulWidget {
  final String productId;
  final GestureTapCallback press;

  UserEnrolledCard({
    required this.productId,
    required this.press,
  });

  @override
  State<UserEnrolledCard> createState() => _UserEnrolledCardState();
}

class _UserEnrolledCardState extends State<UserEnrolledCard> {
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
              final MyProduct myProduct = snapshot.data!;
              return buildProductCardItems(myProduct);
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

  Widget buildProductCardItems(MyProduct myProduct) {
    return Container(
      width: SizeConfig.screenWidth * 0.8,
      height: SizeConfig.screenHeight * 0.1,
      clipBehavior: Clip.antiAlias,
      margin: const EdgeInsets.all(5),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15), boxShadow: const [
        BoxShadow(
          blurRadius: 7,
          color: Colors.grey,
          offset: Offset(0, 3),
        ),
      ]),
      padding: EdgeInsets.symmetric(horizontal: 5,vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Text(myProduct.name ?? 'user name',
                  style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    fontFamily: fontFamilayTajawal,
                    color: kPrimaryColor,
                  )),
              Spacer(),
              Text(' السعر : ${myProduct.price}' ?? '!!!',
                  style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 20,
                    fontFamily: "Besley-Regular",
                    color: kSecondaryColor,
                  )),

            ],

          ),
          FutureBuilder<List<MyUser>>(
            future: MyFirebaseFireStore.myFirebaseFireStore.getEnrolledUser(myProduct.enrolledUser!),
            builder: (context, snapshot) {
              List<MyUser> listUser = [];
              if (snapshot.hasData) {
                listUser = snapshot.data!;
                print('***********************');
                print('listUser data :${listUser!.length}');
                print('************************');
                if (listUser.isNotEmpty) {
                  return ListView.builder(

                      itemCount: listUser.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        MyUser user = listUser[index];
                        return Container(
                          width:SizeConfig.screenWidth*0.8,
                          child: Row(
                            children: [
                              Text(user.name ?? 'user name',
                                  style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 14,
                                    fontFamily: "Besley-Regular",
                                    color: kPrimaryColor,
                                  )),
                              Spacer(),
                              Text('${user.phoneNumber} ' ?? '!!!',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 20,
                                    fontFamily: "Besley-Regular",
                                    color: kSecondaryColor,
                                  )),
                            ],
                          ),
                        );
                      });
                } else {
                  return Row(
                    children: [
                      Text('No data found '),
                      Icon(
                        Icons.error,
                        color: kTextColor,
                        size: 60,
                      ),
                    ],
                  );
                }
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
          // Divider(
          //   height: 2,
          //   thickness: 5,
          //   color: Colors.grey,
          // )
        ],
      ),
    );
  }
}
