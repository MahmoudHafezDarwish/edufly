import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/AppReview.dart';

class AppReviewDatabaseHelper {
  static const String APP_REVIEW_COLLECTION_NAME = "app_reviews";
  static const String APP_Notes_COLLECTION_NAME = "app_notes";

  AppReviewDatabaseHelper._privateConstructor();

  static AppReviewDatabaseHelper _instance = AppReviewDatabaseHelper._privateConstructor();

  factory AppReviewDatabaseHelper() {
    return _instance;
  }

  FirebaseFirestore? _firebaseFirestore;

  FirebaseFirestore get firestore {
    if (_firebaseFirestore == null) {
      _firebaseFirestore = FirebaseFirestore.instance;
    }
    return _firebaseFirestore!;
  }

  Future<bool> editAppReview(AppReview appReview) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = firestore.collection(APP_REVIEW_COLLECTION_NAME).doc(uid);
    final docData = await docRef.get();
    if (docData.exists) {
      docRef.update(appReview.toUpdateMap());
    } else {
      docRef.set(appReview.toMap());
    }
    return true;
  }

  Future<bool> editNotesAppReview(AppReview appReview) async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = firestore.collection(APP_Notes_COLLECTION_NAME).doc(uid);
    final docData = await docRef.get();
    docRef.set(appReview.toMap());

    return true;
  }

  Future<AppReview> getAppReviewOfCurrentUser() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final docRef = firestore.collection(APP_REVIEW_COLLECTION_NAME).doc(uid);
    final docData = await docRef.get();
    if (docData.exists) {
      final appReview = AppReview.fromMap(docData.data()!, id: docData.id);
      return appReview;
    } else {
      final appReview = AppReview(uid, liked: true, feedback: "");
      docRef.set(appReview.toMap());
      return appReview;
    }
  }
}
