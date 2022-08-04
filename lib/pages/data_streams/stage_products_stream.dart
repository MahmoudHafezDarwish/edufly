


import '../../data/firebase_firestore.dart';
import 'data_stream.dart';

class StageProductsStream extends DataStream<List<String>> {
  @override
  void reload() {
    final usersProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.stageProductsList;
    usersProductsFuture.then((data) {
      addData(data as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
