import 'package:edufly/models/course.dart';
import 'package:edufly/models/userProfile.dart';
import 'package:edufly/pages/data_streams/users_products_stream.dart';
import 'package:edufly/pages/edit_product/provider_models/ProductDetails.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../custom_widgets/product/products_section.dart';
import '../../../custom_widgets/widgets/adminCard.dart';
import '../../../provider/AppProvider.dart';
import '../../courses/CoursesDetail.dart';
import 'createCourse.dart';

class UserHomeFeed extends StatefulWidget {
  @override
  static const routeName = '/UserHomeFeed';

  @override
  _userHomeFeedState createState() => _userHomeFeedState();
}

class _userHomeFeedState extends State<UserHomeFeed> {
  @override
  bool _isLoading = false;

  final UsersProductsStream usersProductsStream = UsersProductsStream();

  @override
  void initState() {
    usersProductsStream.init();
    super.initState();
  }

  void dispose() {
    super.dispose();
    usersProductsStream.dispose();
  }


  double borderRadius = 10, padding = 10;
  @override
  Widget build(BuildContext context) {
    return Consumer<AppProvider>(builder: (context, provider, x) {
      return Container(
        color: Colors.white,
        child: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Column(
            //   children: [
            //     Container(
            //       width: 130,
            //       height: 5,
            //       color: Colors.blue.withOpacity(0.5),
            //     ),
            //     SizedBox(
            //       height: 10,
            //     ),
            //     Row(
            //       mainAxisAlignment: MainAxisAlignment.center,
            //       children: [
            //         Container(
            //           margin: EdgeInsets.all(5),
            //           width: 7,
            //           height: 7,
            //           decoration: BoxDecoration(
            //             color: Colors.grey,
            //             shape: BoxShape.circle,
            //           ),
            //         ),
            //         Container(
            //           margin: EdgeInsets.all(5),
            //           width: 7,
            //           height: 7,
            //           decoration: BoxDecoration(
            //             color: Colors.black,
            //             shape: BoxShape.circle,
            //           ),
            //         ),
            //         Container(
            //           margin: EdgeInsets.all(5),
            //           width: 7,
            //           height: 7,
            //           decoration: BoxDecoration(
            //             color: Colors.grey,
            //             shape: BoxShape.circle,
            //           ),
            //         ),
            //       ],
            //     ),
            //     SizedBox(
            //       height: 15,
            //     ),
            //   ],
            // ),
            Container(
              width: double.infinity,
              height: double.infinity,
              margin: EdgeInsetsDirectional.only(start: 16, end: 16, top: 39),
              color: Colors.transparent,
              child: ProductsSection(
                sectionTitle: "تصاميميك الخاصة بك:",
                productsStreamController: usersProductsStream,
                emptyListMessage: "لا يوجد لديك تصاميم بعد !!",
                onProductCardTapped: onProductCardTapped,
              ),

            ),
          ],
        ),
      );
    });
  }

  // Widget build(BuildContext context) {
  //
  //   final courseFeed = [
  //     Course(
  //       id: '#1',
  //       title: 'التفكير الناقد ثالث متوسط-ثلاثة فصول',
  //       description:
  //       'جميع دروس منهج التفكير الناقد - الفصل الأول - وعددها 7 دروس \nبوربوينت مميز وعصري خاص لكل درس بالمنهج.',
  //       coverPhoto:
  //       'https://cdn.salla.sa/Dzmd/cPVSyOSnH9Ue1RUivI4wKc8a9g2WaWCH0tGC5ZZE.png',
  //       enrolled: true,
  //       isAdmin: true,
  //       enrolledId: [],
  //       userProfile: UserProfile(
  //           name: 'mahmoud',
  //           parentId: '',
  //           profile_picture: '',
  //           gmail: 'mm@gmail.com',
  //           uid: '',
  //           createdCourse: [],
  //           enrolledCourse: []),
  //     ),
  //     Course(
  //       id: '#1',
  //       title: 'التفكير الناقد ثالث متوسط-ثلاثة فصول',
  //       description:
  //       'جميع دروس منهج التفكير الناقد - الفصل الأول - وعددها 7 دروس \nبوربوينت مميز وعصري خاص لكل درس بالمنهج.',
  //       coverPhoto:
  //       'https://cdn.salla.sa/Dzmd/cPVSyOSnH9Ue1RUivI4wKc8a9g2WaWCH0tGC5ZZE.png',
  //       enrolled: true,
  //       isAdmin: true,
  //       enrolledId: [],
  //       userProfile: UserProfile(
  //           name: 'mahmoud',
  //           parentId: '',
  //           profile_picture: '',
  //           gmail: 'mm@gmail.com',
  //           uid: '',
  //           createdCourse: [],
  //           enrolledCourse: []),
  //     ),
  //   ];
  //   return courseFeed.length != 0
  //       ? Container(
  //           height: double.infinity,
  //           width: double.infinity,
  //           color: Colors.white,
  //           child: ListView.builder(
  //               itemCount: courseFeed.length,
  //               itemBuilder: (BuildContext context, i) {
  //                 return (AdminCard(courseFeed[i]));
  //               }),
  //         )
  //       : Center(
  //           child: Text(
  //             "لا يوجد بيانات",
  //             style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //           ),
  //         );
  // }

  Future<void> refreshPage() {
    usersProductsStream.reload();
    return Future<void>.value();
  }
  void onProductCardTapped(String productId) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CoursesDetails(productId: productId) ,
      ),
    ).then((_) async {
      await refreshPage();
    });
  }
}
