import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:Design/models/modelsFirebase/Address.dart';
import 'package:Design/models/modelsFirebase/CartItem.dart';
import 'package:Design/models/modelsFirebase/MyUsres.dart';
import 'package:Design/models/modelsFirebase/OrderedProduct.dart';
import 'package:Design/models/modelsFirebase/Product.dart';
import 'package:Design/models/modelsFirebase/Review.dart';
import 'package:Design/models/modelsFirebase/consulting.dart';
import 'package:Design/models/modelsFirebase/my_product.dart';
import 'package:enum_to_string/enum_to_string.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../utile/tost.dart';

class MyFirebaseFireStore {
  MyFirebaseFireStore._();

  static MyFirebaseFireStore _myFirebaseFireStore = MyFirebaseFireStore._();

  FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  FirebaseStorage _storage = FirebaseStorage.instance;

  static const String USERS_COLLECTION_NAME = "MyUser";
  static const String ADDRESSES_COLLECTION_NAME = "addresses";
  static const String CART_COLLECTION_NAME = "cart";
  static const String ORDERED_PRODUCTS_COLLECTION_NAME = "ordered_products";

  static const String PHONE_KEY = 'phoneNumber';
  static const String DP_KEY = "display_picture";
  static const String FAV_PRODUCTS_KEY = "favourite_products";
  static const String ENROLED_USER_PRODUCTS_KEY = "enrolledUser";

  //collection references
  static final CollectionReference users = _myFirebaseFireStore._firebaseFirestore.collection("MyUser");
  static final CollectionReference categories = _myFirebaseFireStore._firebaseFirestore.collection("categories");


  static MyFirebaseFireStore get myFirebaseFireStore {
    return _myFirebaseFireStore;
  }

  /**@
   * User Database Helper Start
   * */

  /// @Class
  /// User Database Helper
  /// user info
  /// 1- creat User
  /// 2-create User In Firebase.
  /// 3-delete Current User Data
  /// Favourite
  /// 4- Check is Product Favourite
  /// 5- get users Favourite Products List
  /// 6- switch Product Favourite Status
  /// addresses
  /// 7- get addresses List
  /// 8- get get Address From Id
  /// 9- add Address ForCurrent User
  /// 10- delete Address For CurrentUser
  /// 11 - updateAddressForCurrentUser
  /// cart
  /// 12 - get Cart Item FromId
  /// 13 -add Product To Cart
  /// 14 -remove Product From Cart
  /// 15 -empty Cart
  /// 16 -+++++increase Cart ItemCount++++
  /// 17 ----decrease Cart Item Count----
  /// 18 -get all Cart Items List
  /// ordered Products
  /// 19 - get ordered Products List
  ///20 - add To My Orders
  ///21 - getOrderedProductFromId
  ///22 - current UserData Stream
  ///23 - update Phone For Current User
  /////24 - upload Display Picture For Current User
  //25 - remove Display Picture For Current User
  //26 -  Display Picture For Current User

  /// */

// 1- creat User
  Future<bool> creatUser(MyUser myUser) async {
    try {
      DocumentReference documentReference =
          await _firebaseFirestore.collection(USERS_COLLECTION_NAME).add(myUser.toMap());

      print('ID FIRE${documentReference.id}');
      return true;
    } on FirebaseException catch (e) {
      print("FirebaseException :::$e");
    } catch (e) {
      print("FirebaseException :::$e");
    }
    return false;
  }

  // 2-create User In Firebase.
  createUserInFs(MyUser myUser) async {
    _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(myUser.id).set(myUser.toMap());

    // if(myUser.isFreelancer){
    //   _firebaseFirestore.collection(Freelancer_USERS_COLLECTION_NAME).doc(myUser.id).set(myUser.toMap());
    // }else{
    //   _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(myUser.id).set(myUser.toMap());
    //
    // }
  }

  /// 3-delete Current User Data

  Future<void> deleteCurrentUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;

    final docRef = _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid);
    final cartCollectionRef = docRef.collection(CART_COLLECTION_NAME);
    final ordersCollectionRef = docRef.collection(ORDERED_PRODUCTS_COLLECTION_NAME);

    final cartDocs = await cartCollectionRef.get();
    for (final cartDoc in cartDocs.docs) {
      await cartCollectionRef.doc(cartDoc.id).delete();
    }
    final ordersDoc = await ordersCollectionRef.get();
    for (final orderDoc in ordersDoc.docs) {
      await ordersCollectionRef.doc(orderDoc.id).delete();
    }

    await docRef.delete();
  }

  /// 4- Check is Product Favourite

  Future<bool> isProductFavourite(String productId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDocSnapshot = _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid);
    final userDocData = (await userDocSnapshot.get()).data();
    final favList = userDocData![FAV_PRODUCTS_KEY]?.cast<String>();
    if (favList.contains(productId)) {
      return true;
    } else {
      return false;
    }
  }

  /// 5- get users Favourite Products List

  Future<List> get usersFavouriteProductsList async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDocSnapshot = _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid);
    final userDocData = (await userDocSnapshot.get()).data();
    final favList = userDocData![FAV_PRODUCTS_KEY];
    return favList;
  }

  /// 6- switch Product Favourite Status

  Future<bool> switchProductFavouriteStatus(String productId, bool newState) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDocSnapshot = _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid);
    if (newState == true) {
      userDocSnapshot.update({
        FAV_PRODUCTS_KEY: FieldValue.arrayUnion([productId])
      });
    } else {
      userDocSnapshot.update({
        FAV_PRODUCTS_KEY: FieldValue.arrayRemove([productId])
      });
    }
    return true;
  }

  /// 7- get addresses List

  Future<List<String>> get addressesList async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final snapshot =
        await _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(ADDRESSES_COLLECTION_NAME).get();
    final addresses = <String>[];
    snapshot.docs.forEach((doc) {
      addresses.add(doc.id);
    });

    return addresses;
  }

  /// 8- get get Address From Id

  Future<Address> getAddressFromId(String id) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _firebaseFirestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ADDRESSES_COLLECTION_NAME)
        .doc(id)
        .get();
    final address = Address.fromMap(doc.data()!, id: doc.id);
    return address;
  }

  /// 9- add Address ForCurrent User

  Future<bool> addAddressForCurrentUser(Address address) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final addressesCollectionReference =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(ADDRESSES_COLLECTION_NAME);
    await addressesCollectionReference.add(address.toMap());
    return true;
  }

  /// 10- delete Address For CurrentUser

  Future<bool> deleteAddressForCurrentUser(String id) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final addressDocReference =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(ADDRESSES_COLLECTION_NAME).doc(id);
    await addressDocReference.delete();
    return true;
  }

  /// 11 - updateAddressForCurrentUser

  Future<bool> updateAddressForCurrentUser(Address address) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final addressDocReference = _firebaseFirestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ADDRESSES_COLLECTION_NAME)
        .doc(address.id);
    await addressDocReference.update(address.toMap());
    return true;
  }

  /// 12 - get Cart Item FromId

  Future<CartItem> getCartItemFromId(String id) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollectionRef =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(id);
    final docSnapshot = await docRef.get();
    final cartItem = CartItem.fromMap(docSnapshot.data()!, id: docSnapshot.id);
    return cartItem;
  }

  // 13 -add Product To Cart

  Future<bool> addProductToCart(String productId) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollectionRef =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(productId);
    final docSnapshot = await docRef.get();
    bool alreadyPresent = docSnapshot.exists;
    if (alreadyPresent == false) {
      docRef.set(CartItem(itemCount: 1, id: '').toMap());
    } else {
      docRef.update({CartItem.ITEM_COUNT_KEY: FieldValue.increment(1)});
    }
    return true;
  }

  /// 14 -remove Product From Cart

  Future<bool> removeProductFromCart(String cartItemID) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollectionReference =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME);
    await cartCollectionReference.doc(cartItemID).delete();
    return true;
  }

  /// 15 -empty Cart

  Future<List> emptyCart() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final cartItems =
        await _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME).get();
    List orderedProductsUid = <String>[];
    for (final doc in cartItems.docs) {
      orderedProductsUid.add(doc.id);
      await doc.reference.delete();
    }
    return orderedProductsUid;
  }

  /// cartTotal
  Future<num> get cartTotal async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final cartItems =
        await _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME).get();
    num total = 0.0;
    for (final doc in cartItems.docs) {
      num itemsCount = doc.data()[CartItem.ITEM_COUNT_KEY];
      final product = await myFirebaseFireStore.getProductWithID(doc.id);
      total += (itemsCount * product!.price!);
    }
    return total;
  }

  /// 16 -+++++increase Cart ItemCount++++

  Future<bool> increaseCartItemCount(String cartItemID) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollectionRef =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(cartItemID);
    docRef.update({CartItem.ITEM_COUNT_KEY: FieldValue.increment(1)});
    return true;
  }

  /// 17 ----decrease Cart Item Count----

  Future<bool> decreaseCartItemCount(String cartItemID) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final cartCollectionRef =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME);
    final docRef = cartCollectionRef.doc(cartItemID);
    final docSnapshot = await docRef.get();
    int currentCount = docSnapshot.data()![CartItem.ITEM_COUNT_KEY];
    if (currentCount <= 1) {
      return removeProductFromCart(cartItemID);
    } else {
      docRef.update({CartItem.ITEM_COUNT_KEY: FieldValue.increment(-1)});
    }
    return true;
  }

  /// 18 -get all Cart Items List

  Future<List> get allCartItemsList async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final querySnapshot =
        await _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(CART_COLLECTION_NAME).get();
    List itemsId = <String>[];
    for (final item in querySnapshot.docs) {
      itemsId.add(item.id);
    }
    return itemsId;
  }

//19 - get ordered Products List
  Future<List> get orderedProductsList async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final orderedProductsSnapshot = await _firebaseFirestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ORDERED_PRODUCTS_COLLECTION_NAME)
        .get();
    List orderedProductsId = <String>[];
    for (final doc in orderedProductsSnapshot.docs) {
      orderedProductsId.add(doc.id);
    }
    List<String> productsId = [];
    for (var order in orderedProductsId) {
      OrderedProduct orderedProduct = await getOrderedProductFromId(order);
      print('my Order orderedProducts :${orderedProduct.productUid}+${orderedProduct.orderDate}');
      productsId.add(orderedProduct.productUid!);
      print('list of history products in for each${productsId.toString()}');

      // final myProducts = await MyFirebaseFireStore.myFirebaseFireStore.getProductWithID(orderedProduct.productUid!);
    }
    print('list of history products ${productsId.toString()}');
    return productsId;
  }

//20 - add To My Orders

  Future<bool> addToMyOrders(List<OrderedProduct> orders) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final orderedProductsCollectionRef =
        _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).collection(ORDERED_PRODUCTS_COLLECTION_NAME);
    for (final order in orders) {
      await orderedProductsCollectionRef.add(order.toMap());

      await productsCollectionReference.doc(order.productUid).update({
        'enrolled': true,
        ENROLED_USER_PRODUCTS_KEY: FieldValue.arrayUnion([uid])
      });
    }

    return true;
  }

//21 - getOrderedProductFromId

  Future<OrderedProduct> getOrderedProductFromId(String id) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final doc = await _firebaseFirestore
        .collection(USERS_COLLECTION_NAME)
        .doc(uid)
        .collection(ORDERED_PRODUCTS_COLLECTION_NAME)
        .doc(id)
        .get();
    final data = doc.data();
    final orderedProduct = OrderedProduct.fromMap(doc.data()!, id: doc.id);
    return orderedProduct;
  }

  //22 - current UserData Stream

  Stream<DocumentSnapshot> get currentUserDataStream {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    return _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).get().asStream();
  }

  Future<MyUser?> getUserFromFs(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(id).get();
    if (document.data() != null) {
      Map<String, dynamic> userData = document.data()!;
      userData['id'] = document.id;
      MyUser myUser = MyUser.fromMap(userData);
      return myUser;
    }
  }

  Future<MyUser> getMyUserFromFs(String id) async {
    DocumentSnapshot<Map<String, dynamic>> document =
        await _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(id).get();
    Map<String, dynamic> userData = document.data()!;
    userData['id'] = document.id;
    MyUser myUser = MyUser.fromMap(userData);
    return myUser;
  }

//23 - update Phone For Current User

  Future<bool> updatePhoneForCurrentUser(String phone) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDocSnapshot = _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid);
    await userDocSnapshot.update({PHONE_KEY: phone});
    return true;
  }

  String getPathForCurrentUserDisplayPicture() {
    final String currentUserUid = FirebaseAuth.instance.currentUser!.uid;
    return "user/display_picture/$currentUserUid";
  }

//24 - upload Display Picture For Current User

  Future<bool> uploadDisplayPictureForCurrentUser(String url) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDocSnapshot = _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid);
    await userDocSnapshot.update(
      {DP_KEY: url},
    );
    return true;
  }

//25 - remove Display Picture For Current User

  Future<bool> removeDisplayPictureForCurrentUser() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDocSnapshot = _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid);
    await userDocSnapshot.update(
      {
        DP_KEY: FieldValue.delete(),
      },
    );
    return true;
  }

//26 -  Display Picture For Current User

  Future<String> get displayPictureForCurrentUser async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final userDocSnapshot = await _firebaseFirestore.collection(USERS_COLLECTION_NAME).doc(uid).get();
    return userDocSnapshot.data()![DP_KEY];
  }

  /// @
  /// End Database helper for user
  /// */

  /// @
  ///  Start database helper for PRODUCTS
  /// */
  static const String PRODUCTS_COLLECTION_NAME = "products";
  static const String Consulting_COLLECTION_NAME = "consulting";
  static const String REVIEWS_COLLECTOIN_NAME = "reviews";

  Future<List> searchInProducts(String query, {required ProductType productType}) async {
    Query queryRef;
    if (productType == null) {
      queryRef = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    } else {
      final productTypeStr = EnumToString.convertToString(productType);
      print(productTypeStr);
      queryRef = _firebaseFirestore
          .collection(PRODUCTS_COLLECTION_NAME)
          .where(Product.PRODUCT_TYPE_KEY, isEqualTo: productTypeStr);
    }

    Set productsId = Set<String>();
    final querySearchInTags = await queryRef.where(Product.SEARCH_TAGS_KEY, arrayContains: query).get();
    for (final doc in querySearchInTags.docs) {
      productsId.add(doc.id);
    }
    final queryRefDocs = await queryRef.get();
    for (final doc in queryRefDocs.docs) {
      final product = Product.fromMap(doc.data() as Map<String, dynamic>, id: doc.id);
      if (product.title.toString().toLowerCase().contains(query) ||
          product.description.toString().toLowerCase().contains(query) ||
          product.highlights.toString().toLowerCase().contains(query) ||
          product.variant.toString().toLowerCase().contains(query) ||
          product.seller.toString().toLowerCase().contains(query)) {
        productsId.add(product.id);
      }
    }
    return productsId.toList();
  }

  Future<bool> addProductReview(String productId, Review review) async {
    final reviewesCollectionRef =
        _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME).doc(productId).collection(REVIEWS_COLLECTOIN_NAME);
    final reviewDoc = reviewesCollectionRef.doc(review.reviewerUid);
    if ((await reviewDoc.get()).exists == false) {
      reviewDoc.set(review.toMap());
      return await addUsersRatingForProduct(
        productId,
        review.rating!,
        oldRating: 0,
      );
    } else {
      int oldRating = 0;
      oldRating = (await reviewDoc.get()).data()![Product.RATING_KEY];
      reviewDoc.update(review.toUpdateMap());
      return await addUsersRatingForProduct(productId, review.rating!, oldRating: oldRating);
    }
  }

  Future<bool> addUsersRatingForProduct(String productId, int rating, {required int oldRating}) async {
    final productDocRef = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME).doc(productId);
    final ratingsCount = (await productDocRef.collection(REVIEWS_COLLECTOIN_NAME).get()).docs.length;
    final productDoc = await productDocRef.get();
    final prevRating = productDoc.data()![Review.RATING_KEY];
    double newRating;
    if (oldRating == null) {
      newRating = (prevRating * (ratingsCount - 1) + rating) / ratingsCount;
    } else {
      newRating = (prevRating * (ratingsCount) + rating - oldRating) / ratingsCount;
    }
    final newRatingRounded = double.parse(newRating.toStringAsFixed(1));
    await productDocRef.update({Product.RATING_KEY: newRatingRounded});
    return true;
  }

  Future<Review?> getProductReviewWithID(String productId, String reviewId) async {
    final reviewesCollectionRef =
        _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME).doc(productId).collection(REVIEWS_COLLECTOIN_NAME);
    final reviewDoc = await reviewesCollectionRef.doc(reviewId).get();
    if (reviewDoc.exists) {
      return Review.fromMap(reviewDoc.data()!, id: reviewDoc.id);
    }
    return null;
  }

  Stream<List<Review>> getAllReviewsStreamForProductId(String productId) async* {
    final reviewesQuerySnapshot = _firebaseFirestore
        .collection(PRODUCTS_COLLECTION_NAME)
        .doc(productId)
        .collection(REVIEWS_COLLECTOIN_NAME)
        .get()
        .asStream();
    await for (final querySnapshot in reviewesQuerySnapshot) {
      List<Review> reviews = <Review>[];
      for (final reviewDoc in querySnapshot.docs) {
        Review review = Review.fromMap(reviewDoc.data(), id: reviewDoc.id);
        reviews.add(review);
      }
      yield reviews;
    }
  }

  Future<MyProduct>? getProductWithID(String productId) async {
    final docSnapshot = await _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME).doc(productId).get();
    if (docSnapshot.exists) {
      MyProduct product = MyProduct.fromMap(docSnapshot.data()!);
      return product;
    } else {
      return MyProduct(owner_id: '');
    }
  }

  Future<String> addUsersProduct(Product product) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final productMap = product.toMap();
    product.owner = uid;
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final docRef = await productsCollectionReference.add(product.toMap());
    await docRef.update({
      Product.SEARCH_TAGS_KEY: FieldValue.arrayUnion([productMap[Product.PRODUCT_TYPE_KEY].toString().toLowerCase()])
    });
    return docRef.id;
  }

  Future<String> addDesignerProduct(MyProduct product, String category) async {
    product.userType = category;
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final docRef = await productsCollectionReference.add(product.toMap());
    if (docRef != null) {
      ToastMessage.showToast("IS DONE ADD", true);
    } else {
      ToastMessage.showToast("IS failed add", true);
    }

    return docRef.id;
  }

  Future<String> addConsulting(Consulting consulting) async {
    final consultingCollectionReference = _firebaseFirestore.collection(Consulting_COLLECTION_NAME);
    final docRef = await consultingCollectionReference.add(consulting.toMap());
    return docRef.id;
  }

  Future<bool> deleteUserProduct(String productId) async {
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    await productsCollectionReference.doc(productId).delete();
    return true;
  }

  Future<List> getCategoryProductsList(ProductType productType) async {
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final queryResult = await productsCollectionReference
        .where(Product.PRODUCT_TYPE_KEY, isEqualTo: EnumToString.convertToString(productType))
        .get();
    List productsId = <String>[];
    for (final product in queryResult.docs) {
      final id = product.id;
      productsId.add(id);
    }
    return productsId;
  }

  Future<List> get usersProductsList async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final querySnapshot = await productsCollectionReference.where(Product.OWNER_KEY, isEqualTo: uid).get();
    List usersProducts = <String>[];
    querySnapshot.docs.forEach((doc) {
      usersProducts.add(doc.id);
    });
    return usersProducts;
  }

  Future<List> get enrolledProductsList async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final querySnapshot = await productsCollectionReference
        .where(
          Product.OWNER_KEY,
          isEqualTo: uid,
        )
        .where(
          "enrolled",
          isEqualTo: true,
        )
        .get();
    List usersProducts = <String>[];
    querySnapshot.docs.forEach((doc) {
      usersProducts.add(doc.id);
    });
    return usersProducts;
  }

  Future<List> get enrolledUserList async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final querySnapshot = await productsCollectionReference
        .where(
          Product.OWNER_KEY,
          isEqualTo: uid,
        )
        .where(
          "enrolled",
          isEqualTo: true,
        )
        .get();
    List usersProducts = <String>[];
    querySnapshot.docs.forEach((doc) async {
      MyProduct? myProduct = await getProductWithID(doc.id);
      if (myProduct != null) {
        usersProducts = myProduct.enrolledUser!;
      }
    });
    return usersProducts;
  }

  Future<List<MyUser>>? getEnrolledUser(List usersId) async {
    List<MyUser> listUser = [];
    for (var userID in usersId) {
      MyUser user = await getMyUserFromFs(userID);
      listUser.add(user);
    }
    return listUser;
  }

  Future<List> getStageProductsList(String categoryStage) async {
    final productsCollectionReference = _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME);
    final querySnapshot = await productsCollectionReference.where(Product.CATEGORY_KEY, isEqualTo: categoryStage).get();
    List usersProducts = <String>[];
    querySnapshot.docs.forEach((doc) {
      usersProducts.add(doc.id);
    });
    return usersProducts;
  }

  Future<List> get allProductsList async {
    final products = await _firebaseFirestore.collection(PRODUCTS_COLLECTION_NAME).get();
    List productsId = <String>[];
    for (final product in products.docs) {
      final id = product.id;
      productsId.add(id);
    }
    return productsId;
  }

  /// @
  ///  End database helper for PRODUCTS
  /// */

  Future<void> deleteProduct(MyProduct product, String category) async {
    // await _firebaseFirestore.collection("Product").doc(product.id).delete();
    final QuerySnapshot docReference = await categories.where('category', isEqualTo: category).get();
    final result = await categories.doc(docReference.docs[0]['id']).collection('Product').doc(product.id).delete();
    return result;
  }

  Future<void> editProduct(MyProduct product, String category) async {
    final QuerySnapshot docReference = await categories.where('category', isEqualTo: category).get();
    final result =
        await categories.doc(docReference.docs[0]['id']).collection('Product').doc(product.id).update(product.toMap());
    return result;
  }

  Future<String> uploadImage(File file) async {
    String filePath = file.path;
    String fileName = filePath.split('/').last;
    Reference reference = _storage.ref('Product/$fileName');
    await reference.putFile(file);
    String imageUrl = await reference.getDownloadURL();
    return imageUrl;
  }

  //get product list by category
  Future<List<MyProduct>> getOwnerProducts(String category) async {
    String myid = FirebaseAuth.instance.currentUser!.uid;
    List<MyProduct> allProducts = [];
    allProducts = await categories.where('category', isEqualTo: category).get().then((value) {
      value.docs.forEach((queryDocumentSnapshot) {
        DocumentReference? documentReference = queryDocumentSnapshot.data() as DocumentReference;
        documentReference.collection('Product').where('owner_id', isEqualTo: myid).get().then((querySnapshot) {
          return allProducts = querySnapshot.docs.map((e) {
            Map documentMap = e.data();
            documentMap['id'] = e.id;
            MyProduct product = MyProduct.fromMap(documentMap);
            return product;
          }).toList();
        });
      });
      return allProducts;
    });
    return allProducts;
  }
}
