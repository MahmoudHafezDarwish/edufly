import 'package:flutter/material.dart';

import '../../models/course.dart';
import '../../pages/HomeDesigner/courseNav.dart';

// class FeedCard extends StatefulWidget {
//   @override
//   _FeedCardState createState() => _FeedCardState();
// }

// class _FeedCardState extends State<FeedCard> {
class AdminCard extends StatelessWidget {
  @override
  double borderRadius = 10, padding = 10;
  late var title, description, taughtBy, coverPhoto, id;
  late bool isAdmin, enrolled;
  late Course screenArguments;
  late String finalText;

  void initState() {
    print(screenArguments);
  }

  AdminCard(Course passed) {
    screenArguments = passed;
    print(screenArguments.id);
  }

  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, CourseNav.routeName, arguments: screenArguments);
      },
      child: Container(
        width: double.infinity,
        height: 320,
        margin: EdgeInsets.all(borderRadius),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(borderRadius), boxShadow: [
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
            ClipRRect(
                borderRadius: BorderRadius.circular(borderRadius),
                child: Container(
                  height: 200,
                  width: double.infinity,
                  color: Colors.white,
                  child: Image.network(
                    screenArguments.coverPhoto,
                    fit: BoxFit.cover,
                  ),
                )),
            new Padding(
              padding: EdgeInsets.only(left: padding, top: padding, right: padding),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  new Text(screenArguments.title, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  new Text(
                      screenArguments.enrolledId.length != 0
                          ? '${screenArguments.enrolledId.length} are enrolled'
                          : 'Someone will definetly enroll',
                      textAlign: TextAlign.left,
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400)),
                  Container(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,

                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                        ),
                        child: const Text(
                          'Go to your course',
                          style: TextStyle(color: Colors.white),
                        ),
                        onPressed: () {
                          Navigator.pushNamed(context, CourseNav.routeName, arguments: screenArguments);
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
