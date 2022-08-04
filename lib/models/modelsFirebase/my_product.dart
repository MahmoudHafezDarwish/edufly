
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
    this.userType
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
    categoryOfCourses = map['categoryOfCourses'];
    userType = map['userType'];
  }
}
