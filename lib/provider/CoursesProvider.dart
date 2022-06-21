import 'package:flutter/material.dart';

import '../models/course.dart';

class CoursesProvider extends ChangeNotifier{
  late Course course;
  List<Course> feedCourse = [];
  List<Course> userCourse = [];
  List<Course> enrolledCourse = [];


  void creatUser(Course newCourse ){

  }
}