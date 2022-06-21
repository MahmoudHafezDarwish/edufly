import 'package:edufly/models/course.dart';
import 'package:edufly/models/userProfile.dart';
import 'package:flutter/material.dart';
import '../../../custom_widgets/widgets/adminCard.dart';
import 'createCourse.dart';

class UserHomeFeed extends StatefulWidget {
  @override
  static const routeName = '/UserHomeFeed';

  _userHomeFeedState createState() => _userHomeFeedState();
}

class _userHomeFeedState extends State<UserHomeFeed> {
  @override
  bool _isLoading = false;

  void initState() {}

  void dispose() {
    super.dispose();
  }

  @override
  double borderRadius = 10, padding = 10;

  Widget build(BuildContext context) {
    final course = Course(
        id: 'id',
        title: 'title',
        description: 'description',
        coverPhoto: 'coverPhoto',
        enrolled: false,
        isAdmin: true,
        enrolledId: [],
        userProfile: UserProfile(uid: '',name: '',createdCourse: [],enrolledCourse: [],gmail: '',parentId: '',profile_picture: '' ));
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
      ),  Course(
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
    return courseFeed.length != 0
        ? Container(
            height: double.infinity,
            width: double.infinity,
            color: Colors.white,
            child: ListView.builder(
                itemCount: courseFeed.length,
                itemBuilder: (BuildContext context, i) {
                  return (AdminCard(courseFeed[i]));
                }),
          )
        : Center(
            child: Text(
              "لا يوجد بيانات",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          );
  }
}
