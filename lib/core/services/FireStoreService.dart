import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';

class FireStoreService {

  FirebaseFirestore _db;
  final String path;
  CollectionReference ref;

  FireStoreService(this.path) {

    Firebase.initializeApp();

    this._db = FirebaseFirestore.instance;
    ref = _db.collection(path);
  }

  Future<QuerySnapshot> getDataCollection() {
    return ref.get() ;
  }

  Stream<QuerySnapshot> streamDataCollection() {
    return ref.snapshots() ;
  }

  Future<DocumentSnapshot> getDocumentById(String id) {
    return ref.doc(id).get();
  }

  Future<void> removeDocument(String id){
    return ref.doc(id).delete();
  }

  Future<DocumentReference> addDocument(Map data) {
    return ref.add(data);
  }

  Future<void> updateDocument(Map data , String id) {
    return ref.doc(id).update(data) ;
  }
}