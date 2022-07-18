import 'dart:io';

import 'package:edufly/utile/size_config.dart';
import 'package:flutter/foundation.dart';
import '../models/userProfile.dart';

class Course {
  final String title, description, coverPhoto, id;
  final List<dynamic> enrolledId;
  bool isAdmin, enrolled;
  UserProfile userProfile;


  Course({
    required this.id,
    required this.title,
    required this.description,
    required this.coverPhoto,
    required this.enrolled,
    required this.isAdmin,
    required this.enrolledId,
    required this.userProfile,
  });

  void set setEnrolled(bool value) {
    this.enrolled = value;
  }

  void  n_rolled(bool value,bool d) {
    this.enrolled = value;
  }

  Course.constructor_name({
    required this.id,
    required this.title,
    required this.description,
    required this.coverPhoto,
    required this.enrolled,
    required this.isAdmin,
    required this.enrolledId,
    required this.userProfile,
  });
}
