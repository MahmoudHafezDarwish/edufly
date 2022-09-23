import 'package:Design/custom_widgets/product/products_section.dart';
import 'package:Design/pages/courses/CoursesDetail.dart';
import 'package:Design/pages/data_streams/enrolled_products_stream.dart';
import 'package:flutter/material.dart';


class EnrolledCourse extends StatefulWidget {
  @override
  static const routeName = '/EnrolledCourse';

  _enrolledCourseState createState() => _enrolledCourseState();
}

class _enrolledCourseState extends State<EnrolledCourse> {
  late EnrolledProductsStream enrolledProductsStream;

  @override
  void initState() {
    super.initState();
    enrolledProductsStream = EnrolledProductsStream();
    enrolledProductsStream.init();
  }

  @override
  void dispose() {
    super.dispose();
    enrolledProductsStream.dispose();
  }

  double borderRadius = 10, padding = 10;

  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            margin: EdgeInsetsDirectional.only(start: 16, end: 16, top: 39),
            color: Colors.transparent,
            child: ProductsSection(
              sectionTitle: " طلبات المسجلة :",
              productsStreamController: enrolledProductsStream,
              emptyListMessage: "لا يوجد لديك تصاميم بعد !!",
              onProductCardTapped: onProductCardTapped,
            ),
          ),
        ],
      ),
    );
  }

  Future<void> refreshPage() {
    enrolledProductsStream.reload();
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
