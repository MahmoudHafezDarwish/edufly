
import 'dart:io';

class MyProduct {
  String? id, name, description, image_url;
  num? price;
  String? linkOfCourse;
  File? pickedImageFile ;
  String owner_id='' ;
  MyProduct({
    required this.owner_id,
    this.id,
    this.name,
    this.description,
    this.price,
    this.pickedImageFile,
    this.linkOfCourse
  });


  toMap() {
    Map<String, dynamic> map = Map<String, dynamic>();
    map['name'] = this.name;
    map['description'] = this.description;
    map['price'] = this.price;
    map['image_url'] = this.image_url;
    map['linkOfCourse'] = this.linkOfCourse;
    map['owner_id'] = this.owner_id;
    return map;
  }

  MyProduct.fromMap(Map map) {
    this.name = map['name'];
    this.id = map['id'];
    this.description = map['description'];
    this.price = map['price'];
    this.image_url = map['image_url'];
    this.owner_id = map['owner_id'];
  }
}
