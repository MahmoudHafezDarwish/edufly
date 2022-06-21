import 'package:edufly/pages/courses/StageCourses.dart';
import 'package:flutter/material.dart';

import '../../models/courseModel.dart';
import '../../theme/color/light_color.dart';
import '../../theme/theme.dart';
import '../../utile/RouterHelper.dart';
import '../../utile/constants.dart';
import '../../utile/size_config.dart';

class FavouriteScreen extends StatelessWidget {
  FavouriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryColor,

        title: Text(
          "المفضلة",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 22,
            fontFamily: "Besley-Regular",
            color: Colors.white,
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsetsDirectional.only(top: 10),
        // child: Column(
        //   children: <Widget>[
        //     SizedBox(height: 20),
        //     _categoryRow(context, "المرحلة الابتدائية"),
        //     _courseList(context),
        //   ],
        // ),
        child: Stack(
          children: [
            // Positioned(
            //     top: 50,
            //     left: 0,
            //     right: 30,
            //     child: Text(
            //       "المفضلة",
            //       style: TextStyle(
            //         fontWeight: FontWeight.normal,
            //         fontSize: 22,
            //         fontFamily: "Besley-Regular",
            //         color: kPrimaryColor,
            //       ),
            //     )),
            Positioned(
                top: 20,
                left: 0,
                right: 0,
                height: SizeConfig.screenHeight * 0.9,
                child: _courseListView(context)),
          ],
        ),
      ),
    );
  }

  List fav_list =
      CourseList.list.where((element) => element.isFavoruit).toList();

  Widget _courseListView(BuildContext context) {
    return ListView.builder(
        itemCount: fav_list.length,
        itemBuilder: (context, index) {
          return _itemList(context, index);
        });
  }

  Widget _decorationContainerA(Color primaryColor, double top, double left) {
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
        StageCourses.smallContainer(LightColor.yellow, 40, 20),
        Positioned(
          top: -30,
          right: -10,
          child: StageCourses.circularContainer(80, Colors.transparent,
              borderColor: Colors.white),
        ),
        Positioned(
          top: 110,
          right: -50,
          child: CircleAvatar(
            radius: 60,
            backgroundColor: LightColor.darkseeBlue,
            child:
                CircleAvatar(radius: 40, backgroundColor: LightColor.seeBlue),
          ),
        ),
      ],
    );
  }

  Widget _itemList(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        RouterHelper.routerHelper
            .pushToSpecificScreenByNameWithoutPop('/CoursesDetails');
      },
      child: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            _courceInfo(context, CourseList.list[index],
                _decorationContainerA(Colors.redAccent, -110, -85),
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

  Widget _courceInfo(BuildContext context, CourseModel model, Widget decoration,
      {Color? background}) {
    return Container(
        height: 180,
        width: MediaQuery.of(context).size.width - 20,
        child: Row(
          children: <Widget>[
            AspectRatio(
              aspectRatio: .7,
              child: _card(context,
                  primaryColor: background!, backWidget: decoration),
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
                            style: TextStyle(
                                color: LightColor.purple,
                                fontSize: 16,
                                fontWeight: FontWeight.bold)),
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
                          model.isFavoruit
                              ? Icons.favorite
                              : Icons.favorite_outline_outlined,
                          color: model.isFavoruit ? Colors.red : Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Text(model.university,
                    style: AppTheme.h6Style.copyWith(
                      fontSize: 12,
                      color: LightColor.grey,
                    )),
                SizedBox(height: 10),
                Text(model.description,
                    style: AppTheme.h6Style.copyWith(
                        fontSize: 12, color: LightColor.extraDarkPurple)),
                SizedBox(height: 15),
                Row(
                  children: <Widget>[
                    StageCourses.chip(model.tag1, kPrimaryColor, height: 5),
                    SizedBox(
                      width: 5,
                    ),
                    StageCourses.chip(model.tag2, LightColor.seeBlue,
                        height: 5),
                    Spacer(),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsetsDirectional.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                          color: kPrimaryColor,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.shopping_cart,
                              color: Colors.white,
                            ),
                            Text(
                              'إضافة للسلة',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 16),
                            )
                          ],
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
}
