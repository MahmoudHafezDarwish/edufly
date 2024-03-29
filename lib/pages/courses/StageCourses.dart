import 'package:edufly/get/stage_category_contrller.dart';
import 'package:edufly/pages/courses/CoursesDetail.dart';
import 'package:edufly/pages/data_streams/stage_products_stream.dart';
import 'package:edufly/provider/AppProvider.dart';
import 'package:edufly/utile/RouterHelper.dart';
import 'package:edufly/utile/constants.dart';
import 'package:edufly/utile/size_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/instance_manager.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/product/products_section.dart';
import '../../models/courseModel.dart';
import '../../models/quad_clipper.dart';
import '../../theme/color/light_color.dart';
import '../../theme/theme.dart';

class StageCourses extends StatefulWidget {
  const StageCourses({Key? key}) : super(key: key);

  static Widget circularContainer(double height, Color color,
      {Color borderColor = Colors.transparent, double borderWidth = 2}) {
    return Container(
      height: height,
      width: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
        border: Border.all(color: borderColor, width: borderWidth),
      ),
    );
  }

  static Widget itemList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        RouterHelper.routerHelper.pushToSpecificScreenByNameWithoutPop('/CoursesDetails');
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            courceInfo(context, CourseList.list[index], decorationContainerA(Colors.redAccent, -110, -85),
                background: LightColor.seeBlue),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
          ],
        ),
      ),
    );
  }

  static Widget card(BuildContext context, {Color primaryColor = Colors.redAccent, Widget? backWidget}) {
    return Container(
      height: 190,
      width: MediaQuery.of(context).size.width * .34,
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.all(Radius.circular(20)),
          boxShadow: <BoxShadow>[BoxShadow(offset: Offset(0, 5), blurRadius: 10, color: Color(0x12000000))]),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(20)),
        child: backWidget,
      ),
    );
  }

  static Widget courceInfo(BuildContext context, CourseModel model, Widget decoration, {Color? background}) {
    return Container(
        height: 180,
        width: MediaQuery.of(context).size.width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: card(context, primaryColor: background!, backWidget: decoration),
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(height: 15),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: <Widget>[
                      Expanded(
                        child: Text(model.name,
                            style: TextStyle(color: LightColor.purple, fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                      CircleAvatar(
                        radius: 3,
                        backgroundColor: background,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(model.noOfCource,
                          style: TextStyle(
                            color: LightColor.grey,
                            fontSize: 14,
                          )),
                      SizedBox(width: 10),
                      IconButton(
                        onPressed: () {
                          model.isFavoruit = !model.isFavoruit;
                        },
                        icon: Icon(
                          model.isFavoruit ? Icons.favorite : Icons.favorite_outline_outlined,
                          color: model.isFavoruit ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(model.subCategory,
                    style: AppTheme.h6Style.copyWith(
                      fontSize: 12,
                      color: LightColor.grey,
                    )),
                SizedBox(height: 10),
                Text(model.description,
                    style: AppTheme.h6Style.copyWith(fontSize: 12, color: LightColor.extraDarkPurple)),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    chip(model.price, kPrimaryColor, height: 5),
                    SizedBox(
                      width: 5,
                    ),
                    chip(model.tag2, LightColor.seeBlue, height: 5),
                    Spacer(),
                    Visibility(
                      visible: model.addToCart!,
                      child: InkWell(
                        onTap: () {},
                        child: Container(
                          padding: EdgeInsetsDirectional.all(5),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: model.addToCart ? kPrimaryExtraLightColor : kPrimaryColor,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                model.addToCart ? Icons.highlight_remove_rounded : Icons.shopping_cart,
                                color: model.addToCart ? Colors.black : Colors.white,
                              ),
                              Text(
                                model.addToCart ? ' حذف من السلة' : 'إضافة للسلة',
                                style: TextStyle(
                                    color: model.addToCart ? Colors.black : Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: fontFamilayTajawal),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    )
                  ],
                )
              ],
            ))
          ],
        ));
  }

  static Widget chip(String text, Color textColor, {double height = 0, bool isPrimaryCard = false}) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: height),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        color: textColor.withAlpha(isPrimaryCard ? 200 : 50),
      ),
      child: Text(
        text,
        style: TextStyle(color: isPrimaryCard ? Colors.white : textColor, fontSize: 12),
      ),
    );
  }

  static Widget decorationContainerA(Color primaryColor, double top, double left) {
    return Stack(
      children: <Widget>[
        Positioned(
          top: top,
          left: left,
          child: CircleAvatar(
            radius: 100,
            backgroundColor: LightColor.darkseeBlue,
          ),
        ),
        smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: circularContainer(80, Colors.transparent, borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child: CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  static Positioned smallContainer(Color primaryColor, double top, double left, {double radius = 10}) {
    return Positioned(
        top: top,
        left: left,
        child: CircleAvatar(
          radius: radius,
          backgroundColor: primaryColor.withAlpha(255),
        ));
  }

  @override
  State<StageCourses> createState() => _StageCoursesState();
}

class _StageCoursesState extends State<StageCourses> {
  Widget _categoryRow(BuildContext context, String title) {
    return Container(
      // margin: EdgeInsets.symmetric(horizontal: 20),
      // height: 68,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              title,
              style: TextStyle(color: LightColor.extraDarkPurple, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: MediaQuery.of(context).size.width,
              height: 30,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: <Widget>[
                  SizedBox(width: 20),
                  StageCourses.chip("العلوم", kPrimaryColor, height: 5),
                  SizedBox(width: 10),
                  StageCourses.chip("الدراسات الاجتماعية", LightColor.seeBlue, height: 5),
                  SizedBox(width: 10),
                  StageCourses.chip("المهارات التقنية", LightColor.orange, height: 5),
                  SizedBox(width: 10),
                  StageCourses.chip("اللغة العربية", LightColor.lightBlue, height: 5),
                  SizedBox(width: 10),
                  StageCourses.chip("اللغة الانجليزية", LightColor.yellow, height: 5),
                ],
              )),
          SizedBox(height: 10)
        ],
      ),
    );
  }

  Widget _courseList(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            StageCourses.courceInfo(
                context, CourseList.list[0], StageCourses.decorationContainerA(Colors.redAccent, -110, -85),
                background: LightColor.seeBlue),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            StageCourses.courceInfo(context, CourseList.list[1], _decorationContainerB(),
                background: LightColor.darkOrange),
            Divider(
              thickness: 1,
              endIndent: 20,
              indent: 20,
            ),
            StageCourses.courceInfo(context, CourseList.list[2], _decorationContainerC(),
                background: LightColor.lightOrange2),
          ],
        ),
      ),
    );
  }

  Widget _courseListView(BuildContext context) {
    return ListView.builder(
        itemCount: CourseList.list.length,
        itemBuilder: (context, index) {
          return StageCourses.itemList(context, index);
        });
  }

  Widget _decorationContainerB() {
    return Stack(
      children: <Widget>[
        Positioned(
          top: -65,
          left: -65,
          child: CircleAvatar(
            radius: 70,
            backgroundColor: LightColor.lightOrange2,
            child: CircleAvatar(radius: 30, backgroundColor: LightColor.darkOrange),
          ),
        ),
        Positioned(bottom: -35, right: -40, child: CircleAvatar(backgroundColor: LightColor.yellow, radius: 40)),
        Positioned(
          top: 50,
          left: -40,
          child: StageCourses.circularContainer(70, Colors.transparent, borderColor: Colors.white),
        ),
      ],
    );
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
            child:
                ClipRect(clipper: QuadClipper(), child: CircleAvatar(backgroundColor: LightColor.yellow, radius: 40))),
        StageCourses.smallContainer(
          Colors.yellow,
          35,
          70,
        ),
      ],
    );
  }

  late final StageProductsStream stageProductsStream = StageProductsStream();
  final StageController ctrl = Get.find();

  @override
  void initState() {
    stageProductsStream.stageCategory = ctrl.stage;
    stageProductsStream.init();
    super.initState();
  }

  @override
  void dispose() {
    stageProductsStream.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // String stageCourse = Provider.of<AppProvider>(context).selectedProductCategory;
    // final sc = ModalRoute.of(context)!.settings.arguments as String;
    return Scaffold(
      body: Container(
        padding: EdgeInsetsDirectional.only(top: 10),
        child: Stack(
          children: [
            Positioned(top: 40, left: 0, right: 0, child: _categoryRow(context, ctrl.stage)),
            Positioned(
              top: 120,
              left: 0,
              right: 0,
              height: SizeConfig.screenHeight * 0.9,
              child: ProductsSection(
                sectionTitle: "منهج ${ctrl.stage}:",
                productsStreamController: stageProductsStream,
                emptyListMessage: "لا يوجد تصاميم بعد !!",
                onProductCardTapped: onProductCardTapped,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> refreshPage() {
    stageProductsStream.reload();
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
