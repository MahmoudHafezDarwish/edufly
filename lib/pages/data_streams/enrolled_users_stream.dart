


import '../../data/firebase_firestore.dart';
import 'data_stream.dart';

class EnrolledUsersStream extends DataStream<List<String>> {
  @override
  void reload() {
    final enrolledProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.enrolledProductsList;
    enrolledProductsFuture.then((data) {
      addData(data as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
