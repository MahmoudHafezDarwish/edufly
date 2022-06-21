import 'package:edufly/custom_widgets/widgets/dotted_text.dart';
import 'package:edufly/utile/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../custom_widgets/widgets/imag_slider.dart';
import '../../models/quad_clipper.dart';
import '../../theme/color/light_color.dart';
import 'package:carousel_slider/carousel_slider.dart';

import '../../theme/theme.dart';

class CoursesDetails extends StatelessWidget {
  const CoursesDetails({Key? key}) : super(key: key);

  Positioned _smallContainer(Color primaryColor, double top, double left,
      {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  Widget _decorationContainerC() {
    return Stack(
      children: <Widget>[
        Positioned(
          bottom: -65,
          left: -35,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: Color(0xfffeeaea),
          ),
        ),
        Positioned(
            bottom: -30,
            right: -25,
            child: ClipRect(
                clipper: QuadClipper(),
                child: CircleAvatar(
                    backgroundColor: LightColor.yellow, radius: 40))),
        _smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }

  Widget _card(BuildContext context,
      {Color primaryColor = Colors.redAccent, Widget? backWidget}) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width * .34,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[
            BoxShadow(
                offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))
          ]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: backWidget,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsetsDirectional.only(top: 5, start: 8, end: 8),
        child: Column(
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
                        ImagSlider()
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
              'علوم رابع ابتدائي الفصل الثاني',
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
                    ' السعر : 99  ر.س ',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontFamily: fontFamilayTajawal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Text(
                    '150ر.س ',
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontFamily: fontFamilayTajawal,
                        fontWeight: FontWeight.normal,
                        decorationStyle: TextDecorationStyle.solid,
                        decoration: TextDecoration.lineThrough),
                  ),
                  Spacer(),
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
                  onPressed: () {},
                  icon: Icon(
                    size: 35,
                    Icons.favorite,
                    color: Colors.red,
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                // Text(
                //   ' تم شراءه وتم تقييمه 40 مرة',
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontFamily: "BesleyBlack",
                //     fontWeight: FontWeight.normal,
                //     fontSize: 12,
                //     decorationStyle: TextDecorationStyle.dashed,
                //   ),
                // ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              height: 5,
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
            // RichText(
            //
            //   text: TextSpan(
            //     text:
            //         ' \u2022 جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول',
            //     style: TextStyle(
            //       color: Colors.black,
            //       fontFamily: fontFamilayTajawal,
            //       fontWeight: FontWeight.normal,
            //       fontSize: 14,
            //     ),
            //     children: const <TextSpan>[
            //
            //       TextSpan(
            //           text:
            //               ' تمت إضافة استراتيجيات تعلّم نشط داخل بوربوينت الدرس.'),
            //       TextSpan(
            //           text: '.', style: TextStyle(fontWeight: FontWeight.bold)),
            //       TextSpan(
            //           text:
            //               '\n تمت إضافة استراتيجيات تعلّم نشط داخل بوربوينت الدرس.'),
            //     ],
            //   ),
            // ),

            DottedText(
              'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'بوربوينت مميز وبشرح سلس ومبسط لكل درس بالمنهج.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'تمت إضافة استراتيجيات تعلّم نشط داخل بوربوينت الدرس.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'فيديو لكل درس داخل البوربوينت.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'ورقة عمل لكل درس.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'أوارق الاستراتيجيات المستخدمة ( إن لزم لها ).',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'تحضير ثلاثي بالاستراتيجيات المستخدمة بالدرس.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'ملحقات التحضير ( التوزيع , المسرد المفرغ , غلاف التحضير , الأهداف العامة والخاصة ).',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
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
              'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'بوربوينت مميز وبشرح سلس ومبسط لكل درس بالمنهج.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'جميع دروس المنهج وعددها 7 دروس بحسب نظام الثلاثة فصول.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'تمت إضافة استراتيجيات تعلّم نشط داخل بوربوينت الدرس.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'فيديو لكل درس داخل البوربوينت.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'ورقة عمل لكل درس.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'أوارق الاستراتيجيات المستخدمة ( إن لزم لها ).',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'تحضير ثلاثي بالاستراتيجيات المستخدمة بالدرس.',
              style: TextStyle(
                color: Colors.black,
                fontFamily: fontFamilayTajawal,
                fontWeight: FontWeight.normal,
                fontSize: 14,
              ),
            ),
            DottedText(
              'ملحقات التحضير ( التوزيع , المسرد المفرغ , غلاف التحضير , الأهداف العامة والخاصة ).',
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
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
