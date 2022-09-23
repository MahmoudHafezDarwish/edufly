import 'package:Design/custom_widgets/product/enrolled_user_section.dart';
import 'package:Design/pages/courses/CoursesDetail.dart';
import 'package:Design/pages/data_streams/enrolled_users_stream.dart';
import 'package:flutter/material.dart';

class Feed extends StatefulWidget {
  @override
  static const routeName = '/feed';

  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  @override
  late EnrolledUsersStream enrolledUseresStream ;

  void initState() {
    super.initState();
    enrolledUseresStream = EnrolledUsersStream();
    enrolledUseresStream.init();
  }

  void dispose() {
    super.dispose();
    enrolledUseresStream.dispose();

  }

  @override
  double borderRadius = 10, padding = 10;

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsetsDirectional.only(start: 16, end: 16, top: 39),
        color: Colors.transparent,
        child: UsersSection(
          sectionTitle: " المستخدمين أصحاب الطلبات :",
          productsStreamController: enrolledUseresStream,
          emptyListMessage: "لا يوجد لديك طلبات بعد !!",
          onProductCardTapped: onProductCardTapped,
        ),
      ),
    );

  }

  Future<void> refreshPage() {
    enrolledUseresStream.reload();
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
