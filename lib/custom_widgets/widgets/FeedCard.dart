import 'package:edufly/utile/constants.dart';
import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../../pages/HomeDesigner/SCREENS/courseDetail.dart';
import '../../pages/HomeDesigner/courseNav.dart';
import '../../utile/size_config.dart';

// class FeedCard extends StatefulWidget {
//   @override
//   _FeedCardState createState() => _FeedCardState();
// }

// class _FeedCardState extends State<FeedCard> {
class FeedCard extends StatelessWidget {
  @override
  double borderRadius = 10, padding = 10;
  late var title, description, taughtBy, coverPhoto, id;
  late bool isAdmin, enrolled;
  late Course screenArguments;
  late String finalText;

  void initState() {}

  FeedCard(Course passed) {
    screenArguments = passed;
    print(screenArguments.id);
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (screenArguments.enrolled == false) {
          Navigator.pushNamed(context, CourseDetail.routeName,
              arguments: screenArguments);
          return;
        }
        Navigator.pushNamed(context, CourseNav.routeName,
            arguments: screenArguments);
      },
      child: Container(
        width: double.infinity,
        height: 330,
        margin: EdgeInsets.all(borderRadius),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius),
            boxShadow: [
              BoxShadow(
                blurRadius: 7,
                color: Colors.grey,
                offset: Offset(0, 3),
              ),
            ]),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Hero(
                tag: screenArguments.id,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(borderRadius),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.white,
                      child: Image.network(
                        screenArguments.coverPhoto,
                        fit: BoxFit.cover,
                      ),
                    ))),
            new Padding(
              padding:
                  EdgeInsets.only(left: padding, top: padding, right: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(screenArguments.title,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                          fontFamily: fontBoldFamily)),
                  new Text(
                      ' تم تدريسه من قبل ${screenArguments.userProfile.name}',
                      textAlign: TextAlign.left,

                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w400,
                          fontFamily:fontReqularFamily
                          )),
                  screenArguments.enrolled == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: <Widget>[
                            Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: ElevatedButton(
                                  child: const Text(
                                    'View Course',
                                    style: TextStyle(
                                      color: Colors.black87,
                                    ),
                                  ),
                                  //  color: Colors.black87,
                                  onPressed: () {
                                    Navigator.pushNamed(
                                        context, CourseDetail.routeName,
                                        arguments: screenArguments);
                                  },
                                )),
                            ElevatedButton(
                              child: const Text(
                                'Enroll',
                                style: TextStyle(
                                  color: Colors.black87,
                                ),
                              ),

                              //  color: Theme.of(context).primaryColor,
                              onPressed: () {
                                // Provider.of<CourseProvider>(context,
                                //         listen: false)
                                //     .enrollUser(screenArguments);
                              },
                            ),
                          ],
                        )
                      : Container(
                          width: double.infinity,
                          child: ElevatedButton(
                            child: const Text(
                              'Resume your course',
                              style: TextStyle(color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, CourseNav.routeName,
                                  arguments: screenArguments);
                            },
                          ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
