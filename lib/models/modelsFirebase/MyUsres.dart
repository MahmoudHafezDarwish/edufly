class MyUser {
  String? id,
      name,
      address,
      phoneNumber,
      email,
      password,
      display_picture;
  List<dynamic>? favourite_products;
  bool isAdmin = false, isFreelancer = false;

  MyUser(
      {this.name,
      this.id,
      this.isAdmin = false,
      this.address,
      this.phoneNumber,
      this.email,
      this.password,
      this.display_picture,
      this.favourite_products,
      this.isFreelancer = false});

  Map<String, dynamic> toMap() {
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
    return map;
  }

  MyUser.fromMap(Map map) {
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
  }
}
