


import '../../data/firebase_firestore.dart';
import '../../models/modelsFirebase/Product.dart';
import 'data_stream.dart';

class CategoryProductsStream extends DataStream<List<String>> {
  final ProductType category;

  CategoryProductsStream(this.category);
  @override
  void reload() {
    final allProductsFuture =
    MyFirebaseFireStore.myFirebaseFireStore.getCategoryProductsList(category!);
    allProductsFuture.then((favProducts) {
      addData(favProducts as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
