import 'package:edufly/models/course.dart';
import 'package:edufly/models/userProfile.dart';
import 'package:flutter/material.dart';
import '../../../custom_widgets/widgets/FeedCard.dart';
import 'createCourse.dart';

class Feed extends StatefulWidget {
  @override
  static const routeName = '/feed';

  _FeedState createState() => _FeedState();
}

class _FeedState extends State<Feed> {
  @override
  @override
  bool _isLoading = false;

  void initState() {
    super.initState();
    print('init called');
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // _fetchCourse();
    });
  }

  void dispose() {
    super.dispose();
  }

  //
  // _fetchCourse() async {
  //   try {
  //     if (!mounted) {
  //       print('not mounted');
  //       return;
  //     }
  //     final course = Provider.of<CourseProvider>(context, listen: false);
  //     final requestMade = course.requestMade;
  //     if (requestMade == false) {
  //       setState(() {
  //         _isLoading = true;
  //       });
  //       await Provider.of<CourseProvider>(context, listen: false).fetchCourse();
  //       setState(() {
  //         _isLoading = false;
  //       });
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }

  @override
  double borderRadius = 10, padding = 10;

  Widget build(BuildContext context) {
    // final course = Provider.of<CourseProvider>(context);
    // final courseFeed = course.feedCourse;
    final courseFeed = [
      Course(
          id: '#1',
          title: 'التفكير الناقد ثالث متوسط-ثلاثة فصول',
          description:
              'جميع دروس منهج التفكير الناقد - الفصل الأول - وعددها 7 دروس \nبوربوينت مميز وعصري خاص لكل درس بالمنهج.',
          coverPhoto:
              'https://cdn.salla.sa/Dzmd/cPVSyOSnH9Ue1RUivI4wKc8a9g2WaWCH0tGC5ZZE.png',
          enrolled: true,
          isAdmin: true,
          enrolledId: [],
          userProfile: UserProfile(
              name: 'mahmoud',
              parentId: '',
              profile_picture: '',
              gmail: 'mm@gmail.com',
              uid: '',
              createdCourse: [],
              enrolledCourse: []),
      ),
      Course(
          id: '#1',
          title: 'التفكير الناقد ثالث متوسط-ثلاثة فصول',
          description:
              'جميع دروس منهج التفكير الناقد - الفصل الأول - وعددها 7 دروس \nبوربوينت مميز وعصري خاص لكل درس بالمنهج.',
          coverPhoto:
              'https://cdn.salla.sa/Dzmd/cPVSyOSnH9Ue1RUivI4wKc8a9g2WaWCH0tGC5ZZE.png',
          enrolled: true,
          isAdmin: true,
          enrolledId: [],
          userProfile: UserProfile(
              name: 'mahmoud',
              parentId: '',
              profile_picture: '',
              gmail: 'mm@gmail.com',
              uid: '',
              createdCourse: [],
              enrolledCourse: []),
      ),
    ];
    return _isLoading == false
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                itemCount: courseFeed.length,
                itemBuilder: (BuildContext context, i) {
                  return (FeedCard(
                    courseFeed[i],
                  ));
                }),
          )
        : Center(child: CircularProgressIndicator());
    ;
  }
}
