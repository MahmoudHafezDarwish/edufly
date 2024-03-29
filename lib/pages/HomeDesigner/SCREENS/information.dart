import 'package:flutter/material.dart';

import '../../../custom_widgets/widgets/informationWidget.dart';
import '../../../models/course-post.dart';


class CourseInformationPost extends StatefulWidget {
  @override
  static String id = '';
  CourseInformationPost(id1) {
    print(id1);
    id = id1;
  }

  static const routeName = '/CourseInformationPost';
  _CourseInformationPostState createState() => _CourseInformationPostState();
}

class _CourseInformationPostState extends State<CourseInformationPost> {
  @override
  @override
  late List<CoursePost> FeedItems;
  String parentId = CourseInformationPost.id;
  String type = "INFORMATION-POST";
  void initState() {
    super.initState();
    _fetchCoursePostsReq();
  }

  _fetchCoursePostsReq() async {
    List<CoursePost> items =[];
        // Provider.of<CoursePostProvider>(context, listen: false)
        //     .fetchFromProviderCoursePost(parentId, type);
    print(items);
    if (items != null) {
      setState(() {
        FeedItems = items;
      });
    }
  }

  Widget build(BuildContext context) {
    // final course = Provider.of<CoursePostProvider>(context);
    // final FeedItems = course.selectedCourseItems;
    return FeedItems != null
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                itemCount: FeedItems.length,
                itemBuilder: (BuildContext context, i) {
                  return (InformationWidget(FeedItems[i]));
                }))
        : Center(
            child: Text(
              "لا يوجد بيانات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
  }
}
