


import '../../data/firebase_firestore.dart';
import 'data_stream.dart';

class StageProductsStream extends DataStream<List<String>> {
   String stageCategory='المرحلة الإعدادية' ;



  @override
  void reload() {
    final usersProductsFuture = MyFirebaseFireStore.myFirebaseFireStore.getStageProductsList(this.stageCategory);
    usersProductsFuture.then((data) {
      addData(data as List<String>);
    }).catchError((e) {
      addError(e);
    });
  }
}
