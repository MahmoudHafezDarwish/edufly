


import '../../data/firebase_firestore.dart';
import 'data_stream.dart';

class AllProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final allProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.allProductsList;
    allProductsFuture.then((favProducts) {
      addData(favProducts as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
