import 'package:Design/models/modelsFirebase/MyUsres.dart';

class Freelancer extends MyUser {
  String freelancerCategory = 'Designer';

  Freelancer(
      {required this.freelancerCategory,
      name,
      id,
      isAdmin = false,
      address,
      phoneNumber,
      email,
      password,
      display_picture,
      favourite_products,
      isFreelancer = false})
      : super(
            isFreelancer: isFreelancer,
            favourite_products: favourite_products,
            display_picture: display_picture,
            password: password,
            email: email,
            phoneNumber: phoneNumber,
            address: address,
            isAdmin: isAdmin,
            id: id,
            name: name);
  @override
  Map<String, dynamic> toMap(){
      Map<String, dynamic> map = Map<String, dynamic>();
      map['firstName'] = this.name;
      map['id'] = this.id;
      map['lastName'] = this.address;
      map['phoneNumber'] = this.phoneNumber;
      map['email'] = this.email;
      map['password'] = this.password;
      map['display_picture'] = this.display_picture;
      map['favourite_products'] = this.favourite_products;
      map['isFreelancer'] = this.isFreelancer;
      map['freelancerCategory'] = this.freelancerCategory;
      return map;
  }

  @override
  Freelancer.fromMap(Map map){
      this.name = map['firstName'];
      this.id = map['id'];
      this.address = map['lastName'];
      this.phoneNumber = map['phoneNumber'];
      this.email = map['email'];
      this.password = map['password'];
      this.display_picture = map['display_picture'];
      this.favourite_products = map['favourite_products'];
      this.isAdmin = map['isAdmin'] ?? false;
      this.isFreelancer = map['isFreelancer'] ?? false;
      this.freelancerCategory = map['freelancerCategory'] ?? 'Designer';
  }
}
