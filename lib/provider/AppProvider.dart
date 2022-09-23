import 'dart:io';

import 'package:Design/models/modelsFirebase/consulting.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loggy/loggy.dart';

import '../custom_widgets/widgets/user_type_radio.dart';
import '../data/AuthFirebas.dart';
import '../data/firebase_firestore.dart';
import '../models/modelsFirebase/MyUsres.dart';
import '../models/modelsFirebase/my_product.dart';
import '../pages/HomeDesigner/mainNav.dart';
import '../pages/auth/login_screen.dart';
import '../preferences/shared_pref_controller.dart';
import '../utile/RouterHelper.dart';
import '../utile/tost.dart';

class AppProvider extends ChangeNotifier {
  AppProvider() {
    // getAllProduct();
  }

  SingingCharacter? userType;

  setUserType(SingingCharacter? singingCharacter) {
    userType = singingCharacter;
    notifyListeners();
  }

  String freelancerCategory = 'Designer';
  String selectedProductCategory = 'المرحلة الإعدادية';

  setSelectedCategory(String selected) {
    selectedProductCategory = selected;
    notifyListeners();
  }

  setFreelancerCategory(String value) {
    freelancerCategory = value;
    notifyListeners();
  }

  MyUser? loggedUser;

  String? image_url;
  File? file;
  List<MyProduct> allProduct = [];
  String category = 'Hand bag';

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();

  getAllProduct() async {
    // await MyFirebaseFireStore.myFirebaseFireStore.getAllProducts();
    this.allProduct = await MyFirebaseFireStore.myFirebaseFireStore.getOwnerProducts(this.freelancerCategory);
    notifyListeners();
  }

  pickNewImage() async {
    XFile? file = await ImagePicker().pickImage(source: ImageSource.gallery);
    this.file = File(file!.path);
    notifyListeners();
  }

  signUp(MyUser myUser) async {
    try {
      String? userId = await MyAuthFirebase.instance.creatAccount(myUser.email!, myUser.password!);
      myUser.id = userId;
      await MyFirebaseFireStore.myFirebaseFireStore.createUserInFs(myUser);
      this.loggedUser = myUser;
      // if (this.loggedUser != null) {
      //   await SharedPrefController().save(user: this.loggedUser!);
      //   logInfo('is save logged user${loggedUser!.isFreelancer}');
      // }
      if (!myUser.isFreelancer) {
        RouterHelper.routerHelper.pushToSpecificScreenByNameWithPop('/main');
      } else {
        RouterHelper.routerHelper.pushToSpecificScreenByNameWithPop(MainNav.routeName);
      }
      ToastMessage.showToast("تم تسجيل الحساب", true);
    } on Exception catch (e) {
      ToastMessage.showToast("Is Exception", false);
      print('Excepton toString : ${e.toString()} :: runtimeType ${e.runtimeType}');
    }
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential? userCredential = await MyAuthFirebase.instance.sigIn(email, password);
      MyUser? myUser = await getUserFromFirebase();
      if (myUser != null) {
        if (userCredential != null) {
          ToastMessage.showToast("تم تسجيل الدخول", true);
          if (this.loggedUser!.isFreelancer) {
            RouterHelper.routerHelper.pushToSpecificScreenByNameWithPop(MainNav.routeName);
          } else {
            RouterHelper.routerHelper.pushToSpecificScreenByNameWithPop('/main');
          }
          if (this.loggedUser != null) {
            await SharedPrefController().save(user: this.loggedUser!);
            logInfo('is save logged user');
          }
          return true;
        } else {
          ToastMessage.showToast("يجب التحقق من الإيميل", false);
        }
      } else {
        ToastMessage.showToast('ليس لديك حساب في التطبيق', false);
      }
    } on Exception catch (e) {
      print('Excepton toString : ${e.toString()} :: runtimeType ${e.runtimeType}');
      ToastMessage.showToast("هناك مشكلة ما", false);
    }
    return false;
  }

  bool get isFreelancer {
    logInfo('${this.loggedUser?.isFreelancer}');
    bool utype = SharedPrefController().getValueFor<bool>(key: PrefKeys.userIsFreelancer.name) ?? false;
    return utype;
  }

  Future<MyUser?> getUserFromFirebase() async {
    String userid = FirebaseAuth.instance.currentUser!.uid;
    MyUser? myUser = await MyFirebaseFireStore.myFirebaseFireStore.getUserFromFs(userid);
    this.loggedUser = myUser;
    notifyListeners();
    return myUser;
  }

  Future<bool> deleteUserData() async {
    try {
      await MyFirebaseFireStore.myFirebaseFireStore.deleteCurrentUserData();
      await MyAuthFirebase.instance.deleteUserAccount();
      return true;
    } on Exception catch (exception) {
      return false;
    }
  }

  logout() async {
    this.loggedUser = null;
    await MyAuthFirebase.instance.logout();
    await SharedPrefController().logout();
    RouterHelper.routerHelper.routingToSpecificWidget(LoginScreen());
    print('log out');
  }

  addProduct(MyProduct product) async {
    String image_url = await MyFirebaseFireStore.myFirebaseFireStore.uploadImage(product.pickedImageFile!);
    // MyProduct product = MyProduct(
    //     image_url: image_url,
    //     description: descriptionController.text,
    //     price: num.parse(priceController.text),
    //     name: nameController.text);
    product.image_url = image_url;
    // await MyFirebaseFireStore.myFirebaseFireStore.addProduct(product, freelancerCategory);
    await MyFirebaseFireStore.myFirebaseFireStore.addDesignerProduct(product, freelancerCategory);
    // getAllProduct();
    Navigator.of(RouterHelper.routerHelper.routerKey.currentState!.context).pop();
  }

  Future<String> addConsulting(Consulting consulting) async {
    return await MyFirebaseFireStore.myFirebaseFireStore.addConsulting(consulting);
  }

  Future<bool> addToCart(String productId) async {
    return await MyFirebaseFireStore.myFirebaseFireStore.addProductToCart(productId!);
  }

  // editProduct(String productId) async {
  //   if (file != null) {
  //     this.image_url =
  //         await MyFirebaseFireStore.myFirebaseFireStore.uploadImage(this.file!);
  //   }
  //   MyProduct product = MyProduct(
  //       description: descriptionController.text,
  //       price: num.parse(priceController.text),
  //       name: nameController.text,
  //
  //   );
  //   product.image_url = image_url;
  //   await MyFirebaseFireStore.myFirebaseFireStore
  //       .editProduct(product, freelancerCategory);
  //   getAllProduct();
  //   Navigator.of(RouterHelper.routerHelper.routerKey.currentState!.context)
  //       .pop();
  // }

  goToEditProduct(MyProduct product) {
    this.file = null;
    this.nameController.text = product.name!;
    this.descriptionController.text = product.description!;
    this.priceController.text = product.price.toString();
    this.image_url = product.image_url!;
    notifyListeners();
    // RouterHelper.routerHelper.routingToSpecificWidgetWithoutPop(AddNewProduct(
    //   isForEdit: true,
    //   productId: product.id,
    // ));
  }

  deleteProduct(MyProduct productiD) async {
    await MyFirebaseFireStore.myFirebaseFireStore.deleteProduct(productiD, freelancerCategory);
    getAllProduct();
  }
}
