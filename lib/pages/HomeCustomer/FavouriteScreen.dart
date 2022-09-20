import 'package:edufly/pages/courses/StageCourses.dart';
import 'package:flutter/material.dart';

import '../../custom_widgets/product/products_section.dart';
import '../../models/courseModel.dart';
import '../../theme/color/light_color.dart';
import '../../theme/theme.dart';
import '../../utile/RouterHelper.dart';
import '../../utile/constants.dart';
import '../../utile/size_config.dart';
import '../courses/CoursesDetail.dart';
import '../data_streams/favourite_products_stream.dart';

class FavouriteScreen extends StatefulWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  State<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends State<FavouriteScreen> {
  FavouriteProductsStream favouriteProductsStream = FavouriteProductsStream();
  @override
  void initState() {
    super.initState();
    favouriteProductsStream.init();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    favouriteProductsStream.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,

        title:const Text(
          "المفضلة",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 22,
            fontFamily: "Besley-Regular",
            color: Colors.white,
          ),
        ),
      ),
      body: ProductsSection(
        sectionTitle: "المفضلة",
        productsStreamController: favouriteProductsStream,
        emptyListMessage: "لا يوجد تصاميم مفضلة بعد !!",
        onProductCardTapped: onProductCardTapped,
      ),

      // body: Container(
      //   padding: EdgeInsetsDirectional.only(top: 10),
      //   // child: Column(
      //   //   children: <Widget>[
      //   //     SizedBox(height: 20),
      //   //     _categoryRow(context, "المرحلة الابتدائية"),
      //   //     _courseList(context),
      //   //   ],
      //   // ),
      //   child: Stack(
      //     children: [
      //       // Positioned(
      //       //     top: 50,
      //       //     left: 0,
      //       //     right: 30,
      //       //     child: Text(
      //       //       "المفضلة",
      //       //       style: TextStyle(
      //       //         fontWeight: FontWeight.normal,
      //       //         fontSize: 22,
      //       //         fontFamily: "Besley-Regular",
      //       //         color: kPrimaryColor,
      //       //       ),
      //       //     )),
      //       Positioned(
      //           top: 20,
      //           left: 0,
      //           right: 0,
      //           height: SizeConfig.screenHeight * 0.9,
      //           child: _courseListView(context)),
      //     ],
      //   ),
      // ),
    );
  }
  Future<void> refreshPage() {
    favouriteProductsStream.reload();
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
