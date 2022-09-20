
import 'dart:io';

class MyProduct {
  String? id, name, description, highlightCourse, image_url;
  num? price;
  String? userType;
  String? linkOfCourse;
  File? pickedImageFile ;
  String owner_id='' ;
  String? numberOfCourse = '';
  String? categoryOfCourses = '';
  bool isFavoruite = false ,enrolled =false;
  List? enrolledUser = [];
  MyProduct({
    required this.owner_id,
    this.id,
    this.name,
    this.description,
    this.price,
    this.pickedImageFile,
    this.linkOfCourse,
    this.highlightCourse,
    this.categoryOfCourses,
    this.numberOfCourse,
    this.userType,
    this.enrolled = false,
    this.enrolledUser ,
  });


  toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = name;
    map['description'] = description;
    map['price'] = price;
    map['image_url'] = image_url;
    map['linkOfCourse'] = linkOfCourse;
    map['numberOfCourse'] = numberOfCourse;
    map['categoryOfCourses'] = categoryOfCourses;
    map['highlightCourse'] = highlightCourse;
    map['owner_id'] = owner_id;
    map['userType'] = userType;
    map['favourite_products'] = isFavoruite;
    map['enrolled'] = enrolled;
    map['enrolledUser'] = enrolledUser;
    return map;
  }

  MyProduct.fromMap(Map map) {
    this.name = map['name'];
    id = map['id'];
    description = map['description'];
    price = map['price'];
    image_url = map['image_url'];
    owner_id = map['owner_id'];
    numberOfCourse = map['numberOfCourse'];
    highlightCourse = map['highlightCourse'];
    linkOfCourse = map['linkOfCourse'];
    categoryOfCourses = map['categoryOfCourses'];
    userType = map['userType'];
    isFavoruite = map['favourite_products'];
    enrolled = map['enrolled']??false;
    enrolledUser = map['enrolledUser']??[];
  }
}
