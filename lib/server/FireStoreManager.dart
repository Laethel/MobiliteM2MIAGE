import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class FireStoreManager {

  /// Singleton
  static final FireStoreManager _singleton = FireStoreManager._internal();

  factory FireStoreManager() {

    return _singleton;
  }

  FireStoreManager._internal();
  /// Fin Singleton

  FirebaseFirestore databaseReference;

  void createRecord() async {

    await Firebase.initializeApp();

    this.databaseReference = FirebaseFirestore.instance;

    await databaseReference.collection("books")
        .doc("1")
        .set({
      'title': 'Mastering Flutter',
      'description': 'Programming Guide for Dart'
    });

    DocumentReference ref = await databaseReference.collection("books")
        .add({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
    print(ref.id);
  }
}